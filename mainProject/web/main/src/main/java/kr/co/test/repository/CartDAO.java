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

    public List<CartItemVO> getCartItems(int userId) {
        String query = "SELECT ci.product_id, ci.quantity, ci.price, p.product_name, p.image_url " +
                       "FROM cart_items ci JOIN products p ON ci.product_id = p.product_id " +
                       "WHERE ci.user_id = ?";
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

    // 사용자와 상품으로 기존 장바구니 항목을 조회하는 메서드
    public CartItemVO getCartItem(int userId, int productId) {
        String query = "SELECT * FROM cart_items WHERE user_id = ? AND product_id = ?";
        try {
            return jdbcTemplate.queryForObject(query, new Object[]{userId, productId}, (rs, rowNum) -> {
                CartItemVO item = new CartItemVO();
                item.setUserId(rs.getInt("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getInt("price"));
                return item;
            });
        } catch (Exception e) {
            return null;  // 장바구니에 동일한 상품이 없는 경우
        }
    }

    // 장바구니에 새로운 항목을 추가하는 메서드
    public void addCartItem(int userId, int productId, int quantity, int price) {
        String query = "INSERT INTO cart_items (user_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(query, userId, productId, quantity, price);
    }

    // 장바구니 항목 수량을 업데이트하는 메서드
    public void updateCartItemQuantity(int userId, int productId, int quantity, int price) {
        String query = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND product_id = ?";
        jdbcTemplate.update(query, quantity, userId, productId);
    }
}
