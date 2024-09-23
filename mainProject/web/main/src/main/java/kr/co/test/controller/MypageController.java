package kr.co.test.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import kr.co.test.service.OrdersService;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.UserVO;

@Controller
public class MypageController {	

    @Autowired
    private OrdersService orderService;

    @GetMapping("/mypage")
    public String mypage(Model model, HttpSession session) {
        // 세션에서 로그인된 사용자 정보가 있는지 확인
        UserVO user = (UserVO) session.getAttribute("user");

        if (user == null) {
            // 세션에 사용자 정보가 없으면 mypage.jsp에서 처리
            model.addAttribute("loginRequired", true);
            return "mypage";
        }

        // 로그인된 사용자의 주문 내역 조회
        List<OrdersVO> orders = orderService.getOrdersByUserId((long) user.getUserId());
        model.addAttribute("orders", orders);

        return "mypage";
    }
}
