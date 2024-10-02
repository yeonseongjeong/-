package kr.co.test.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.test.service.OrderItemsService;
import kr.co.test.vo.OrderItemsVO;

@Controller
public class OrderItemsController {

    @Autowired
    private OrderItemsService orderItemsService;

    @GetMapping("/order/{orderId}/items")
    public String showOrderItems(@PathVariable("orderId") Long orderId, Model model, HttpSession session) {
        // 특정 주문 번호에 대한 주문 항목을 가져옴
        List<OrderItemsVO> orderItems = orderItemsService.getOrderItemsByOrderId(orderId);
        model.addAttribute("orderItems", orderItems);
        return "orderItems";  // 주문 항목을 표시할 JSP 파일로 이동
    }
    @GetMapping("/erp/orderItemsErp")
    public String showOrderItemsErp(@RequestParam("orderId") Long orderId, Model model, HttpSession session) {
        // 특정 주문 번호에 대한 주문 항목을 가져옴
        List<OrderItemsVO> orderItems = orderItemsService.getOrderItemsByOrderId(orderId);
        model.addAttribute("orderItems", orderItems);
        return "orderItemsErp";  // 주문 항목을 표시할 JSP 파일로 이동
    }
}
