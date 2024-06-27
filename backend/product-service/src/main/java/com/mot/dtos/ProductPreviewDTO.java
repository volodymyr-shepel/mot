package com.mot.dtos;

import java.util.UUID;

public record ProductPreviewDTO(
        UUID id,
        String name,
        Double price,
        Integer quantity,
        String imageUrl

) {

}
