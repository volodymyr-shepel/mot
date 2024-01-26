package com.mot.dtos;

import com.mot.model.Address;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.lang.Nullable;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class AddressDTO {

    private String addressLine1;

    private String addressLine2;

    private String city;

    private String country;

    private String postalCode;

    @Nullable
    private LocalDateTime createdOn;

    public AddressDTO(Address address) {
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

    public static Address getAddress(AddressDTO address) {
        return new Address(
                address.addressLine1,
                address.addressLine2,
                address.city,
                address.country,
                address.postalCode,
                address.createdOn
        );
    }
}
