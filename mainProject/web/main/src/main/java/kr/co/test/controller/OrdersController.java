package kr.co.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.test.repository.OrdersDAO;
import kr.co.test.service.OrdersService;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.OrderItemsVO;

@Controller
public class OrdersController {

    @Autowired
    private OrdersDAO ordersDAO;

    @PostMapping("/placeOrder")
    public String placeOrder(@RequestBody OrdersVO ordersVO, HttpSession session) {
        // 세션에서 userId를 Integer로 가져와 Long으로 변환
        Integer userIdInt = (Integer) session.getAttribute("userId");
        if (userIdInt == null) {
            return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }

        // userId를 Long으로 변환
        Long userId = Long.valueOf(userIdInt);

        // 주문 날짜를 현재 시간으로 설정
        ordersVO.setUserId(userId);
        ordersVO.setOrderDate(new Date());

        // Orders 테이블에 데이터 삽입
        ordersDAO.insertOrder(ordersVO);

        return "redirect:/orderConfirmation"; // 주문 완료 페이지로 리다이렉트
    }



    @RequestMapping("/order")
    public ModelAndView showOrderPage(@RequestParam(value = "cartItems", required = false) String cartItemsJson) {
        ModelAndView mav = new ModelAndView("order");
        mav.addObject("cartItemsJson", cartItemsJson);
        return mav;
    }
      

    
}
