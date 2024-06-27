package com.mot.controller.category;

import com.mot.dtos.CategoryDTO;
import com.mot.service.category.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Comparator;
import java.util.List;

@RestController
@RequestMapping(path = "/api/product/categories/v1")
public class CategoryControllerImpl  implements CategoryController{
    private final CategoryService categoryServiceImpl;


    public CategoryControllerImpl(CategoryService categoryServiceImpl) {
        this.categoryServiceImpl = categoryServiceImpl;
    }

    public List<CategoryDTO> getCategoryHierarchy(){
        return categoryServiceImpl.getCategoryHierarchy();
    }

    public List<CategoryDTO> getParentCategories(){
        return categoryServiceImpl.getParentCategories();
    }

    @Override
    public List<CategoryDTO> getFirstParentCategoryChildren(Integer productCategoryId) {
        List<CategoryDTO> categoryDTOS = categoryServiceImpl.getCategoryHierarchy().get(productCategoryId).getChildCategories();
        categoryDTOS.sort(Comparator.comparingInt(CategoryDTO::getParentCategoryId));
        return categoryDTOS;
    }


}
