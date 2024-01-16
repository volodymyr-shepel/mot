package com.mot.model;

import com.mot.dtos.ProductDTO;
import com.mot.dtos.ProductPreviewDTO;
import com.mot.util.SpecificationConverter;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
public class Product {
    @Id
    @GeneratedValue
    private UUID id;

    private String sku;

    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT") // Specify TEXT type for unlimited length
    private String specification;

    private Integer quantity;

    private Double price;

    private String imageUrl;

    private LocalDateTime createdOn;

    private LocalDateTime updatedOn;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    public Product() {
        // Default constructor
    }

    public Product(String sku,
                   String name,
                   String description,
                   String specification,
                   Integer quantity,
                   Double price,
                   String imageUrl,
                   LocalDateTime createdOn,
                   LocalDateTime updatedOn,
                   Category category) {
        this.sku = sku;
        this.name = name;
        this.description = description;
        this.specification = specification;
        this.quantity = quantity;
        this.price = price;
        this.imageUrl = imageUrl;
        this.createdOn = createdOn;
        this.updatedOn = updatedOn;
        this.category = category;
    }

    public ProductDTO convertToProductDTO() {

        return new ProductDTO(
                this.getId(),
                this.getSku(),
                this.getName(),
                this.getDescription(),
                SpecificationConverter.convertSpecificationString(this.getSpecification()),
                this.getQuantity(),
                this.getPrice(),
                this.getImageUrl(),
                this.getCreatedOn(),
                this.getUpdatedOn(),
                this.getCategory().getId()
        );
    }

    public ProductPreviewDTO convertToProductPreviewDTO(){
        return new ProductPreviewDTO(
                this.getId(),
                this.getName(),
                this.getPrice(),
                this.getImageUrl()
        );
    }


    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public LocalDateTime getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(LocalDateTime updatedOn) {
        this.updatedOn = updatedOn;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
