package com.mot.dtos;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mot.model.Order;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
public class OrderDTO {
    private UUID orderId;
    private String email;
    private UUID threadId;
    private AddressDTO address;

    @JsonManagedReference
    private List<OrderItemDTO> items;
    private BigDecimal totalPrice;
    private LocalDateTime createdOn;
    private LocalDateTime updatedOn;

    public OrderDTO(String email, UUID threadId, AddressDTO address, List<OrderItemDTO> items, BigDecimal totalPrice, LocalDateTime createdOn, LocalDateTime updatedOn) {
        this.email = email;
        this.threadId = threadId;
        this.address = address;
        this.totalPrice = totalPrice;
        this.createdOn = createdOn;
        this.updatedOn = updatedOn;
        this.items = items;
    }

    //RETURNS ORDER DTO WITHOUT CHILDREN
    public OrderDTO(Order order) {
        this.orderId = order.getId();
        this.email = order.getEmail();
        this.threadId = order.getThreadId();
        this.address = AddressDTO.getAddressDTO(order.getOrderAddress());
        this.totalPrice = order.getTotalPrice();
        this.createdOn = order.getCreatedOn();
        this.updatedOn = order.getUpdatedOn();
        this.items = new ArrayList<>();
    }

    public static OrderDTO getOrderDTO(Order order) {
        return new OrderDTO(order);
    }


    public static OrderDTO getOrderWithChildrenDTO(Order order) {
        OrderDTO orderDTO = new OrderDTO(order);
        orderDTO.setItems(
                order.getOrderItems()
                .stream()
                .map(orderItem -> OrderItemDTO.getItem(orderItem, orderDTO))
                .toList()
        );
        return orderDTO;
    }

    public static Order getOrder(String email, UUID threadId, AddressDTO address, List<OrderItemDTO> items, BigDecimal totalPrice, LocalDateTime createdOn, LocalDateTime updatedOn) {
        return new Order(email, threadId, AddressDTO.getAddress(address), items, totalPrice, createdOn, updatedOn);
    }
}
