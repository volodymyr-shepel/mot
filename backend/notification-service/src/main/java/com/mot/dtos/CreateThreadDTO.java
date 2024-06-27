package com.mot.dtos;

import com.mot.util.NotificationType;
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
) { }
