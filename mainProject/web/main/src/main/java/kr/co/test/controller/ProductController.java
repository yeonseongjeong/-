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
import kr.co.test.service.UserViewService;
import kr.co.test.vo.ProductDescriptionVO;
import kr.co.test.vo.ProductVO;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private UserViewService userViewService;

	@Autowired
	private ProductDescriptionService productDescriptionService;

	@GetMapping("/products")
	public String showAllProducts(Model model) {
		List<ProductVO> products = productService.getProducts();
		model.addAttribute("products", products);
		return "products";
	}

	@GetMapping("/product/{productId}")
	public String showProductDetail(@PathVariable("productId") int productId, Model model, HttpSession session) {
		ProductVO product = productService.getProductById(productId);
		ProductDescriptionVO description = productDescriptionService.getProductDescriptionById(productId);

		// 유저 ID 가져오기 (로그인된 사용자가 있다고 가정)
		Integer userId = (Integer) session.getAttribute("userId");

		if (userId != null) {
			// 조회 기록 저장
			userViewService.saveUserView(userId, productId);
		}
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
	public String addProduct(@RequestParam("productName") String productName,
			@RequestParam("categoryId") int categoryId, @RequestParam("price") int price,
			@RequestParam("stockQuantity") int stockQuantity, @RequestParam("productImage") MultipartFile productImage,
			RedirectAttributes redirectAttributes) {
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
	@GetMapping("/erp/productList")
    public String showAllErpProducts(Model model) {
        List<ProductVO> products = productService.getProducts();
        model.addAttribute("products", products);
        return "productList";
    }
 // 제품 수정 페이지 보여주기
    @GetMapping("/erp/editProduct/{productId}")
    public String showEditProductPage(@PathVariable("productId") int productId, Model model) {
        ProductVO product = productService.getProductById(productId);
        model.addAttribute("product", product);
        return "productEdit"; // 수정할 JSP 파일 이름
    }

    // 제품 수정 처리
    @PostMapping("/erp/updateProduct")
    public String updateProduct(
        @RequestParam("productId") int productId,
        @RequestParam("productName") String productName,
        @RequestParam("categoryId") int categoryId,
        @RequestParam("price") int price,
        @RequestParam("stockQuantity") int stockQuantity,
        RedirectAttributes redirectAttributes
    ) {
        ProductVO product = new ProductVO();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setCategoryId(categoryId);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);

        productService.updateProduct(product); // 수정 메서드 호출

        redirectAttributes.addFlashAttribute("message", "상품이 성공적으로 수정되었습니다.");
        return "redirect:/erp/productList"; // 수정 후 상품 목록으로 리다이렉트
    }

}