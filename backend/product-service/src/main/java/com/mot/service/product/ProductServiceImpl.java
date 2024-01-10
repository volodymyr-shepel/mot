package com.mot.service.product;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.model.Product;
import com.mot.repository.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {

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
    public List<ProductPreviewDTO> getProductPreviewsByCategoryId(Integer categoryId) {
        List<Product> products = productRepository.findAllByCategoryId(categoryId);

        return products.stream()
                .map(Product::convertToProductPreviewDTO)
                .collect(Collectors.toList());
    }

    public List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(Integer productCategoryId) {
        return null;
    }
}
