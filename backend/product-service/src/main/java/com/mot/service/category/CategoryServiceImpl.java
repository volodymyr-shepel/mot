package com.mot.service.category;


import com.mot.dtos.CategoryDTO;
import com.mot.model.Category;
import com.mot.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<CategoryDTO> getCategoryHierarchy() {
        List<Category> categories = categoryRepository.findByParentIsNull();
        return categories.stream()
                .map(Category::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<CategoryDTO> getParentCategories() {
//        List<Category> categories = categoryRepository.findByParentIsNull();
//        return ;
        return null;
    }


}
