package kr.co.test.service;

import kr.co.test.repository.ProductDAO;
import kr.co.test.vo.ProductVO;

import java.util.List;

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
    
    
    // 추가적인 서비스 메소드들을 여기에 작성할 수 있습니다.
}
