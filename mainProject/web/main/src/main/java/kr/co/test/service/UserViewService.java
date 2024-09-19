package kr.co.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.test.repository.UserViewDAO;
import kr.co.test.vo.UserViewVO;

@Service
public class UserViewService {

    private final UserViewDAO userViewDAO;
    
    @Autowired
    public UserViewService(UserViewDAO userViewDAO) {
        this.userViewDAO = userViewDAO;
    }

    public void saveUserView(int userId, int productId) {
        UserViewVO userView = new UserViewVO();
        userView.setUserId(userId);
        userView.setProductId(productId);
        userView.setViewedAt(new java.util.Date());
        
        userViewDAO.insertUserView(userView);
    }
}
