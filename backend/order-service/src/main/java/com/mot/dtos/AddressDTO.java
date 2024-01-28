package com.mot.dtos;

import com.mot.model.Address;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class AddressDTO {
    @Nullable
    private String addressLine1;

    @Nullable
    private String addressLine2;

    @NotNull
    @Size(min = 2, message = "Name size too short!")
    @Size(min = 2000, message = "Name size too long!")
    private String city;

    @NotNull
    @Size(min = 2, message = "Name size too short!")
    @Size(min = 1000, message = "Name size too long!")
    private String country;

    @NotNull
    @Size(min = 5, message = "Name size too short!")
    @Size(min = 10, message = "Name size too long!")
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

    public AddressDTO(@Nullable String addressLine1, @Nullable String addressLine2, String city, String country, String postalCode, @Nullable LocalDateTime createdOn) {
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.city = city;
        this.country = country;
        this.postalCode = postalCode;
        this.createdOn = createdOn;
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
