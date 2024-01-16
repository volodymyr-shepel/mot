package com.mot.dtos;

import com.mot.model.Address;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class AddressDTO {
    private UUID id;

    private String addressLine1;

    private String addressLine2;

    private String city;

    private String country;

    private String postalCode;

    private LocalDateTime createdOn;
    public AddressDTO() {}

    public AddressDTO(Address address) {
        this.id = address.getId();
        this.addressLine1 = address.getAddressLine1();
        this.addressLine2 = address.getAddressLine2();
        this.city = address.getCity();
        this.country = address.getCountry();
        this.postalCode = address.getPostalCode();
        this.createdOn = address.getCreatedOn();
    }

    public static AddressDTO getAddressDTO(Address address) {
        return new AddressDTO(address);
    }
}
