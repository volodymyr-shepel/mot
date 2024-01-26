package com.mot.dtos;

import java.util.UUID;

public record ProductQuantityDTO (
        UUID id,
        Integer quantity
){
}
