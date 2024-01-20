package com.mot.service.chain.handler;

import com.mot.service.chain.handler.interfaces.Handle;
import com.mot.service.chain.handler.interfaces.Handler;
import jakarta.annotation.Nullable;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;
import java.util.Optional;

public abstract class ChainLink implements Handler {
    Logger logger = LoggerFactory.getLogger(ChainLink.class);
    @Getter
    protected Optional<Handler> handler = Optional.empty();

    @Getter
    @Setter
    protected Handle request;

    protected Map<String, String> errors;

    @Override
    public void setNext(@Nullable Handler handler) {
        this.handler = Optional.ofNullable(handler);
    }

    @Override
    public void handle() {
        request.handle().ifPresent(s -> errors.putIfAbsent(getClass().getName(), s));
        if (handler != null && handler.isPresent()) {
            handler.get().handle();
        }
    }

    @Override
    public Map<String, String> getErrors() {
        return errors;
    }
}
