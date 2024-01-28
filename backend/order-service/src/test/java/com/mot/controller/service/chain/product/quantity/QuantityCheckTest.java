package com.mot.controller.service.chain.product.quantity;

import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.response.ProductClient;
import com.mot.service.chain.product.quantity.QuantityCheck;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

class QuantityCheckTest {

    @Mock
    private ProductClient productClient;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testQuantityCheckInvalid() {
        // Arrange
        UUID id = UUID.randomUUID();
        List<LimitedOrderItemDTO> items = Collections.singletonList(
                new LimitedOrderItemDTO(id, 5)
        );

        Map<String, String> errors = Collections.emptyMap();
        when(productClient.getProductQuantity(id)).thenReturn(3);

        QuantityCheck quantityCheck = new QuantityCheck(items, productClient, errors);

        // Act
        boolean isInvalid = quantityCheck.getRequest().isInvalid();

        // Assert
        assertTrue(isInvalid, "QuantityCheck should be invalid when quantity is not sufficient");
    }

    @Test
    void testQuantityCheckValid() {
        // Arrange
        UUID id = UUID.randomUUID();
        List<LimitedOrderItemDTO> items = Collections.singletonList(
                new LimitedOrderItemDTO(id, 3)
        );

        Map<String, String> errors = Collections.emptyMap();
        when(productClient.getProductQuantity(id)).thenReturn(5);

        QuantityCheck quantityCheck = new QuantityCheck(items, productClient, errors);

        // Act
        boolean isInvalid = quantityCheck.getRequest().isInvalid();

        // Assert
        assertFalse(isInvalid, "QuantityCheck should be valid when quantity is sufficient");
    }
}
