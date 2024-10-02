package kr.co.test.service;

import kr.co.test.repository.ProductDAO;
import kr.co.test.vo.ProductVO;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

    private final ProductDAO productDAO;
    
    @Autowired
    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }
    
    
    public ProductVO getProductById(int productId) {
        return productDAO.getProductById(productId);
    }
    public List<ProductVO> getProducts() {
        return productDAO.getProducts();
    }
    public List<ProductVO> getProductsByCategoryId(int categoryId) {
        return productDAO.getProductsByCategoryId(categoryId);
    }
    public List<ProductVO> getRandomRelatedProducts(int categoryId, int excludedProductId) {
        return productDAO.getRandomProductsByCategoryId(categoryId, excludedProductId);
    }
    
    public void addProduct(ProductVO product) {
        productDAO.insertProduct(product);
    }
    public void updateProduct(ProductVO product) {
        productDAO.updateProduct(product);
    }
 // 추천된 productId에 해당하는 제품 목록을 가져오는 메서드
    public List<ProductVO> getProductsByIds(List<Integer> productIds) {
        return productDAO.getProductsByIds(productIds);
    }
 // 상품 수량을 줄이는 메서드 추가
    public void reduceProductStock(int productId, int quantity) {
        ProductVO product = productDAO.getProductById(productId);
        if (product != null) {
            int newStock = product.getStockQuantity() - quantity;
            if (newStock >= 0) {
                product.setStockQuantity(newStock);
                productDAO.updateProduct(product); // 재고 업데이트
            } else {
                throw new RuntimeException("재고가 부족합니다.");
            }
        }
    }
}
