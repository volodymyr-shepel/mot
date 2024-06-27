package com.mot.controller.admin;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/product/admin/v1")
public class AdminController {

    @GetMapping(path = "/test")
    public String test(){
        return "ADMIN SUCCESS";
    }
}
