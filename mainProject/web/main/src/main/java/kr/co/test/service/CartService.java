package kr.co.test.service;

import kr.co.test.vo.CartItemVO;
import kr.co.test.vo.UserVO;
import kr.co.test.repository.CartDAO;
import kr.co.test.repository.UserDAO;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {

    @Autowired
    private CartDAO cartDAO;

    /**
     * 사용자의 장바구니 아이템을 가져옵니다.
     *
     * @param userId 사용자의 ID
     * @return 장바구니 아이템 목록
     */
    public List<CartItemVO> getCartItems(int userId) {
        try {
            // DAO를 통해 장바구니 아이템을 가져옵니다.
            return cartDAO.getCartItems(userId);
        } catch (Exception e) {
            // 예외 처리 (로그 기록 등)
            e.printStackTrace();
            // 예외를 재던지거나 빈 리스트를 반환할 수 있습니다.
            // throw new RuntimeException("Failed to fetch cart items", e);
            return Collections.emptyList();
        }
    }

    // 추가적인 비즈니스 로직이 필요한 경우 여기에 메서드를 추가할 수 있습니다.
}


