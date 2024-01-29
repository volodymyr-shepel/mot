package com.mot.models;

import com.mot.dtos.CreateThreadDTO;
import com.mot.util.NotificationType;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Thread {
    @Id
    @GeneratedValue
    private UUID id;


    private String title;

    private UUID recipientUserId;

    private String recipientEmail;

    @Enumerated(EnumType.STRING)
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

    public Thread(CreateThreadDTO createThreadDTO) {
        this.title = createThreadDTO.title();
        this.recipientEmail = createThreadDTO.email();
        this.recipientUserId = createThreadDTO.userId();
        this.notificationType = createThreadDTO.notificationType();
        this.createdOn = LocalDateTime.now();
        this.updatedOn = LocalDateTime.now();
    }

    public static Thread of(CreateThreadDTO threadDTO) {
        return new Thread(threadDTO);
    }
}
