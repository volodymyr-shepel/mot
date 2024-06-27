package com.mot.controller.service.chain.address;

import com.mot.dtos.AddressDTO;
import com.mot.service.chain.address.AddressCheck;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

class AddressCheckTest {

    @Mock
    private AddressDTO mockedAddressDTO;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testAddressCheckWithValidAddress() {
        Map<String, String> errors = new HashMap<>();
        when(mockedAddressDTO.getAddressLine1()).thenReturn("123 Main St");
        when(mockedAddressDTO.getAddressLine2()).thenReturn("Apt 456");
        when(mockedAddressDTO.getCountry()).thenReturn("USA");
        when(mockedAddressDTO.getCity()).thenReturn("New York");

        AddressCheck addressCheck = new AddressCheck(Optional.of(mockedAddressDTO), errors);

        assertFalse(addressCheck.getRequest().isInvalid());
        assertTrue(errors.isEmpty());
    }

    @Test
    void testAddressCheckWithInvalidAddress() {
        Map<String, String> errors = new HashMap<>();
        when(mockedAddressDTO.getAddressLine1()).thenReturn(null);
        when(mockedAddressDTO.getAddressLine2()).thenReturn("");
        when(mockedAddressDTO.getCountry()).thenReturn(" ");
        when(mockedAddressDTO.getCity()).thenReturn("NULL");

        AddressCheck addressCheck = new AddressCheck(Optional.of(mockedAddressDTO), errors);

        assertTrue(addressCheck.getRequest().isInvalid());
        addressCheck.handle();
        assertFalse(errors.isEmpty());
        assertEquals("Cannot process order without address", errors.get(AddressCheck.class.getName()));
    }

    @Test
    void testAddressCheckWithEmptyOptionalAddress() {
        Map<String, String> errors = new HashMap<>();

        AddressCheck addressCheck = new AddressCheck(Optional.empty(), errors);

        assertTrue(addressCheck.getRequest().isInvalid());
        addressCheck.handle();
        assertFalse(errors.isEmpty());
        assertEquals("Cannot process order without address", errors.get(AddressCheck.class.getName()));
    }
}
