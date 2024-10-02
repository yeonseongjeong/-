package kr.co.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.test.repository.OrdersDAO;
import kr.co.test.service.OrderItemsService;
import kr.co.test.service.ProductService;
import kr.co.test.vo.OrderItemsVO;

import java.util.List;

@Controller
public class SendOrderController {

    @Autowired
    private OrderItemsService orderItemsService;

    @Autowired
    private ProductService productService;

    @Autowired
    private OrdersDAO ordersDAO; // OrdersDAO를 주입받음

    @PostMapping("/erp/sendOrder")
    public String sendOrder(@RequestParam("orderId") Long orderId, Model model) {
        // 특정 주문의 아이템을 가져옴
        List<OrderItemsVO> orderItems = orderItemsService.getOrderItemsByOrderId(orderId);
        
        // null 체크 추가
        if (orderItems == null || orderItems.isEmpty()) {
            return "redirect:/erp/orders"; // 주문 목록으로 리다이렉트
        }
        // 이미 발송된 주문인지 체크
        boolean isAlreadySent = ordersDAO.isOrderSent(orderId);
        if (isAlreadySent) {
            model.addAttribute("errorMessage", "이미 발송한 상품입니다.");
            return "redirect:/erp/orders"; // 오류 메시지 전달 후 주문 목록으로 리다이렉트
        }
        // 각 주문 아이템에 대해 발송 여부를 "발송됨"으로 변경하고, 상품 수량을 줄임
        for (OrderItemsVO item : orderItems) {
            productService.reduceProductStock(item.getProductId().intValue(), item.getQuantity());
        }

        // 발송 상태 업데이트
        ordersDAO.updateDeliveryStatus(orderId, 1); // 1로 업데이트

        return "redirect:/erp/orders"; // 주문 목록으로 리다이렉트
    }
}
