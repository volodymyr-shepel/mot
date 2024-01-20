package com.mot.dtos;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.UUID;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record UpdateProductDTO(
        @JsonProperty("id")
        UUID id,
        @JsonProperty("quantity")
        Integer quantity
) {
}
