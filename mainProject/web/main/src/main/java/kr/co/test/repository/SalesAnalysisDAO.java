package kr.co.test.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SalesAnalysisDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 카테고리별 판매 데이터를 특정 기간에 맞춰 가져오는 메서드
    public List<Map<String, Object>> getSalesDataByCategory(String startDate, String endDate) {
        // 모든 카테고리 목록 조회
        String allCategoriesSql = "SELECT category_name FROM categories";
        List<Map<String, Object>> allCategories = jdbcTemplate.queryForList(allCategoriesSql);

        // 특정 기간의 판매 데이터 조회
        String salesDataSql = "SELECT c.category_name, SUM(oi.quantity) AS total_quantity " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.product_id " +
                "JOIN categories c ON p.category_id = c.category_id " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE TRUNC(o.order_date) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                "GROUP BY c.category_name";
        System.out.println(jdbcTemplate.queryForList(salesDataSql, new Object[]{startDate, endDate}));
        List<Map<String, Object>> salesData = jdbcTemplate.queryForList(salesDataSql, new Object[]{startDate, endDate});
        
        // 모든 카테고리 목록에 판매 데이터 병합
        for (Map<String, Object> category : allCategories) {
            String categoryName = (String) category.get("CATEGORY_NAME");
            boolean found = false;

            // 판매 데이터에서 해당 카테고리 찾기
            for (Map<String, Object> sale : salesData) {
                if (categoryName.equals(sale.get("CATEGORY_NAME"))) {
                    category.put("TOTAL_QUANTITY", sale.get("TOTAL_QUANTITY"));
                    found = true;
                    break;
                }
            }

            // 판매 내역이 없으면 판매량을 0으로 설정
            if (!found) {
                category.put("TOTAL_QUANTITY", 0);
            }
        }

        return allCategories;
    }

    // 카테고리별 매출 데이터를 특정 기간에 맞춰 가져오는 메서드
    public List<Map<String, Object>> getRevenueDataByCategory(String startDate, String endDate) {
        // 모든 카테고리 목록 조회
        String allCategoriesSql = "SELECT category_name FROM categories";
        List<Map<String, Object>> allCategories = jdbcTemplate.queryForList(allCategoriesSql);

        // 특정 기간의 매출 데이터 조회
        String revenueDataSql = "SELECT c.category_name, NVL(SUM(oi.price * oi.quantity), 0) AS total_revenue " +
                "FROM categories c " +
                "LEFT JOIN products p ON c.category_id = p.category_id " +
                "LEFT JOIN order_items oi ON p.product_id = oi.product_id " +
                "LEFT JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE TRUNC(o.order_date) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                "GROUP BY c.category_name";
        
        List<Map<String, Object>> revenueData = jdbcTemplate.queryForList(revenueDataSql, new Object[]{startDate, endDate});

        // 모든 카테고리 목록에 매출 데이터 병합
        for (Map<String, Object> category : allCategories) {
            String categoryName = (String) category.get("CATEGORY_NAME");
            boolean found = false;

            // 매출 데이터에서 해당 카테고리 찾기
            for (Map<String, Object> revenue : revenueData) {
                if (categoryName.equals(revenue.get("CATEGORY_NAME"))) {
                    category.put("TOTAL_REVENUE", revenue.get("TOTAL_REVENUE"));
                    found = true;
                    break;
                }
            }

            // 매출 내역이 없으면 매출액을 0으로 설정
            if (!found) {
                category.put("TOTAL_REVENUE", 0);
            }
        }

        return allCategories;
    }
    public List<Map<String, Object>> getTotalSalesAndRevenue(String startDate, String endDate, String periodType) {
        String sql = "";
        
        switch (periodType) {
            case "DAILY":
                sql = "SELECT TRUNC(o.order_date) AS period, SUM(oi.quantity) AS total_quantity, SUM(oi.price * oi.quantity) AS total_revenue " +
                      "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                      "WHERE TRUNC(o.order_date) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                      "GROUP BY TRUNC(o.order_date) " +
                      "ORDER BY TRUNC(o.order_date)";
                break;
            case "WEEKLY":
                sql = "SELECT TO_CHAR(o.order_date, 'IW') AS period, SUM(oi.quantity) AS total_quantity, SUM(oi.price * oi.quantity) AS total_revenue " +
                      "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                      "WHERE TRUNC(o.order_date) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                      "GROUP BY TO_CHAR(o.order_date, 'IW') " +
                      "ORDER BY TO_CHAR(o.order_date, 'IW')";
                break;
            case "MONTHLY":
                sql = "SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS period, SUM(oi.quantity) AS total_quantity, SUM(oi.price * oi.quantity) AS total_revenue " +
                      "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                      "WHERE TRUNC(o.order_date) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') " +
                      "GROUP BY TO_CHAR(o.order_date, 'YYYY-MM') " +
                      "ORDER BY TO_CHAR(o.order_date, 'YYYY-MM')";
                break;
            default:
                throw new IllegalArgumentException("Invalid period type: " + periodType);
        }
        
        // SQL 출력 (디버깅용)
        //System.out.println("SQL Query: " + sql);
        
        // 결과 실행
        List<Map<String, Object>> result = jdbcTemplate.queryForList(sql, startDate, endDate);
        //System.out.println("Result: " + result);  // 결과 출력 (디버깅용)

        return result;
    }

}
