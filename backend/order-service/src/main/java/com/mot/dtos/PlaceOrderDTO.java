package com.mot.dtos;

import java.util.List;

public record PlaceOrderDTO (String userEmail,
                             String firstName,
														 String lastName,
                             AddressDTO address,
                             List<LimitedOrderItemDTO> items ) {}
