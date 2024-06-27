package com.mot.controller.config;

import org.springframework.amqp.AmqpException;
import org.springframework.amqp.rabbit.connection.Connection;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class TestConfig {

//    @Bean
//    public JwtUtilOrder jwtUtilOrder() {
//        // You can create and configure a mock or test version of JwtUtilOrder
//        return new JwtUtilOrder();
//    }

    @Bean
    public WebClient.Builder webClientBuilder() {
        return WebClient.builder();
    }

    @Bean
    public ConnectionFactory connectionFactory(){
        return new ConnectionFactory() {
            @Override
            public Connection createConnection() throws AmqpException {
                return null;
            }

            @Override
            public String getHost() {
                return null;
            }

            @Override
            public int getPort() {
                return 0;
            }

            @Override
            public String getVirtualHost() {
                return null;
            }

            @Override
            public String getUsername() {
                return null;
            }

            @Override
            public void addConnectionListener(ConnectionListener connectionListener) {

            }

            @Override
            public boolean removeConnectionListener(ConnectionListener connectionListener) {
                return false;
            }

            @Override
            public void clearConnectionListeners() {

            }
        };
    }
//    @Bean
//    public org.springframework.amqp.rabbit.connection.ConnectionFactory webClientBuilder() {
//        return new org.springframework.amqp.rabbit.connection.ConnectionFactory();
//    }
    // Add any other test-specific configurations or beans as needed
}