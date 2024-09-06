package kr.co.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.test.repository.ProductDescriptionDAO;
import kr.co.test.vo.ProductDescriptionVO;

@Service
public class ProductDescriptionService {
	
	private ProductDescriptionDAO productDescriptionDAO ;
	
	@Autowired
    public ProductDescriptionService(ProductDescriptionDAO productDecriptionDAO) {
        this.productDescriptionDAO = productDecriptionDAO;
	}
	
	public ProductDescriptionVO getProductDescriptionById(int productId) {
        return productDescriptionDAO.getProductDescriptionById(productId);   
	}
}
