package com.mot.models;

import com.mot.util.NotificationType;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
public class Thread {
    @Id
    @GeneratedValue
    private UUID id;


    private String title;

    private UUID recipientUserId;

    private String recipientEmail;

    private NotificationType notificationType;
    @NotNull
    private LocalDateTime createdOn;

    @NotNull
    private LocalDateTime updatedOn;

    @OneToMany(mappedBy = "thread", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Notification> notifications = new ArrayList<>();


    public Thread(String title,
                  UUID recipientUserId,
                  String recipientEmail,
                  NotificationType notificationType,
                  LocalDateTime createdOn,
                  LocalDateTime updatedOn) {

        this.title = title;
        this.recipientUserId = recipientUserId;
        this.recipientEmail = recipientEmail;
        this.notificationType = notificationType;
        this.createdOn = createdOn;
        this.updatedOn = updatedOn;
    }

    public Thread(){

    }
}
