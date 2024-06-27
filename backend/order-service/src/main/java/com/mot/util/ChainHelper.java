package com.mot.util;
import com.mot.dtos.AddressDTO;
import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.response.*;
import com.mot.service.chain.address.AddressCheck;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.product.quantity.QuantityCheck;
import com.mot.service.chain.user.UserExistenceCheck;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
public class ChainHelper {

    public static ChainLink validationChain(
            IdentityClient identityClient, AuthenticationClient authenticationClient, String userEmail,
            AddressDTO address,
            List<LimitedOrderItemDTO> items, ProductClient productClient,
            Map<String, String> errors) {
        ChainLink head = new UserExistenceCheck(identityClient, authenticationClient, userEmail, errors);

        ChainLink chain = head;
        ChainLink next = new AddressCheck(Optional.ofNullable(address), errors);
        chain.setNext(next);

        chain = next;
        next = new QuantityCheck(items, productClient, errors);
        chain.setNext(next);

        log.info(chain.toString());
        return head;
    }
}
