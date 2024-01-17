package com.mot.controller.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.UUID;

public interface ProductController {

    @CrossOrigin
    @GetMapping(path = "/p/{productId}")
    ProductDTO getProductById(@PathVariable UUID productId);

    @CrossOrigin
    @GetMapping(path = "/c/{categoryId}")
    List<ProductPreviewDTO> getProductPreviewsByCategoryId(@PathVariable Integer categoryId,
                                                           @RequestParam(required = false) Integer page);

    @CrossOrigin
    @GetMapping(path = "/pc/{productCategoryId}")
    List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(@PathVariable Integer productCategoryId,
                                                                 @RequestParam(required = false) Integer page);


}
