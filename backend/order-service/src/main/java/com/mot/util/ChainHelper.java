package com.mot.util;
import com.mot.dtos.AddressDTO;
import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.response.*;
import com.mot.service.chain.address.AddressCheck;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.product.quantity.QuantityCheck;
import com.mot.service.chain.user.UserExistenceCheck;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public class ChainHelper {

    public static ChainLink validationChain(
            IdentityClient identityClient, AuthenticationClient authenticationClient, String userEmail,
            AddressDTO address,
            List<LimitedOrderItemDTO> items, ProductClient productClient,
            Map<String, String> errors) {
        ChainLink chain = new UserExistenceCheck(identityClient, authenticationClient, userEmail, errors);
        chain.setNext(new AddressCheck(Optional.ofNullable(address), errors));
        chain.setNext(new QuantityCheck(items, productClient, errors));
        return chain;
    }
}
