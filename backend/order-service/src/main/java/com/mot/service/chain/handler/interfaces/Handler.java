package com.mot.service.chain.handler.interfaces;

import java.util.Map;

public interface Handler {
    void setNext(Handler handler);
    void handle();

    Map<String, String> getErrors();
}
