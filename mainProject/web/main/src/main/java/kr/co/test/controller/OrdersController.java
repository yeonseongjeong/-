package kr.co.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.test.service.OrdersService;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.OrderItemsVO;

@Controller
public class OrdersController {

    @Autowired
    private OrdersService ordersService;

    @RequestMapping("/order")
    public ModelAndView showOrderPage(@RequestParam(value = "cartItems", required = false) String cartItemsJson) {
        ModelAndView mav = new ModelAndView("order");
        mav.addObject("cartItemsJson", cartItemsJson);
        return mav;
    }

    @RequestMapping("/placeOrder")
    public String placeOrder(HttpServletRequest request) {
        try {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String cartItemsJson = request.getParameter("cartItems");

            // Create OrdersVO
            OrdersVO order = new OrdersVO();
            order.setUserId(1L); // Example user ID, replace with actual
            order.setOrderDate(new java.util.Date());
            order.setTotalAmount(calculateTotalAmount(cartItemsJson));
            order.setCity(parseCity(address));
            order.setStreetAddress(parseStreetAddress(address));
            order.setDetails(parseDetails(address));

            // Convert cartItemsJson to List<OrderItemsVO>
            List<OrderItemsVO> orderItems = parseOrderItems(cartItemsJson);

            // Save order and order items
            Long orderId = ordersService.placeOrder(order, orderItems);

            return "redirect:/orderConfirmation?orderId=" + orderId;

        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    private double calculateTotalAmount(String cartItemsJson) {
        // Implement logic to calculate the total amount based on cartItemsJson
        return 0.0;
    }

    private String parseCity(String address) {
        // Implement logic to parse city from address
        return "";
    }

    private String parseStreetAddress(String address) {
        // Implement logic to parse street address from address
        return "";
    }

    private String parseDetails(String address) {
        // Implement logic to parse additional details from address
        return "";
    }

    private List<OrderItemsVO> parseOrderItems(String cartItemsJson) {
        // Implement logic to parse cartItemsJson into a List<OrderItemsVO>
        return new ArrayList<>();
    }
}
