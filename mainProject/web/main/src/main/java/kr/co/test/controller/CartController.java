package kr.co.test.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    @PostMapping("/addToCart")
    public String addToCart(@RequestParam("productId") int productId, 
                            @RequestParam("quantity") int quantity, 
                            @RequestParam("price") int price,  // 가격 정보 추가
                            HttpSession session, Model model) {

        // 세션에서 사용자 정보 가져오기
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            // 사용자가 로그인하지 않았을 경우
            model.addAttribute("loginRequired", true);
            return "redirect:/login";  // 로그인 페이지로 리다이렉션
        }

        // 장바구니에 아이템 추가
        int userId = user.getUserId();
        cartService.addCartItem(userId, productId, quantity, price);  // 가격 정보 추가

        // 장바구니 페이지로 리다이렉트
        return "redirect:/";
    }
}
