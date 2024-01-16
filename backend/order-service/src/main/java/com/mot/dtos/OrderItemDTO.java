package com.mot.dtos;

import com.mot.model.OrderItem;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class OrderItemDTO {
        private UUID id;
        private OrderDTO order;
        private UUID productId;
        private Long quantity;
        private BigDecimal price;
        private LocalDateTime createdOn;

        public OrderItemDTO(OrderItem orderItem, boolean hasParent) {
            this.id = orderItem.getId();
            this.productId = orderItem.getProductId();
            this.quantity = orderItem.getQuantity();
            this.price = orderItem.getPrice();
            this.createdOn = orderItem.getCreatedOn();
            this.order = hasParent ? OrderDTO.getOrderDTO(orderItem.getOrder()): null;
        }

        public static OrderItemDTO getItem(OrderItem orderItem, OrderDTO order) {
            OrderItemDTO orderItemDTO = new OrderItemDTO(orderItem, false);
            orderItemDTO.setOrder(order);
            return orderItemDTO;
        }
}
