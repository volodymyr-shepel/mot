package com.mot.dtos;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.util.List;

public record PlaceOrderDTO (@NotNull @Email String userEmail,
							 @Nullable String firstName,
							 @Nullable String lastName,
							 @NotNull AddressDTO address,
							 @NotNull List<LimitedOrderItemDTO> items ) {}
