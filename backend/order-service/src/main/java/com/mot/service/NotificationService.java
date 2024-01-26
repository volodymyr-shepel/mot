package com.mot.service;

import com.mot.amqp.RabbitMQMessageProducer;
import com.mot.dtos.SendNotificationDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
    @Value("${app.rabbitmq.internal-exchange}")
    private String internalExchange;

    @Value("${app.rabbitmq.order-routing-key}")
    private String orderRoutingKey;

    private final RabbitMQMessageProducer rabbitMQMessageProducer;

    public NotificationService(RabbitMQMessageProducer rabbitMQMessageProducer) {
        this.rabbitMQMessageProducer = rabbitMQMessageProducer;
    }

    public void publishNotification(SendNotificationDTO notification){
        rabbitMQMessageProducer.publish(
                notification,
                internalExchange,
                orderRoutingKey
        );
    }
}
