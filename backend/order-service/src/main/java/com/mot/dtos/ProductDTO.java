package com.mot.dtos;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

public record ProductDTO(
        UUID id,
        String sku,
        String name,
        String description,
        Map<String, String> specification,
        Integer quantity,
        Double price,
        String imageUrl,
        LocalDateTime createdOn,
        LocalDateTime updatedOn,
        Integer categoryId
) {}

