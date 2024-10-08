package kr.co.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

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

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model, HttpSession session) {
        // 세션에서 로그인된 사용자 ID 가져오기
    	Integer userId = (Integer) session.getAttribute("userId");
    	logger.info("User ID in session: {}", session.getAttribute("userId"));

        if (userId == null) {
            // 로그인되지 않은 경우 처리
            logger.warn("로그인되지 않은 사용자 접근");
            return "redirect:/login";  // 로그인 페이지로 리다이렉트
        }

        // RestTemplate을 사용하여 파이썬 API에서 추천 productId 가져오기
        RestTemplate restTemplate = new RestTemplate();
        logger.info("Requesting recommendation for user_id: " + userId);
        String apiUrl = "http://localhost:5001/recommend?user_id=" + userId;
        logger.info("Requesting recommendation for user_id from URL: {}", apiUrl);  // 요청 URL 로깅 추가
        List<Integer> recommendedProductIds = restTemplate.getForObject(apiUrl, List.class);

        // 추천된 productId로 해당 제품 목록을 가져오기
        List<ProductVO> recommendedProducts = productService.getProductsByIds(recommendedProductIds);
        model.addAttribute("products", recommendedProducts);

        logger.info("Welcome home! The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

        String formattedDate = dateFormat.format(date);

        model.addAttribute("serverTime", formattedDate);

        return "home";
    }
}
