package com.mot.dtos;

import com.mot.util.UserRole;

public record AppUserDTO(String email,
                         String firstName,
                         String lastName,
                         String password,
                         UserRole userRole) {
}

