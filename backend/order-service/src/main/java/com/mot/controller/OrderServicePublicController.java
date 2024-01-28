package com.mot.controller;

import com.mot.dtos.*;
import com.mot.service.IPublicOrderService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.UUID;

@RestController
@RequestMapping(path = "/api/order/public/v1")
public class OrderServicePublicController implements IOrderServicePublicController {

    private final IPublicOrderService publicOrderService;
    
    public OrderServicePublicController(IPublicOrderService publicOrderService) {
        this.publicOrderService = publicOrderService;
    }

    @Override
    @GetMapping(path = "/get/id/{orderId}")
    public OrderDTO getProductById(@PathVariable UUID orderId) {
        return publicOrderService.getOrderById(orderId);
    }

    @Override
    @CrossOrigin
    @PostMapping(path = "/place-order")
    public UUID getProductsByCategory(@RequestBody PlaceOrderDTO placeOrderDTO){
        return publicOrderService.placeOrder(placeOrderDTO.userEmail(), placeOrderDTO.address(), placeOrderDTO.items());
    }

}
