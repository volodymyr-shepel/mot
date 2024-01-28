package com.mot.service.chain.address;

import com.mot.dtos.AddressDTO;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.handler.interfaces.Handle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;

public class AddressCheck extends ChainLink {
    Logger log = LoggerFactory.getLogger(AddressCheck.class);
    private final Optional<AddressDTO> optionalAddress;

    public AddressCheck(Optional<AddressDTO> optionalAddress, Map<String, String> errors) {
        this.optionalAddress = optionalAddress;
        this.errors = errors;
        this.handler = Optional.empty();
        this.request = new Handle() {
            @Override
            public boolean isInvalid() {
                boolean result = optionalAddress.isEmpty();
                if (!result) {
                    AddressDTO addressDTO = optionalAddress.get();
                    log.info(addressDTO.toString());
                    if (addressDTO.getCreatedOn() == null)
                        addressDTO.setCreatedOn(LocalDateTime.now());
                    return ((addressDTO.getAddressLine1() == null || addressDTO.getAddressLine1().isBlank() || addressDTO.getAddressLine1().equalsIgnoreCase("NULL"))
                            && (addressDTO.getAddressLine2() == null || addressDTO.getAddressLine2().isBlank() || addressDTO.getAddressLine2().equalsIgnoreCase("NULL")))
                                || (addressDTO.getCountry() == null || addressDTO.getCountry().isBlank() || addressDTO.getCountry().equalsIgnoreCase("NULL"))
                                || (addressDTO.getCity() == null|| addressDTO.getCity().isBlank()  || addressDTO.getCity().equalsIgnoreCase("NULL"));
                }
                return result;
            }

            @Override
            public String getErrorMessage() {
                return "Cannot process order without address";
            }
        };

    }
}
