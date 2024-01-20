package com.mot.service.identity;

import com.mot.model.AppUser;
import com.mot.repository.AppUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class IdentityServiceImpl implements IdentityService {

    private final AppUserRepository appUserRepository;

    @Autowired
    public IdentityServiceImpl(AppUserRepository appUserRepository) {
        this.appUserRepository = appUserRepository;
    }

    public boolean isUserByIdIsValid(UUID uuid) {
        return appUserRepository.isAppUserByIdExists(uuid);
    }

    public boolean isUserByEmailIsValid(String email) {
        return appUserRepository.existsByEmail(email);
    }
}
