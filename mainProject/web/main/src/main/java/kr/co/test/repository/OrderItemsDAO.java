package kr.co.test.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
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
 // 특정 주문 번호(orderId)에 해당하는 주문 항목을 가져오는 메서드
    public List<OrderItemsVO> getOrderItemsByOrderId(Long orderId) {
        String sql = "SELECT oi.order_item_id, oi.order_id, oi.product_id, p.product_name, oi.quantity, oi.price " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.product_id " +
                     "WHERE oi.order_id = ?";

        return jdbcTemplate.query(sql, new Object[] { orderId }, orderItemRowMapper());
    }

    // RowMapper 설정
    private RowMapper<OrderItemsVO> orderItemRowMapper() {
        return (rs, rowNum) -> {
            OrderItemsVO orderItem = new OrderItemsVO();
            orderItem.setOrderItemId(rs.getLong("order_item_id"));
            orderItem.setOrderId(rs.getLong("order_id"));
            orderItem.setProductId(rs.getLong("product_id"));
            orderItem.setProductName(rs.getString("product_name")); // productName 설정
            orderItem.setQuantity(rs.getInt("quantity"));
            orderItem.setPrice(rs.getDouble("price"));
            return orderItem;
        };
    }
}