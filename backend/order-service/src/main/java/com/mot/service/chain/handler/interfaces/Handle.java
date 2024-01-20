package com.mot.service.chain.handler.interfaces;

import java.util.Optional;

public interface Handle {

    default Optional<String> handle() {
        if (isInvalid()) {
            return Optional.of(getErrorMessage());
        }
        return Optional.empty();
    }

    boolean isInvalid();
    String getErrorMessage();
}
