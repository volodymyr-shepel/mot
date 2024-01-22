package com.mot.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.mot.dtos.OrderDTO;
import com.mot.dtos.OrderItemDTO;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Setter
@Getter
@Entity
public class OrderItem {

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(name = "order_item_id")
    private UUID id;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order orderOfItem;

    private UUID productId;

    private Integer quantity;

    private BigDecimal price;

    private LocalDateTime createdOn;

    public OrderItem(OrderItemDTO orderItem, boolean setOrder) {
        if (setOrder)
            orderOfItem = OrderDTO.getOrder(
                    orderItem.getOrder().getEmail(),
                    orderItem.getOrder().getThreadId(),
                    orderItem.getOrder().getAddress(),
                    orderItem.getOrder().getItems(),
                    orderItem.getOrder().getTotalPrice(),
                    orderItem.getOrder().getCreatedOn(),
                    orderItem.getOrder().getUpdatedOn()
            );
        productId = orderItem.getProductId();
        quantity = orderItem.getQuantity();
        price = orderItem.getPrice();
        createdOn = orderItem.getCreatedOn();
    }

    public OrderItem() {

    }
}
