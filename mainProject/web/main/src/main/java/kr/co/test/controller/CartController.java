package kr.co.test.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.test.service.CartService;
import kr.co.test.vo.CartItemVO;
import kr.co.test.vo.UserVO;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("/cart")
    public String cart(Model model, HttpSession session) {
        // 세션에서 로그인된 사용자 정보가 있는지 확인
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            // 로그인하지 않은 경우, 로그인 페이지로 리다이렉트
            model.addAttribute("loginRequired", true);
            return "cart";
        }

        // 사용자 ID로 장바구니 아이템을 가져옵니다.
        int userId = user.getUserId();  // UserVO에서 userId 추출
        List<CartItemVO> cartItems = cartService.getCartItems(userId);

        // 장바구니 합계 계산
        int totalPrice = cartItems.stream()
                .mapToInt(item -> item.getPrice() * item.getQuantity())
                .sum();

        // 모델에 장바구니 아이템과 합계를 추가합니다.
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);

        return "cart";  // JSP 파일 이름
    }
}
