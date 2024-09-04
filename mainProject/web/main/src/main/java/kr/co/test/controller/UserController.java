package kr.co.test.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

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
    // 회원가입 폼 요청 처리
    @GetMapping("/signup")
    public String signupForm() {
        return "signup"; // 회원가입 폼을 보여주는 페이지 반환
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String signup(@RequestParam("name") String name,
                         @RequestParam("email") String email,
                         @RequestParam("password") String password,
                         @RequestParam("confirmPassword") String confirmPassword,
                         @RequestParam("phoneNumber") String phoneNumber,
                         Model model) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "signup"; // 비밀번호 불일치 시 회원가입 페이지로 이동
        }
        String hashedPassword = passwordEncoder.encode(password);

        UserVO newUser = new UserVO();
        newUser.setUsername(name);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhoneNumber(phoneNumber); // 전화번호 추가

        boolean success = userService.registerUser(newUser);

        if (success) {
            return "redirect:/login"; // 회원가입 성공 시 로그인 페이지로 리다이렉트
        } else {
            model.addAttribute("error", "회원가입 실패. 다시 시도해 주세요.");
            return "signup"; // 회원가입 실패 시 회원가입 페이지로 돌아감
        }
    }
}