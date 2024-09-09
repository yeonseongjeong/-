package kr.co.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.test.repository.OrdersDAO;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.OrderItemsVO;

import java.util.List;

@Service
public class OrdersService {

    @Autowired
    private OrdersDAO ordersDAO;

    @Transactional
    public Long placeOrder(OrdersVO order, List<OrderItemsVO> orderItems) {
        // Insert order
        ordersDAO.insertOrder(order);

        // Insert order items
        for (OrderItemsVO item : orderItems) {
            item.setOrderId(order.getOrderId());
            ordersDAO.insertOrderItem(item);
        }

        return order.getOrderId();
    }
}
