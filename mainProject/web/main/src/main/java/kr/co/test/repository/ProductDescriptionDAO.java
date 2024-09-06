package kr.co.test.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import kr.co.test.vo.ProductDescriptionVO;


@Repository
public class ProductDescriptionDAO {
	
	private final JdbcTemplate jdbcTemplate;
	
	public ProductDescriptionDAO(JdbcTemplate jdbcTemplate){
		this.jdbcTemplate = jdbcTemplate;
	}
	public int insertProductDescription(ProductDescriptionVO description){
		String sql="insert into product_descriptions (description_id,product_id,language,description) values (?,?,?,?)";
		return jdbcTemplate.update(sql, description.getDescriptionId(),description.getProductId(),description.getLanguage(),description.getDescription());	
	}
	public int deleteProduct(int descriptionId) {
		String sql="delete from product_descriptions where description_id=?";
		return jdbcTemplate.update(sql,descriptionId);
	}
	public ProductDescriptionVO getProductDescriptionById(int productId) {
        String sql = "SELECT * FROM product_descriptions WHERE product_id = ?";
        
        List<ProductDescriptionVO> descriptions = jdbcTemplate.query(sql, new Object[]{productId}, new RowMapper<ProductDescriptionVO>() {
            @Override
            public ProductDescriptionVO mapRow(ResultSet rs, int rowNum) throws SQLException {
            	ProductDescriptionVO description = new ProductDescriptionVO();
            	description.setDescriptionId(rs.getLong("description_id"));
            	description.setProductId(rs.getLong("product_id"));
            	description.setLanguage(rs.getString("language"));
            	description.setDescription(rs.getString("description"));
                
                return description;
            }
        });
        
        if (descriptions.isEmpty()) {
            return null;  // 적절한 예외 처리도 고려할 수 있습니다.
        }
        
        return descriptions.get(0);
    }
}
