package com.mot.response;

import com.mot.dtos.CreateThreadDTO;
import com.mot.dtos.SendNotificationDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import java.net.URI;
import java.util.UUID;

@Service
public class NotificationClient {

    Logger logger = LoggerFactory.getLogger(NotificationClient.class);

    @Value("${app.security.notification-url}")
    private String baseUrl;


    @Value("${app.security.notification-port}")
    private String port;
    private final WebClient webClient;

    public NotificationClient(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(baseUrl).build();
    }

    public void createNotification(SendNotificationDTO emailRequest) {
        webClient.post()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(port)
                            .path("/api/email/createNotification")
                            .build();
                    logger.info(uri.toString());
                    return uri;
                })
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(emailRequest))
                .retrieve()
                .bodyToMono(Boolean.class)
                .block();
    }

    public UUID createThread(CreateThreadDTO thread) {
        return webClient.post()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(port)
                            .path("/api/email/createThread")
                            .build();
                    logger.info(uri.toString());
                    return uri;
                })
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(thread))
                .retrieve()
                .bodyToMono(UUID.class)
                .block();
    }
}
