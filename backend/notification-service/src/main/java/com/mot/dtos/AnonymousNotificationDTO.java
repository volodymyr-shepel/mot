package com.mot.dtos;

import com.mot.models.Thread;
import com.mot.util.NotificationType;

import java.util.Map;

public record AnonymousNotificationDTO(
    String recipient,
    String subject,
    NotificationType notificationType,
    Map<String, String> notificationFields
) {
    public static AnonymousNotificationDTO of(Thread thread, SendNotificationDTO notification) {
        return new AnonymousNotificationDTO(
                thread.getRecipientEmail(),
                thread.getTitle(),
                thread.getNotificationType(),
                notification.notificationFields()
        );
    }
}

