package com.mot.dtos;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.mot.model.Order;
import com.mot.model.OrderItem;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class OrderItemDTO {
        @JsonBackReference
        private OrderDTO order;
        private UUID productId;
        private Integer quantity;
        private BigDecimal price;
        private LocalDateTime createdOn;

        public OrderItemDTO(ProductDTO productDTO) {
    //            this.id = orderItem.getId();
            this.productId = productDTO.id();
            this.quantity = productDTO.quantity();
            this.price = BigDecimal.valueOf(productDTO.price());
            this.createdOn = productDTO.createdOn();
            this.order = null;
        }

        public OrderItemDTO(OrderItem orderItem, boolean hasParent) {
//            this.id = orderItem.getId();
            this.productId = orderItem.getProductId();
            this.quantity = orderItem.getQuantity();
            this.price = orderItem.getPrice();
            this.createdOn = orderItem.getCreatedOn();
            this.order = hasParent ? OrderDTO.getOrderDTO(orderItem.getOrderOfItem()): null;
        }

        public static OrderItemDTO getItem(OrderItem orderItem, OrderDTO order) {
            OrderItemDTO orderItemDTO = new OrderItemDTO(orderItem, false);
            orderItemDTO.setOrder(order);
            return orderItemDTO;
        }

    public static OrderItem getItem(OrderItemDTO orderItem, Order order) {
        OrderItem orderItemDTO = new OrderItem(orderItem, false);
        orderItemDTO.setOrderOfItem(order);
//        orderItemDTO.setOrder(OrderDTO.getOrder(
//                orderItem.getOrder().getEmail(),
//                orderItem.getOrder().getAddress(),
//                orderItem.getOrder().getItems(),
//                orderItem.getOrder().getTotalPrice(),
//                orderItem.getOrder().getCreatedOn(),
//                orderItem.getOrder().getUpdatedOn()
//        ));
        return orderItemDTO;
    }

}
