package kr.co.test.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.CartItemVO;
import kr.co.test.vo.UserVO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CartDAO {

    private final JdbcTemplate jdbcTemplate;

    public CartDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // 장바구니 아이템 가져오기
    public List<CartItemVO> getCartItems(int userId) {
        String query = "SELECT ci.product_id, ci.quantity, ci.price, p.product_name AS product_name, p.image_url " +
                       "FROM cart_items ci " +
                       "JOIN products p ON ci.product_id = p.product_id " +
                       "WHERE ci.user_id = ?";

        // 쿼리 실행 및 결과 매핑
        return jdbcTemplate.query(query, new Object[]{userId}, (rs, rowNum) -> {
            CartItemVO item = new CartItemVO();
            item.setProductId(rs.getInt("product_id"));
            item.setQuantity(rs.getInt("quantity"));
            item.setPrice(rs.getInt("price"));
            item.setProductName(rs.getString("product_name"));
            item.setImageUrl(rs.getString("image_url"));
            return item;
        });
    }
}
