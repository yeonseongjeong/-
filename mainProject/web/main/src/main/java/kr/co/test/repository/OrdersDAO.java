package kr.co.test.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


import kr.co.test.vo.OrdersVO;

@Repository
public class OrdersDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insertOrder(OrdersVO ordersVO) {
    	System.out.println("Inserting Order : " + ordersVO);
        String sql = "INSERT INTO orders (order_id, user_id, total_price, address, name, phone, order_date) "
                   + "VALUES (order_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
            ordersVO.getUserId(),
            ordersVO.getTotalPrice(),
            ordersVO.getAddress(),
            ordersVO.getName(),
            ordersVO.getPhone(),
            ordersVO.getOrderDate());
    }
}


