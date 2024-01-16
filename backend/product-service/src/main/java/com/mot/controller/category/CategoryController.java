package com.mot.controller.category;

import com.mot.dtos.CategoryDTO;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

public interface CategoryController {

    // using category hierarchy we will get the same result as with ParentCategories since fields are the same
    // CategoriesHierarchy additionally includes child categories(which may or may not be used)
    @GetMapping(path = "/categoryHierarchy")
    List<CategoryDTO> getCategoryHierarchy();

    @GetMapping(path = "/parentCategories")
    List<CategoryDTO> getParentCategories();

}
