package com.mot.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.UUID;

@Setter
@Getter
@Entity
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private UUID id;

    private UUID userId;

    private UUID threadId;

    @OneToOne(mappedBy = "address", cascade = CascadeType.ALL)
    private Address address;

    @JsonManagedReference
    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private ArrayList<OrderItem> orderItem;

    private BigDecimal totalPrice;

    private LocalDateTime createdOn;

    private LocalDateTime updatedOn;

    public Order() {}
}
