package com.mot.dtos;

import java.util.List;

public record PlaceOrderDTO (String userEmail,
                             AddressDTO address,
                             List<LimitedOrderItemDTO> items ) {}
