package com.mot.service.category;

import com.mot.dtos.CategoryDTO;

import java.util.List;

public interface CategoryService {

    List<CategoryDTO> getCategoryHierarchy();

    List<CategoryDTO> getParentCategories();

}
