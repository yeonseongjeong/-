package kr.co.test.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    @GetMapping("/addProduct")
    public String showAddProductPage(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null && userId == 1) {
            return "addProduct";
        } else {
            return "redirect:/login";
        }
    }

    @PostMapping("/addProduct")
    public String addProduct(
        @RequestParam("productName") String productName,
        @RequestParam("categoryId") int categoryId,
        @RequestParam("price") int price,
        @RequestParam("stockQuantity") int stockQuantity,
        @RequestParam("productImage") MultipartFile productImage,
        RedirectAttributes redirectAttributes
    ) {
    	System.out.println("Product Name: " + productName);
        System.out.println("Category ID: " + categoryId);
        System.out.println("Price: " + price);
        System.out.println("Stock Quantity: " + stockQuantity);
        String uploadDir = "C:/RPAWork/workspace/mainproject/mainProject/web/main/src/main/webapp/resources/img";
        try {
            byte[] bytes = productImage.getBytes();
            Path path = Paths.get(uploadDir + File.separator + productImage.getOriginalFilename());
            Files.write(path, bytes);

            ProductVO product = new ProductVO();
            product.setProductName(productName);
            product.setCategoryId(categoryId);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(productImage.getOriginalFilename());

            productService.addProduct(product);

            redirectAttributes.addFlashAttribute("message", "상품이 성공적으로 등록되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "파일 업로드 중 오류가 발생했습니다.");
        }

        return "redirect:/addProduct";
    }

}
