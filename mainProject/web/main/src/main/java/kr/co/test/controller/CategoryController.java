package kr.co.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import kr.co.test.service.ProductService;
import kr.co.test.vo.ProductVO;

@Controller
public class CategoryController {

    @Autowired
    private ProductService productService;

    @GetMapping("/products/category/{categoryId}")
    public String getProductsByCategory(@PathVariable int categoryId, Model model) {
        List<ProductVO> products = productService.getProductsByCategoryId(categoryId);
        model.addAttribute("products", products);
        return "category"; // JSP 파일 이름 (category.jsp)
    }
}
