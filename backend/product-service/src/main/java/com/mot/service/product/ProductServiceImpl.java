package com.mot.service.product;

import com.mot.dtos.ProductQuantityDTO;
import jakarta.transaction.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.model.Product;
import com.mot.repository.ProductRepository;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class ProductServiceImpl implements ProductService {
    // fixed page size for now, change if needed
    private final Integer PAGE_SIZE = 5;

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Transactional
    public boolean updateProductsByQuantity(List<ProductQuantityDTO> products) {
            Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);
        products.forEach(x -> logger.info(x.id().toString()));
        Map<UUID, Product> productsFromRepo =
                productRepository.findAllById(products.stream().map(ProductQuantityDTO::id).toList())
                        .stream()
                        .collect(Collectors.toMap(Product::getId, p -> p));


        if(products.stream().anyMatch(product -> product.quantity() > productsFromRepo.get(product.id()).getQuantity()))
            return false;

        products.forEach(pair -> {
            Product product = productsFromRepo.get(pair.id());
            product.setQuantity(product.getQuantity() - pair.quantity());
        });

        productRepository.saveAllAndFlush(productsFromRepo.values());
        return true;
    }

    public ProductDTO getProductById(UUID productId) {
        Optional<Product> optionalProduct = productRepository.findById(productId);

        Product product = optionalProduct.orElseThrow(() -> new NoSuchElementException("Product not found with ID: " + productId));

        return product.convertToProductDTO();
    }

    @Override
    public List<ProductPreviewDTO> getProductPreviewsByCategoryId(Integer categoryId, Integer page) {
        Pageable pageable = PageRequest.of(page, PAGE_SIZE);

        Page<Product> productPage = productRepository.findAllByCategoryId(categoryId, pageable);


        return productPage.getContent().stream()
                .map(Product::convertToProductPreviewDTO)
                .collect(Collectors.toList());
    }

    public List<ProductPreviewDTO> getProductPreviewsByParentCategoryId(Integer productCategoryId,Integer page) {
        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        Page<Product> productPage = productRepository.findAllByCategoryParentId(productCategoryId, pageable);

        return productPage.getContent().stream()
                .map(Product::convertToProductPreviewDTO)
                .collect(Collectors.toList());
    }
}
