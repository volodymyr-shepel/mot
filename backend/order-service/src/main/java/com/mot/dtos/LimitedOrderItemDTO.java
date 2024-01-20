package com.mot.dtos;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
public class LimitedOrderItemDTO {
    private UUID productId;
    private Integer quantity;

    public LimitedOrderItemDTO() {}
}
