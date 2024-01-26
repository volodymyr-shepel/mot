package com.mot.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/order/customer")
public class OrderServiceCustomerController {

    @GetMapping(path = "/test")
    public String test(){
        return "CUSTOMER SUCCESS";
    }
}
