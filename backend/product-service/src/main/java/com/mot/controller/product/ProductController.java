package com.mot.controller.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.UUID;

public interface ProductController {

    @GetMapping(path = "/p/{productId}")
    ProductDTO getProductById(@PathVariable UUID productId);

    @GetMapping(path = "/c/{categoryId}")
    List<ProductPreviewDTO> getProductPreviewsByCategoryId(@PathVariable Integer categoryId);

    @GetMapping(path = "/pc/{productCategoryId}")
    List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(@PathVariable Integer productCategoryId);

}
