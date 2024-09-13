package kr.co.test.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;

import kr.co.test.vo.OrdersVO;

@Repository
public class OrdersDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Long insertOrder(OrdersVO ordersVO) {
        System.out.println("Inserting Order : " + ordersVO);

        String insertSql = "INSERT INTO orders (order_id, user_id, total_price, address, name, phone, order_date) "
                         + "VALUES (order_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";

        // 주문 데이터 삽입
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(insertSql);
            ps.setLong(1, ordersVO.getUserId());
            ps.setDouble(2, ordersVO.getTotalPrice());
            ps.setString(3, ordersVO.getAddress());
            ps.setString(4, ordersVO.getName());
            ps.setString(5, ordersVO.getPhone());
            ps.setDate(6, new java.sql.Date(ordersVO.getOrderDate().getTime()));
            return ps;
        });

        // 마지막으로 생성된 order_id를 가져오기
        String selectSql = "SELECT order_seq.CURRVAL FROM dual";
        return jdbcTemplate.queryForObject(selectSql, Long.class);
    }
}
