package kr.co.test.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.OrderItemsVO;

@Repository
public class OrderItemsDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insertOrderItem(OrderItemsVO orderItemVO) {
        String sql = "INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES (order_id_seq.NEXTVAL, ?, ?, ?, ?)";

        jdbcTemplate.update(sql, 
            orderItemVO.getOrderId(),
            orderItemVO.getProductId(),
            orderItemVO.getQuantity(),
            orderItemVO.getPrice());
    }
}