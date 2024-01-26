package com.mot.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/order/admin")
public class OrderServiceAdminController {

    @GetMapping(path = "/test")
    public String test(){
        return "ADMIN SUCCESS";
    }
}
