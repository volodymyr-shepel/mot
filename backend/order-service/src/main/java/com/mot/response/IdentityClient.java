package com.mot.response;


import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.UUID;

@FeignClient(name="identity-service", url = "${app.base-url}", path = "/api/identity/v1")
public interface IdentityClient {
    @GetMapping("/check-user/{id}")
    public boolean isUserExist(@PathVariable("id") UUID id);
}
