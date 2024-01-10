package com.mot.service.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.UUID;

public interface ProductService {

    ProductDTO getProductById(UUID productId);


    List<ProductPreviewDTO> getProductPreviewsByCategoryId(Integer categoryId);


    //List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(Integer productCategoryId);

}
