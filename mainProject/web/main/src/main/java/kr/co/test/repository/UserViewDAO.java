package kr.co.test.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.UserViewVO;

@Repository
public class UserViewDAO {
    
    private final JdbcTemplate jdbcTemplate;
    
    public UserViewDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public void insertUserView(UserViewVO userView) {
        String sql = "INSERT INTO user_views (view_id, user_id, product_id, viewed_at) VALUES (user_view_seq.NEXTVAL, ?, ?, ?)";
        jdbcTemplate.update(sql, userView.getUserId(), userView.getProductId(), userView.getViewedAt());
    }
}
