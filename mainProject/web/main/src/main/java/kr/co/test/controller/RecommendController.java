package kr.co.test.controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Arrays;
@Controller
public class RecommendController {

    @GetMapping("/recommend")
    @ResponseBody
    public List<Integer> getRecommendations(@RequestParam("user_id") int userId) {
        // RestTemplate을 사용하여 Python API 호출
        RestTemplate restTemplate = new RestTemplate();
        String apiUrl = "http://localhost:5000/recommend?user_id=" + userId;  // Python 서버 URL
        Integer[] recommendedProductIds = restTemplate.getForObject(apiUrl, Integer[].class);
        
        // 추천된 product_id 리스트 반환
        return Arrays.asList(recommendedProductIds);
    }
}