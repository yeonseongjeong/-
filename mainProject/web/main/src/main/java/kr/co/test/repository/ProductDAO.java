package kr.co.test.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.ProductDescriptionVO;
import kr.co.test.vo.ProductVO;

@Repository
public class ProductDAO {
    
    private final JdbcTemplate jdbcTemplate;
    
    public ProductDAO(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public int insertProduct(ProductVO product){
        String sql = "insert into products (product_id, product_name, category_id, price, stock_quantity) values (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, product.getProductId(), product.getProductName(), product.getCategoryId(), product.getPrice(), product.getStockQuantity());    
    }
    
    public int deleteProduct(int productId) {
        String sql = "delete from products where product_id = ?";
        return jdbcTemplate.update(sql, productId);
    }
    
    public ProductVO getProductById(int productId) {
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity FROM products WHERE product_id = ?";
        
        List<ProductVO> products = jdbcTemplate.query(sql, new Object[]{productId}, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                return product;
            }
        });
        
        if (products.isEmpty()) {
            return null;  // 적절한 예외 처리도 고려할 수 있습니다.
        }
        
        return products.get(0);
    }
    // 모든 제품을 조회하는 메서드 추가
    public List<ProductVO> getProducts() {
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity FROM products";
        
        return jdbcTemplate.query(sql, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                return product;
            }
        });
    }
    
}
