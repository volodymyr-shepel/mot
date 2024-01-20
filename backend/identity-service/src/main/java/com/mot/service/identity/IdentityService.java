package com.mot.service.identity;

import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public interface IdentityService {
    public boolean isUserByIdIsValid(UUID uuid);

    boolean isUserByEmailIsValid(String email);
}
