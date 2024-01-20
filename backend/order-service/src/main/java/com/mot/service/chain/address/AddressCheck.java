package com.mot.service.chain.address;

import com.mot.dtos.AddressDTO;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.handler.interfaces.Handle;

import java.util.Map;
import java.util.Optional;

public class AddressCheck extends ChainLink {
    private final Optional<AddressDTO> address;

    public AddressCheck(Optional<AddressDTO> address, Map<String, String> errors) {
        this.address = address;
        this.errors = errors;
        this.request = new Handle() {
            @Override
            public boolean isInvalid() {
                return address.isEmpty();
            }

            @Override
            public String getErrorMessage() {
                return "Cannot process order without address";
            }
        };

    }
}
