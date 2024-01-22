package com.mot.dtos;

import jakarta.validation.constraints.NotNull;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public record SendNotificationDTO(
        @NotNull
        UUID threadId,
        @NotNull
        Map<String, String> notificationFields
) {


        public static SendNotificationDTO ofOrder(UUID threadId, HashMap<String, String> notificationFields) {
                return new SendNotificationDTO(threadId, notificationFields);
        }
}
