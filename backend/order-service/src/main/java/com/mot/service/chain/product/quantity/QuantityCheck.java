package com.mot.service.chain.product.quantity;

import com.mot.dtos.LimitedOrderItemDTO;
import com.mot.response.ProductClient;
import com.mot.service.chain.handler.ChainLink;
import com.mot.service.chain.handler.interfaces.Handle;

import java.util.List;
import java.util.Map;

public class QuantityCheck extends ChainLink {
    private final List<LimitedOrderItemDTO> items;
    private final ProductClient productClient;

    public QuantityCheck(List<LimitedOrderItemDTO> items, ProductClient productClient, Map<String, String> errors) {
        this.items = items;
        this.productClient = productClient;
        this.request = new Handle() {
            @Override
            public boolean isInvalid() {
                return items.stream().anyMatch(item -> productClient.getProductQuantity(item.getProductId()) < item.getQuantity());
            }

            @Override
            public String getErrorMessage() {
                return "Quantity is not matching";
            }
        };
    }

}
