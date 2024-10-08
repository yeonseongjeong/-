package kr.co.test.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
        String sql = "insert into products (product_id, product_name, category_id, price, stock_quantity, image_url) values (product_seq.NEXTVAL ,?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, product.getProductName(), product.getCategoryId(), product.getPrice(), product.getStockQuantity(), product.getImageUrl());    
    }
    
    public int deleteProduct(int productId) {
        String sql = "delete from products where product_id = ?";
        return jdbcTemplate.update(sql, productId);
    }
    
    public ProductVO getProductById(int productId) {
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity, image_url FROM products WHERE product_id = ?";
        
        List<ProductVO> products = jdbcTemplate.query(sql, new Object[]{productId}, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        });
        
        if (products.isEmpty()) {
            return null;  // ������ ���� ó���� ����� �� �ֽ��ϴ�.
        }
        
        return products.get(0);
    }
    // ��� ��ǰ�� ��ȸ�ϴ� �޼��� �߰�
    public List<ProductVO> getProducts() {
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity, image_url FROM products";
        
        return jdbcTemplate.query(sql, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        });
    }
    public List<ProductVO> getProductsByCategoryId(int categoryId) {
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity, image_url FROM products WHERE category_id = ?";
        
        return jdbcTemplate.query(sql, new Object[]{categoryId}, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        });
    }
    public List<ProductVO> getRandomProductsByCategoryId(int categoryId, int excludedProductId) {
        String sql = "SELECT * FROM ( " +
                     "    SELECT product_id, product_name, category_id, price, stock_quantity, image_url " +
                     "    FROM products " +
                     "    WHERE category_id = ? AND product_id != ? " +
                     "    ORDER BY DBMS_RANDOM.VALUE " +
                     ") WHERE ROWNUM <= 3";

        return jdbcTemplate.query(sql, new Object[]{categoryId, excludedProductId}, new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        });
    }
    public int updateProduct(ProductVO product) {
        String sql = "UPDATE products SET product_name = ?, category_id = ?, price = ?, stock_quantity = ? WHERE product_id = ?";
        return jdbcTemplate.update(sql, product.getProductName(), product.getCategoryId(), product.getPrice(), product.getStockQuantity(), product.getProductId());
    }

    public List<ProductVO> getProductsByIds(List<Integer> productIds) {
        // productIds가 비어 있으면 빈 리스트를 반환
        if (productIds == null || productIds.isEmpty()) {
            return new ArrayList<>();
        }

        // IN 절에 들어갈 ?의 개수를 productIds 리스트의 크기만큼 동적으로 생성
        String inSql = String.join(",", Collections.nCopies(productIds.size(), "?"));
        
        // SQL 쿼리 작성
        String sql = "SELECT product_id, product_name, category_id, price, stock_quantity, image_url " +
                     "FROM products WHERE product_id IN (" + inSql + ")";
        
        // JdbcTemplate을 사용하여 쿼리 실행
        List<ProductVO> products = jdbcTemplate.query(sql, productIds.toArray(), new RowMapper<ProductVO>() {
            @Override
            public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
                ProductVO product = new ProductVO();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPrice(rs.getInt("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImageUrl(rs.getString("image_url"));
                return product;
            }
        });

        // productIds 순서대로 제품을 정렬
        Map<Integer, ProductVO> productMap = products.stream()
                .collect(Collectors.toMap(ProductVO::getProductId, product -> product));

        return productIds.stream()
                .map(productMap::get)  // productIds 순서대로 정렬
                .collect(Collectors.toList());
    }






    
}
