package com.mot.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Setter
@Getter
@Entity
public class Address {
    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(name = "address_id", columnDefinition = "uuid")
    private UUID id;

    @OneToOne(mappedBy = "orderAddress")
    private Order addressOrder;

    @Column(columnDefinition = "TEXT")
    private String addressLine1;

    @Column(columnDefinition = "TEXT")
    private String addressLine2;

    @Column(columnDefinition = "TEXT")
    private String city;

    @Column(columnDefinition = "TEXT")
    private String country;

    @Column(columnDefinition = "TEXT")
    private String postalCode;

    @Column
    private LocalDateTime createdOn;
    public Address(String addressLine1, String addressLine2, String city, String country, String postalCode, LocalDateTime createdOn) {
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.city = city;
        this.country = country;
        this.postalCode = postalCode;
        this.createdOn = createdOn;
    }

    public Address() {}
}
