package com.mot.service.product;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.model.Product;
import com.mot.repository.ProductRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {
    // fixed page size for now, change if needed
    private final Integer PAGE_SIZE = 5;

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public ProductDTO getProductById(UUID productId) {
        Optional<Product> optionalProduct = productRepository.findById(productId);

        Product product = optionalProduct.orElseThrow(() -> new NoSuchElementException("Product not found with ID: " + productId));

        return product.convertToProductDTO();
    }

    @Override
    public List<ProductPreviewDTO> getProductPreviewsByCategoryId(Integer categoryId,Integer page) {
        Pageable pageable = PageRequest.of(page, PAGE_SIZE);

        Page<Product> productPage = productRepository.findAllByCategoryId(categoryId, pageable);


        return productPage.getContent().stream()
                .map(Product::convertToProductPreviewDTO)
                .collect(Collectors.toList());
    }

    public List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(Integer productCategoryId) {
        return null;
    }
}
