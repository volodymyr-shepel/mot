package com.mot.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mot.dtos.OrderItemDTO;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Setter
@Getter
@Entity
@Table(name = "order_table")
public class Order {
    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(name = "order_id")
    private UUID id;

    private String email;

    private UUID threadId;

    @OneToOne(cascade = CascadeType.ALL)//(mappedBy = "address", cascade = CascadeType.ALL)
    @JoinColumn(name = "address_id")
    private Address orderAddress;

    @JsonManagedReference
    @OneToMany(mappedBy = "orderOfItem", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;

    private BigDecimal totalPrice;

    private LocalDateTime createdOn;

    private LocalDateTime updatedOn;

    public Order() {}

    public Order(String email, UUID threadId, Address orderAddress, List<OrderItemDTO> items, BigDecimal totalPrice, LocalDateTime createdOn, LocalDateTime updatedOn) {
        this.email = email;
        this.threadId = threadId;
        this.orderAddress = orderAddress;
        this.orderItems = items.stream().map(item -> OrderItemDTO.getItem(item, this)).collect(Collectors.toCollection(ArrayList::new));
        this.totalPrice = totalPrice;
        this.createdOn = createdOn;
        this.updatedOn = updatedOn;
    }
}
