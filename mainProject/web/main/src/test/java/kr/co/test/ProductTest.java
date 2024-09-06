package kr.co.test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.test.repository.ProductDAO;
import kr.co.test.vo.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductTest {
	@Autowired
	private ProductDAO dao;
	
	private ProductVO testProduct;
	@Test
	public void setUp() {
		dao.getProductById(1);
    }
}
