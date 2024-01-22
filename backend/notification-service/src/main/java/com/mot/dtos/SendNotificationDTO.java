package com.mot.dtos;

import jakarta.validation.constraints.NotNull;

import java.util.Map;
import java.util.UUID;

public record SendNotificationDTO(
    @NotNull
    UUID threadId,
    @NotNull
    Map<String, String> notificationFields
) { }
