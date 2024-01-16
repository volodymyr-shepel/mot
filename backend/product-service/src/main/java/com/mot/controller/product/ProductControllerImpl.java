package com.mot.controller.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.service.product.ProductServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping(path = "/api/product/products/v1")
public class ProductControllerImpl implements ProductController {


    private final ProductServiceImpl productServiceImpl;

    public ProductControllerImpl(ProductServiceImpl productServiceImpl) {
        this.productServiceImpl = productServiceImpl;
    }

    @Override
    public ProductDTO getProductById(UUID productId) {
        return productServiceImpl.getProductById(productId);
    }

    @Override
    public List<ProductPreviewDTO> getProductPreviewsByCategoryId(Integer categoryId,Integer page) {
        return productServiceImpl.getProductPreviewsByCategoryId(categoryId,page);
    }
    @Override
    public List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(Integer productCategoryId,Integer page) {
        return productServiceImpl.getProductPreviewsByParentCategoryId(productCategoryId,page);
    }
}
