package kr.co.test.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {	

    @GetMapping("/mypage")
    public String mypage(Model model, HttpSession session) {
        // 세션에서 로그인된 사용자 정보가 있는지 확인
        Object user = session.getAttribute("user");

        if (user == null) {
            // 세션에 사용자 정보가 없으면 mypage.jsp에서 처리
            model.addAttribute("loginRequired", true);
        }

        return "mypage";
    }
}
