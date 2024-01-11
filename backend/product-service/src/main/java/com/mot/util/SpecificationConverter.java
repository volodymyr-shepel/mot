package com.mot.util;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.Map;

public class SpecificationConverter {
    public static Map<String, String> convertSpecificationString(String specificationString) {
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            return objectMapper.readValue(specificationString, Map.class);
        } catch (IOException e) {
            e.printStackTrace(); // Handle exception accordingly
            return null; // Or throw an exception or return an empty map depending on your requirements
        }
    }
}
