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
}
