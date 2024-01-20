package com.mot.response;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.UpdateProductDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.util.List;
import java.util.UUID;


@Service
public class ProductClient {
    @Value("${app.security.nginx-url}")
    private String baseUrl;
    private final WebClient webClient;

    Logger logger = LoggerFactory.getLogger(ProductClient.class);

    public ProductClient(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl(baseUrl).build();
    }

    public Integer getProductQuantity(UUID productId) {
        logger.info(productId.toString());
        logger.info("/api/product/products/v1/p/quantity/get/" + productId);
        return webClient.get()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/product/products/v1/p/quantity/get/{productId}")
                            .build(productId);
                    logger.info(uri.toString());
                    return uri;
                })
                .retrieve()
                .bodyToMono(Integer.class).onErrorResume(e -> {
                    logger.info(e.toString());
                    return Mono.just(100);
                })
                .block();
    }

    public ProductDTO getProductById(UUID productId) {
        return webClient.get()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/product/products/v1/p/{productId}")
                            .build(productId);
                    logger.info(uri.toString());
                    return uri;
                })
                .retrieve()
                .bodyToMono(ProductDTO.class)
                .block();
    }

    public boolean updateProductQuantity(List<UpdateProductDTO> products)  {
        return Boolean.TRUE.equals(webClient.post()
                .uri(uriBuilder -> {
                    URI uri = uriBuilder
                            .scheme("http")
                            .host(baseUrl)
                            .port(80)
                            .path("/api/product/products/v1/p/quantity/update/")
                            .build();
                    logger.info(uri.toString());
                    return uri;
                })
                .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .body(BodyInserters.fromValue(products))
                .retrieve()
                .bodyToMono(Boolean.class)
                .block());
    }
}
