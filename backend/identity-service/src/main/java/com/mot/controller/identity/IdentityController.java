package com.mot.controller.identity;

import com.mot.service.identity.IdentityService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping(path = "/api/identity/v1")
public class IdentityController {

    private IdentityService identityService;

    IdentityController(IdentityService identityService) {
        this.identityService = identityService;
    }

    @GetMapping(path = "/check-user")
    public boolean isUserExist(@RequestParam("id") String uuid) {
        return identityService.isUserByIdIsValid(UUID.fromString(uuid));
    }
}
