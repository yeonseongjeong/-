package kr.co.test.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.test.repository.CartHistoryDAO;
import kr.co.test.vo.CartHistoryVO;

@Service
public class CartHistoryService {

    @Autowired
    private CartHistoryDAO cartHistoryDAO;

    public void saveCartHistory(int userId, int productId, String action) {
        CartHistoryVO cartHistory = new CartHistoryVO();
        cartHistory.setUserId(userId);
        cartHistory.setProductId(productId);
        cartHistory.setAction(action);
        cartHistory.setActionDate(new Date());
        
        cartHistoryDAO.insertCartHistory(cartHistory);
    }
}
