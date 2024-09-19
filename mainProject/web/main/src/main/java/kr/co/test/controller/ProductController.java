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

    @GetMapping("/products")
    public String showAllProducts(Model model) {
        List<ProductVO> products = productService.getProducts();
        model.addAttribute("products", products);
        return "products";
    }
    @GetMapping("/product/{productId}")
    public String showProductDetail(@PathVariable("productId") int productId, Model model) {
        ProductVO product = productService.getProductById(productId);
        ProductDescriptionVO description = productDescriptionService.getProductDescriptionById(productId);
        
        // 클릭한 상품을 제외한 같은 카테고리의 랜덤 상품들 조회
        List<ProductVO> relatedProducts = productService.getRandomRelatedProducts(product.getCategoryId(), productId);
        
        model.addAttribute("product", product);
        model.addAttribute("description", description);
        model.addAttribute("relatedProducts", relatedProducts);
        
        return "product";
    }

    
 
}
