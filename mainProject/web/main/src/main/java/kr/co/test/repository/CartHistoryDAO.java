package kr.co.test.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.CartHistoryVO;

@Repository
public class CartHistoryDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public CartHistoryDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void insertCartHistory(CartHistoryVO cartHistory) {
        String sql = "INSERT INTO cart_history (cart_history_id, user_id, product_id, action, action_date) " +
                     "VALUES (cart_history_seq.NEXTVAL, ?, ?, ?, ?)";
        
        jdbcTemplate.update(sql, cartHistory.getUserId(), cartHistory.getProductId(),
                            cartHistory.getAction(), cartHistory.getActionDate());
    }
}
