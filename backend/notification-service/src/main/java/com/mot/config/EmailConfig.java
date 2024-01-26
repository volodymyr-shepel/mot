package com.mot.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class EmailConfig {
    @Value("${rabbitmq.exchanges.internal}")
    private String internalExchange;

    @Value("${rabbitmq.queues.email}")
    private String emailQueue;

    @Value("${rabbitmq.queues.order}")
    private String orderQueue;

    @Value("${rabbitmq.routing-keys.internal-email}")
    private String internalEmailRoutingKey;

    @Value("${rabbitmq.routing-keys.internal-order}")
    private String internalOrderRoutingKey;

    @Bean
    public TopicExchange internalTopicExchange(){
        return new TopicExchange(this.internalExchange);
    }

    @Bean
    public Queue emailQueue(){
        return new Queue(this.emailQueue);
    }


    @Bean
    public Queue orderQueue(){
        return new Queue(this.orderQueue);
    }

    @Bean
    public Binding internalToEmailBinding(){
        return BindingBuilder
                .bind(emailQueue())
                .to(internalTopicExchange())
                .with(this.internalEmailRoutingKey);
    }

    @Bean
    public Binding internalToOrderBinding(){
        return BindingBuilder
                .bind(orderQueue())
                .to(internalTopicExchange())
                .with(this.internalOrderRoutingKey);
    }


    public String getInternalExchange() {
        return internalExchange;
    }

    public String getEmailQueue() {
        return emailQueue;
    }

    public String getInternalEmailRoutingKey() {
        return internalEmailRoutingKey;
    }
}
