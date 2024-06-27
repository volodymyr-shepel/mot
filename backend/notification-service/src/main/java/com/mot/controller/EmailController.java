package com.mot.controller;


import com.mot.dtos.AnonymousNotificationDTO;
import com.mot.dtos.SendNotificationDTO;
import com.mot.dtos.CreateThreadDTO;
import com.mot.service.NotificationService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@Slf4j
@RequestMapping("api/email")
public class EmailController {

    private final NotificationService notificationService;

    @Autowired
    public EmailController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @PostMapping(path = "sendEmail")
    public void sendEmail(@RequestBody AnonymousNotificationDTO emailRequest) {
        notificationService.sendNotification(emailRequest);
    }

    @PostMapping(path = "createNotification")
    public void sendNotification(@Valid @RequestBody SendNotificationDTO emailRequest) {
        log.info("here we are");
        notificationService.sendNotification(emailRequest);
    }

    @PostMapping(path = "createThread")
    public @ResponseBody ResponseEntity<UUID> createThread(@Valid @RequestBody CreateThreadDTO thread) {
        log.info("here we are");
        return ResponseEntity.ok().body(notificationService.createThread(thread));
    }
}
