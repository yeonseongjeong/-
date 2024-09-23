package kr.co.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/erp")
public class ErpController {

    @GetMapping("/dashboard")
    public String showDashboard() {
        return "dashboard"; // dashboard.jsp를 반환
    }

    // 다른 매핑 추가 가능
}
