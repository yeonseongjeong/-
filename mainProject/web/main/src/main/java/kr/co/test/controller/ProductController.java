package kr.co.test.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import kr.co.test.repository.ProductDAO;
import kr.co.test.service.ProductDescriptionService;
import kr.co.test.service.ProductService;
import kr.co.test.vo.ProductDescriptionVO;
import kr.co.test.vo.ProductVO;


@Controller
public class ProductController {

    @Autowired
    private ProductService productService;
    
    @Autowired
    private ProductDescriptionService productDescriptionService;
    @GetMapping("/product/{productId}")
    public String showProductDetail(@PathVariable("productId") int productId, Model model) {
        // 제품 정보를 가져옵니다.
        ProductVO product = productService.getProductById(productId);
		ProductDescriptionVO description = productDescriptionService.getProductDescriptionById(productId);
        // 모델에 제품 정보를 추가합니다.
        model.addAttribute("product", product);
        model.addAttribute("description",description);
        // JSP 뷰를 반환합니다.
        return "product";
    }
    @GetMapping("/products")
    public String showAllProducts(Model model) {
        // 모든 제품 정보를 가져옵니다.
        List<ProductVO> products = productService.getProducts();
        // 모델에 모든 제품 정보를 추가합니다.
        model.addAttribute("products", products);
        // JSP 뷰를 반환합니다.
        return "products";
    }
}
