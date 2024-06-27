package com.mot.rabbitmq;


import com.mot.dtos.AnonymousNotificationDTO;
import com.mot.dtos.SendNotificationDTO;
import com.mot.service.NotificationService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmailConsumer {
    private final NotificationService notificationService;

    @Autowired
    public EmailConsumer(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @RabbitListener(queues = "${rabbitmq.queues.email}")
    public void consumer(AnonymousNotificationDTO notification){
        notificationService.sendNotification(notification);

    }

    @RabbitListener(queues = "${rabbitmq.queues.order}")
    public void consume(SendNotificationDTO notification){
        notificationService.sendNotification(notification);

    }
}
