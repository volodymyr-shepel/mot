package com.mot.controller.service;

import com.mot.dtos.AddressDTO;
import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.dtos.ProductDTO;
import com.mot.repository.AddressRepository;
import com.mot.repository.OrderItemRepository;
import com.mot.repository.OrderRepository;
import com.mot.response.AuthenticationClient;
import com.mot.response.IdentityClient;
import com.mot.response.NotificationClient;
import com.mot.response.ProductClient;
import com.mot.service.NotificationService;
import com.mot.service.PublicOrderService;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.time.LocalDateTime;
import java.util.*;

class PublicOrderServiceTest {

    @Mock
    private OrderRepository orderRepository;

    @Mock
    private OrderItemRepository orderItemRepository;

    @Mock
    private AddressRepository addressRepository;

    @Mock
    private IdentityClient identityClient;

    @Mock
    private AuthenticationClient authenticationClient;

    @Mock
    private ProductClient productClient;

    @Mock
    private NotificationClient notificationClient;

    @Mock
    private NotificationService notificationService;

    @InjectMocks
    private PublicOrderService publicOrderService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void placeOrder_SuccessfulOrder() {
        // Mock dependencies
        when(notificationClient.createThread(any())).thenReturn(UUID.randomUUID());
        when(productClient.updateProductQuantity(any())).thenReturn(true);
        when(productClient.getProductQuantity(any())).thenReturn(10);
        when(productClient.getProductById(any())).thenReturn(new ProductDTO(UUID.randomUUID(),"","", "", new HashMap<>(), 2, 1000.0, "", LocalDateTime.now(), LocalDateTime.now(), 0));

        // Create test data
        String userEmail = "test@example.com";
        AddressDTO address = new AddressDTO("123 Street", null, "City", "Country", "12345", null);
        LimitedOrderItemDTO orderItemDTO = new LimitedOrderItemDTO(UUID.randomUUID(), 2);
        List<LimitedOrderItemDTO> items = Collections.singletonList(orderItemDTO);

        // Perform the test
        UUID orderId = publicOrderService.placeOrder(userEmail, address, items);

        // Verify that the order was saved
        verify(orderRepository, times(1)).saveAndFlush(any());

        // Verify that the notification service was called
        verify(notificationService, times(1)).publishNotification(any());

        // Verify that the order ID is not null
    }

    @Test
    void placeOrder_InvalidInputs_ThrowsException() {
        // Mock dependencies
        when(notificationClient.createThread(any())).thenReturn(UUID.randomUUID());
        when(productClient.updateProductQuantity(any())).thenReturn(true);

        // Create test data with invalid inputs
        String userEmail = "test@example.com";
        AddressDTO address = new AddressDTO(null, null, "City", "Country", "12345", null);
        LimitedOrderItemDTO orderItemDTO = new LimitedOrderItemDTO(UUID.randomUUID(), 0); // Invalid quantity
        List<LimitedOrderItemDTO> items = Collections.singletonList(orderItemDTO);

        // Perform the test and expect an exception
        assertThrows(EntityNotFoundException.class, () -> publicOrderService.placeOrder(userEmail, address, items));

        // Verify that the order was not saved
        verify(orderRepository, times(0)).saveAndFlush(any());

        // Verify that the notification service was not called
        verify(notificationService, times(0)).publishNotification(any());
    }
}
