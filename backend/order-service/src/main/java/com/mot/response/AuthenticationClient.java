package com.mot.response;

import com.mot.dtos.AppUserDTO;
import com.mot.dtos.UserAuthenticationRequest;
import com.mot.dtos.UserAuthenticationResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import java.net.URI;
import java.util.UUID;

@Service
public class AuthenticationClient {

    Logger logger = LoggerFactory.getLogger(AuthenticationClient.class);

    @Value("${app.security.nginx-url}")
    private String baseUrl;
    private final WebClient webClient;

    public AuthenticationClient(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(baseUrl).build();
    }

    public ResponseEntity<UUID> signUp(AppUserDTO appUserDTO) {
        return webClient.post()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/auth/user/v1/signUp")
                            .build();
                    logger.info(uri.toString());
                    return uri;
                })
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(appUserDTO))
                .retrieve()
                .toEntity(UUID.class)
                .block();
    }

    public ResponseEntity<UserAuthenticationResponse> authenticate(UserAuthenticationRequest userAuthenticationRequest) {
        return webClient.post()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/auth/user/v1/signIn")
                            .build();
                    logger.info(uri.toString());
                    return uri;
                })
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(userAuthenticationRequest))
                .retrieve()
                .toEntity(UserAuthenticationResponse.class)
                .block();
    }
}
