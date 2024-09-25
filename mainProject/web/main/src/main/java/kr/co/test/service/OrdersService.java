package kr.co.test.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.test.repository.OrdersDAO;
import kr.co.test.vo.OrdersVO;

@Service
public class OrdersService {

    @Autowired
    private OrdersDAO orderDAO;

    public List<OrdersVO> getOrdersByUserId(Long userId) {
        return orderDAO.getOrdersByUserId(userId);
    }
}
