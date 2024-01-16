package com.mot.models;


import com.mot.util.NotificationStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
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
}
