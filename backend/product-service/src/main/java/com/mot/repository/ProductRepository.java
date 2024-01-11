package com.mot.repository;

import com.mot.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> {

    List<Product> findAllByCategoryId(Integer categoryId);

    Page<Product> findAllByCategoryId(Integer categoryId, Pageable pageable);

    Page<Product> findAllByCategoryParentId(Integer categoryId, Pageable pageable);

}
