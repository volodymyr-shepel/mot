package com.mot.controller.category;

import com.mot.dtos.CategoryDTO;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface CategoryController {

    // using category hierarchy we will get the same result as with ParentCategories since fields are the same
    // CategoriesHierarchy additionally includes child categories(which may or may not be used)

    @CrossOrigin
    @GetMapping(path = "/categoryHierarchy")
    List<CategoryDTO> getCategoryHierarchy();

    @GetMapping(path = "/parentCategories")
    List<CategoryDTO> getParentCategories();

    @CrossOrigin
    @GetMapping(path = "/categoryWeb/{productCategoryId}")
    List<CategoryDTO> getFirstParentCategoryChildren(@PathVariable Integer productCategoryId);
}
