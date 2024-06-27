package com.mot.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mot.dtos.AddressDTO;
import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.dtos.PlaceOrderDTO;
import com.mot.service.IPublicOrderService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebMvcTest(IOrderServicePublicController.class)
@ComponentScan(basePackages = "com.mot")
@WebAppConfiguration
public class OrderServicePublicControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private IPublicOrderService publicOrderService;


    @Test
    void testPlaceOrder() throws Exception {

        AddressDTO addressDTO = new AddressDTO();
        addressDTO.setAddressLine1("1");
        addressDTO.setAddressLine2("2");
        addressDTO.setCity("city 17");
        addressDTO.setCountry("country 1");
        addressDTO.setPostalCode("12345");

        LimitedOrderItemDTO limitedOrderItemDTO = new LimitedOrderItemDTO();
        limitedOrderItemDTO.setProductId(UUID.fromString("00dc94e0-e7a3-4351-ae82-a2bb8ec304e5"));
        limitedOrderItemDTO.setQuantity(2);

        List<LimitedOrderItemDTO> list = new ArrayList<>();
        list.add(limitedOrderItemDTO);

        PlaceOrderDTO placeOrderDTO = new PlaceOrderDTO(
                "gameportaldan@gmail.com",
                null,
                null,
                addressDTO,
                list
        ); // Create a mock PlaceOrderDTO

        // Mock the behavior of the publicOrderService.placeOrder() method
        Mockito.when(publicOrderService.placeOrder(
                placeOrderDTO.userEmail(),
                placeOrderDTO.address(),
                placeOrderDTO.items()
        )).thenReturn(UUID.randomUUID());

        mockMvc.perform(MockMvcRequestBuilders.post("/api/order/public/v1/place-order")
                        .contentType("application/json")
                        .content(asJsonString(placeOrderDTO)))
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    // Utility method to convert object to JSON string
    private String asJsonString(final Object obj) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
