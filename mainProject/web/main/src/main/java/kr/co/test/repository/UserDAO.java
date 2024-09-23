package kr.co.test.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.UserVO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDAO {

    private final JdbcTemplate jdbcTemplate;

    public UserDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // 회원 정보 삽입
    public int insertUser(UserVO user) {
        String sql = "INSERT INTO USERS (USER_ID, USERNAME, EMAIL, PASSWORD, PHONE_NUMBER, GRADE) VALUES (USER_ID_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, user.getUsername(), user.getEmail(), user.getPassword(), user.getPhoneNumber(), "common");
    }

    // 회원 ID로 삭제
    public int deleteUserById(int userId) {
        String sql = "DELETE FROM USERS WHERE USER_ID = ?";
        return jdbcTemplate.update(sql, userId);
    }

    // 회원 ID로 조회
    public UserVO selectUserById(int userId) {
        String sql = "SELECT * FROM USERS WHERE USER_ID = ?";
        return jdbcTemplate.queryForObject(sql, new UserRowMapper(), userId);
    }

    // 이메일로 회원 조회 (로그인용)
    public UserVO selectUserByEmail(String email) {
        String sql = "SELECT * FROM USERS WHERE EMAIL = ?";
        return jdbcTemplate.queryForObject(sql, new UserRowMapper(), email);
    }

    // RowMapper 구현 (ResultSet을 UserVO로 매핑)
    private static class UserRowMapper implements RowMapper<UserVO> {
        @Override
        public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
            UserVO user = new UserVO();
            user.setUserId(rs.getInt("USER_ID")); // 자동 증가 필드
            user.setUsername(rs.getString("USERNAME"));
            user.setEmail(rs.getString("EMAIL"));
            user.setPassword(rs.getString("PASSWORD"));
            user.setPhoneNumber(rs.getString("PHONE_NUMBER"));
            user.setGrade(rs.getString("GRADE"));
            return user;
        }
    }
    public List<UserVO> selectAllUsers() {
        String sql = "SELECT * FROM USERS";
        return jdbcTemplate.query(sql, new UserRowMapper());
    }

}
