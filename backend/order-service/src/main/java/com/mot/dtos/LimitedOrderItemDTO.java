package com.mot.dtos;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class LimitedOrderItemDTO {
    @NotNull
    @org.hibernate.validator.constraints.UUID
    private UUID productId;

    @NotNull
    @Size(min = 1)
    private Integer quantity;

    public LimitedOrderItemDTO() {}

    public LimitedOrderItemDTO(UUID uuid, int i) {
        productId = uuid;
        quantity = i;
    }
}
