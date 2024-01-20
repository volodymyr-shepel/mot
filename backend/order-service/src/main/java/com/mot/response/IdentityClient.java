package com.mot.response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.net.URI;
import java.util.UUID;


@Service
public class IdentityClient {

    Logger logger = LoggerFactory.getLogger(IdentityClient.class);

    @Value("${app.security.nginx-url}")
    private String baseUrl;
    private final WebClient webClient;

    public IdentityClient(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(baseUrl).build();
    }

    public boolean isUserExist(UUID id) {
        return Boolean.TRUE.equals(webClient.get()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/identity/v1/check-user/{id}")
                            .build(id);
                    logger.info(uri.toString());
                    return uri;
                })
                .retrieve()
                .bodyToMono(Boolean.class)
                .block());
    }

    public boolean isUserExistByEmail(String email) {
        return Boolean.TRUE.equals(webClient.get()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/identity/v1/check-user/by-email/{email}")
                            .build(email);
                    logger.info(uri.toString());
                    return uri;
                })
                .retrieve()
                .bodyToMono(Boolean.class)
                .block());
    }
}
