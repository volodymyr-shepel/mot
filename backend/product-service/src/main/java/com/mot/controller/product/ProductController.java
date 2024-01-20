package com.mot.controller.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.dtos.ProductQuantityDTO;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

public interface ProductController {

    @GetMapping(path = "/p/quantity/get/{productId}")
    default Integer getProductQuantity(@PathVariable UUID productId) {
        return getProductById(productId).quantity();
    }

    @PostMapping(path = "/p/quantity/update/")
    boolean updateProductQuantity(@RequestBody List<ProductQuantityDTO> products);

    @GetMapping(path = "/p/{productId}")
    ProductDTO getProductById(@PathVariable UUID productId);

    @GetMapping(path = "/c/{categoryId}")
    List<ProductPreviewDTO> getProductPreviewsByCategoryId(@PathVariable Integer categoryId,
                                                           @RequestParam(required = false) Integer page);

    @GetMapping(path = "/pc/{productCategoryId}")
    List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(@PathVariable Integer productCategoryId,
                                                                 @RequestParam(required = false) Integer page);


}
