package com.mot.service.chain.address;

import com.mot.dtos.AddressDTO;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.handler.interfaces.Handle;

import java.util.Map;
import java.util.Optional;

public class AddressCheck extends ChainLink {
    private final Optional<AddressDTO> optionalAddress;

    public AddressCheck(Optional<AddressDTO> optionalAddress, Map<String, String> errors) {
        this.optionalAddress = optionalAddress;
        this.errors = errors;
        this.request = new Handle() {
            @Override
            public boolean isInvalid() {
                return optionalAddress.isEmpty();
            }

            @Override
            public String getErrorMessage() {
                return "Cannot process order without address";
            }
        };

    }
}
