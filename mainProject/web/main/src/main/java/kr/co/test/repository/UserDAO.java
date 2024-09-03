package kr.co.test.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.UserVO;

@Repository
public class UserDAO {

    private final JdbcTemplate jdbcTemplate;

    public UserDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int insertUser(UserVO user) {
        String sql = "INSERT INTO USERS (USER_ID, USERNAME, EMAIL, PASSWORD, PHONE_NUMBER) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, user.getUserId(), user.getUsername(), user.getEmail(), user.getPassword(), user.getPhoneNumber());
    }

    public int deleteUserById(int userId) {
        String sql = "DELETE FROM USERS WHERE USER_ID = ?";
        return jdbcTemplate.update(sql, userId);
    }
}
