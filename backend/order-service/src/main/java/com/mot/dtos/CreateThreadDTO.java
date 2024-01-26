package com.mot.dtos;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record CreateThreadDTO(
        @NotNull
        String title,
        @Nullable
        UUID userId,
        @NotNull
        @Email
        String email,
        NotificationType notificationType
) {

    public static CreateThreadDTO ofOrder(String userEmail) {
        return new CreateThreadDTO("Order", null, userEmail, NotificationType.EMAIL_VERIFICATION);
    }
}
