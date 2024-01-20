package com.mot.controller.identity;

import com.mot.service.identity.IdentityService;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping(path = "/api/identity/v1")
public class IdentityController {

    private final IdentityService identityService;

    IdentityController(IdentityService identityService) {
        this.identityService = identityService;
    }

    @GetMapping(path = "/check-user/{id}")
    public boolean isUserExist(@PathVariable("id") UUID uuid) {
        return identityService.isUserByIdIsValid(uuid);
    }

    @GetMapping(path = "/check-user/by-email/{email}")
    public boolean isUserExistByEmail(@PathVariable("email") String email) {
        return identityService.isUserByEmailIsValid(email);
    }
}
