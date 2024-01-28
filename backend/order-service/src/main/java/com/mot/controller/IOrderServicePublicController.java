package com.mot.controller;

import com.mot.dtos.OrderDTO;
import com.mot.dtos.PlaceOrderDTO;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

public interface IOrderServicePublicController {
    @GetMapping(path = "/get/id/{orderId}")
    OrderDTO getProductById(@PathVariable UUID orderId);

    @CrossOrigin
    @PostMapping(path = "/place-order")
    UUID getProductsByCategory(@RequestBody PlaceOrderDTO placeOrderDTO);
}
