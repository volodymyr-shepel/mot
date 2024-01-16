package com.mot.controller;


import com.mot.dtos.NotificationDTO;
import com.mot.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/email")
public class EmailController {

    private final NotificationService notificationService;

    @Autowired
    public EmailController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @PostMapping(path = "sendEmail")
    public void sendEmail(@RequestBody NotificationDTO emailRequest){
        notificationService.sendNotification(emailRequest);
    }
}
