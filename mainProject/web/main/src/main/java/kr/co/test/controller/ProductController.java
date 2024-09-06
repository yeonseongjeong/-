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
        // ��ǰ ������ �����ɴϴ�.
        ProductVO product = productService.getProductById(productId);
		ProductDescriptionVO description = productDescriptionService.getProductDescriptionById(productId);
        // �𵨿� ��ǰ ������ �߰��մϴ�.
        model.addAttribute("product", product);
        model.addAttribute("description",description);
        // JSP �並 ��ȯ�մϴ�.
        return "product";
    }
    @GetMapping("/products")
    public String showAllProducts(Model model) {
        // ��� ��ǰ ������ �����ɴϴ�.
        List<ProductVO> products = productService.getProducts();
        // �𵨿� ��� ��ǰ ������ �߰��մϴ�.
        model.addAttribute("products", products);
        // JSP �並 ��ȯ�մϴ�.
        return "products";
    }
}
