package com.mot.models;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mot.dtos.SendNotificationDTO;
import com.mot.util.NotificationStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Notification {

    @Id
    @GeneratedValue
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "thread_id") // This is the foreign key column in the Notification table
    private Thread thread;

    private String message;

    private NotificationStatus notificationStatus;

    @NotNull
    private LocalDateTime createdOn;

    @NotNull
    private LocalDateTime updatedOn;

    public Notification(SendNotificationDTO notificationDTO, Thread currentThread) throws JsonProcessingException {
        thread = currentThread;
        message = new ObjectMapper().writeValueAsString(notificationDTO.notificationFields());
        notificationStatus = NotificationStatus.PENDING;
        createdOn = LocalDateTime.now();
        updatedOn = LocalDateTime.now();
    }

    public static Notification of(SendNotificationDTO notification, Thread thread) throws JsonProcessingException {
        return new Notification(notification, thread);
    }
}
