package kr.co.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import kr.co.test.service.ProductService;
import kr.co.test.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
    
    @Autowired
    private ProductService productService;
    
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    
    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        // RestTemplate을 사용하여 파이썬 API에서 추천 productId 가져오기
        RestTemplate restTemplate = new RestTemplate();
        String apiUrl = "http://localhost:5000/recommend?user_id=10";  // 실제 API URL로 변경하세요
        List<Integer> recommendedProductIds = restTemplate.getForObject(apiUrl, List.class);
        
        // 추천된 productId로 해당 제품 목록을 가져오기
        List<ProductVO> recommendedProducts = productService.getProductsByIds(recommendedProductIds);
        model.addAttribute("products", recommendedProducts);
        
        logger.info("Welcome home! The client locale is {}.", locale);
        
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        
        String formattedDate = dateFormat.format(date);
        
        model.addAttribute("serverTime", formattedDate );
        
        return "home";
    }
    
}
