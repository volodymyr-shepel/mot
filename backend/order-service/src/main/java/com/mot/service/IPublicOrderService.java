package com.mot.service;

import com.mot.dtos.AddressDTO;
import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.dtos.OrderDTO;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.UUID;

public interface IPublicOrderService {
    @Transactional
    UUID placeOrder(String userEmail, AddressDTO address, List<LimitedOrderItemDTO> items);

    OrderDTO getOrderById(UUID orderId);
}
