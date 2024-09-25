package kr.co.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.test.repository.OrderItemsDAO;
import kr.co.test.repository.OrdersDAO;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.OrderItemsVO;

@Controller
public class OrdersController {

    @Autowired
    private OrdersDAO ordersDAO;
    
    @Autowired
    private OrderItemsDAO orderItemsDAO;

    @PostMapping("/placeOrder")
    public String placeOrder(
        @RequestParam("name") String name,
        @RequestParam("phone") String phone,
        @RequestParam("address") String address,
        @RequestParam("totalPrice") Double totalPrice,
        @RequestParam("productIds") String productIds,
        @RequestParam("quantities") String quantities,
        @RequestParam("prices") String prices,
        HttpSession session) {

    	// 입력된 값 출력해보기
        System.out.println("Product IDs: " + productIds);
        System.out.println("Quantities: " + quantities);
        System.out.println("Prices: " + prices);
    	
        Integer userIdInt = (Integer) session.getAttribute("userId");
        if (userIdInt == null) {
            return "redirect:/login"; 
        }

        Long userId = Long.valueOf(userIdInt);

        OrdersVO order = new OrdersVO();
        order.setName(name);
        order.setPhone(phone);
        order.setAddress(address);
        order.setUserId(userId);
        order.setOrderDate(new Date());
        order.setTotalPrice(totalPrice);

        Long orderId = ordersDAO.insertOrder(order); 
        if (orderId == null) {
            session.setAttribute("orderStatus", "failed");
            return "redirect:/orderResult"; 
        }

        order.setOrderId(orderId);

        String[] productIdArray = productIds.split(",");
        String[] quantityArray = quantities.split(",");
        String[] priceArray = prices.split(",");

        for (int i = 0; i < productIdArray.length; i++) {
            try {
                OrderItemsVO orderItem = new OrderItemsVO();
                orderItem.setOrderId(orderId);
                orderItem.setProductId(Long.parseLong(productIdArray[i]));
                orderItem.setQuantity(Integer.parseInt(quantityArray[i]));
                orderItem.setPrice(Double.parseDouble(priceArray[i]));
                orderItemsDAO.insertOrderItem(orderItem);
            } catch (NumberFormatException e) {
                continue;
            }
        }

        session.setAttribute("orderStatus", "success");
        return "redirect:/orderResult";
    }

    @RequestMapping("/orderResult")
    public String orderResult() {
        return "orderResult"; // orderConfirmation.jsp 파일로 이동
    }

    @RequestMapping("/order")
    public ModelAndView showOrderPage(@RequestParam(value = "cartItems", required = false) String cartItemsJson) {
        ModelAndView mav = new ModelAndView("order");
        mav.addObject("cartItemsJson", cartItemsJson);
        return mav;
    }
    
    @PostMapping("/erp/updateOrder")
    public String updateOrder(
            @RequestParam("orderId") Long orderId,
            @RequestParam("name") String name,
            @RequestParam("phone") String phone,
            @RequestParam("address") String address,
            @RequestParam("totalPrice") Double totalPrice) {
        
        OrdersVO order = new OrdersVO();
        order.setOrderId(orderId);
        order.setName(name);
        order.setPhone(phone);
        order.setAddress(address);
        order.setTotalPrice(totalPrice);
        
        ordersDAO.updateOrder(order); // OrdersDAO에 updateOrder 메서드 구현 필요
        return "redirect:/erp/orders"; // 수정 후 주문 목록으로 리다이렉트
    }


    @RequestMapping("/erp/editOrder")
    public ModelAndView editOrder(@RequestParam("orderId") Long orderId) {
        OrdersVO order = ordersDAO.getOrderById(orderId); // 주문 정보 조회
        ModelAndView mav = new ModelAndView("editOrder");
        mav.addObject("order", order);
        return mav;
    }

    @RequestMapping("/erp/deleteOrder")
    public String deleteOrder(@RequestParam("orderId") Long orderId) {
        ordersDAO.deleteOrder(orderId); // OrdersDAO에 deleteOrder 메서드 구현 필요
        return "redirect:/erp/orders";
    }
    @RequestMapping("/erp/orders")
    public ModelAndView showOrderList() {
        List<OrdersVO> orderList = ordersDAO.getAllOrders(); // 모든 주문을 가져오는 메서드
        Double totalSales = ordersDAO.getTotalSales(); // 전체 판매 가격 계산

        // 전체 판매 가격을 문자열로 포맷팅
        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedTotalSales = formatter.format(totalSales); // 소수점 이하 0자리로 포맷팅

        ModelAndView mav = new ModelAndView("orderList"); // orderList.jsp를 반환
        mav.addObject("orderList", orderList);
        mav.addObject("totalSales", formattedTotalSales); // 포맷팅된 전체 판매 가격 추가
        return mav;
    }




}
