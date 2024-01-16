package com.mot.dtos;

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
    private UUID id;
    private UUID userId;
    private UUID threadId;
    private AddressDTO address;

    private List<OrderItemDTO> items;
    private BigDecimal totalPrice;
    private LocalDateTime createdOn;
    private LocalDateTime updatedOn;

    //RETURNS ORDER DTO WITHOUT CHILDREN
    public OrderDTO(Order order) {
        this.id = order.getId();
        this.userId = order.getUserId();
        this.threadId = order.getThreadId();
        this.address = AddressDTO.getAddressDTO(order.getAddress());
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
                order.getOrderItem()
                .stream()
                .map(orderItem -> OrderItemDTO.getItem(orderItem, orderDTO))
                .toList()
        );
        return orderDTO;
    }
}
