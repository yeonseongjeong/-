package kr.co.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.test.repository.OrderItemsDAO;
import kr.co.test.vo.OrderItemsVO;

@Service
public class OrderItemsService {

    @Autowired
    private OrderItemsDAO orderItemsDAO;

    // 특정 주문 번호에 해당하는 주문 항목을 가져오는 메서드
    public List<OrderItemsVO> getOrderItemsByOrderId(Long orderId) {
        return orderItemsDAO.getOrderItemsByOrderId(orderId);
    }
}
