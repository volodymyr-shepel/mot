package com.mot.service;

import com.mot.dtos.*;
import com.mot.model.*;
import com.mot.repository.*;
import com.mot.response.*;
import com.mot.service.chain.handler.ChainLink;
import com.mot.util.ChainHelper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class PublicOrderService {

    Logger logger = LoggerFactory.getLogger(PublicOrderService.class);

    private final OrderRepository orderRepository;

    private final OrderItemRepository orderItemRepository;

    private final AddressRepository addressRepository;

    private final IdentityClient identityClient;

    private final AuthenticationClient authenticationClient;

    private final ProductClient productClient;

    @Autowired
    public PublicOrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository, AddressRepository addressRepository,
                              IdentityClient identityClient, AuthenticationClient auth, ProductClient productClient) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.addressRepository = addressRepository;
        this.identityClient = identityClient;
        this.authenticationClient = auth;
        this.productClient = productClient;
    }

    public OrderDTO getOrderById(UUID orderId) {
        Optional<Order> orderOptional = orderRepository.findById(orderId);
        Order order = orderOptional.orElse(null);
        return order != null ? OrderDTO.getOrderWithChildrenDTO(order) : null;
    }

    /**
     * Verifies user, checks product quantity, creates notification thread, creates order and starts order execution
     */
    @Transactional
    public UUID placeOrder(String userEmail, AddressDTO address, List<LimitedOrderItemDTO> items) {
        validateInputsOrThrowError(userEmail, address, items);

        List<OrderItemDTO> orderItems = getOrderItems(items);

        Order order = createOrder(userEmail, address, orderItems, calculatePrice(orderItems));

        sendUpdateToProductService(orderItems);

        orderRepository.saveAndFlush(order);

        //sendNotification
        return order.getId();
    }

    private void sendUpdateToProductService(List<OrderItemDTO> orderItems) {
        if (!productClient.updateProductQuantity(
                orderItems.stream().map(order -> new UpdateProductDTO(order.getProductId(), order.getQuantity())).collect(Collectors.toList())
        )) {
            throw new NoSuchElementException("Quantity check failed!");
        }
    }

    private Order createOrder(String userEmail, AddressDTO address, List<OrderItemDTO> orderItems, BigDecimal totalPrice) {
        return OrderDTO.getOrder(userEmail, address, orderItems, totalPrice, LocalDateTime.now(), LocalDateTime.now());
    }

    private static BigDecimal calculatePrice(List<OrderItemDTO> orderItems) {
        return orderItems.stream()
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private List<OrderItemDTO> getOrderItems(List<LimitedOrderItemDTO> items) {
        return items.stream()
                .map(item -> {
                    ProductDTO temp = productClient.getProductById(item.getProductId());
                    return new ProductDTO(
                            temp.id(),
                            temp.sku(),
                            temp.name(),
                            temp.description(),
                            temp.specification(),
                            item.getQuantity(),
                            temp.price(),
                            temp.imageUrl(),
                            temp.createdOn(),
                            temp.updatedOn(),
                            temp.categoryId()
                    );
                })
                .map(OrderItemDTO::new)
                .collect(Collectors.toList());
    }

    private void validateInputsOrThrowError(String userEmail, AddressDTO address, List<LimitedOrderItemDTO> items) {
        ChainLink chain = ChainHelper.validationChain(identityClient, authenticationClient, userEmail, address, items, productClient, new HashMap<>());

        chain.handle();

        if (!chain.getErrors().isEmpty())
            throw new EntityNotFoundException(getMessage(chain).toString());
    }

    private static StringBuilder getMessage(ChainLink chain) {
        StringBuilder message = new StringBuilder();
        chain.getErrors().forEach((key, value) -> {
            message.append(key);
            message.append(": ");
            message.append(value);
            message.append("\n");

        });
        return message;
    }

}
