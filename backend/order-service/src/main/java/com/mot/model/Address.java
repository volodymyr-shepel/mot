package com.mot.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Setter
@Getter
@Entity
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private UUID id;

    private String addressLine1;

    private String addressLine2;

    private String city;

    private String country;

    private String postalCode;

    private LocalDateTime createdOn;
    public Address() {}
}
