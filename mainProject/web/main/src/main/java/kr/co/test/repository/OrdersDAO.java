package kr.co.test.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import kr.co.test.vo.OrdersVO;
import kr.co.test.vo.OrderItemsVO;

@Repository
public class OrdersDAO {

    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

    public OrdersDAO(JdbcTemplate jdbcTemplate, DataSource dataSource) {
        this.jdbcTemplate = jdbcTemplate;
        this.dataSource = dataSource;
    }

    public void insertOrder(OrdersVO order) {
        String sql = "INSERT INTO orders (user_id, order_date, total_amount, city, street_address, details) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setLong(1, order.getUserId());
            pstmt.setDate(2, new java.sql.Date(order.getOrderDate().getTime()));
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getCity());
            pstmt.setString(5, order.getStreetAddress());
            pstmt.setString(6, order.getDetails());

            pstmt.executeUpdate();

            // Get the generated orderId
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    // Ensure the column type here matches the database type
                    Long orderId = rs.getLong(1);
                    order.setOrderId(orderId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exception
        }
    }

    public void insertOrderItem(OrderItemsVO orderItem) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) " +
                     "VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, orderItem.getOrderId(), orderItem.getProductId(), 
                            orderItem.getQuantity(), orderItem.getPrice());
    }
}
