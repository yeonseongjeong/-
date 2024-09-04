package kr.co.test.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.test.service.UserService;
import kr.co.test.vo.UserVO;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginForm() {
        return "login"; // 로그인 폼을 보여주는 페이지 반환
    }    
    
    // 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam("email") String email, 
                        @RequestParam("password") String password, 
                        HttpSession session, 
                        Model model) {
        UserVO user = userService.login(email, password);
        
        if (user != null) {
            session.setAttribute("user", user); // 로그인 성공, 세션에 사용자 정보 저장
            return "redirect:/"; // 로그인 성공 시 홈으로 리다이렉트
        } else {
            model.addAttribute("error", "Invalid email or password"); // 로그인 실패 메시지
            return "login"; // 로그인 페이지로 다시 이동
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 종료
        return "redirect:/login"; // 로그인 페이지로 리다이렉트
    }
}