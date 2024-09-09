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

    public List<CartItemVO> getCartItems(int userId) {
        try {
            return cartDAO.getCartItems(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    // 장바구니에 아이템을 추가하는 메서드
    public void addCartItem(int userId, int productId, int quantity, int price) {
        try {
            // 데이터베이스에서 해당 사용자와 상품의 장바구니 항목이 있는지 확인
            CartItemVO existingItem = cartDAO.getCartItem(userId, productId);

            if (existingItem != null) {
                // 이미 장바구니에 동일한 상품이 있는 경우, 수량 업데이트
                int updatedQuantity = existingItem.getQuantity() + quantity;
                cartDAO.updateCartItemQuantity(userId, productId, updatedQuantity, price);
            } else {
                // 장바구니에 새로운 항목 추가
                cartDAO.addCartItem(userId, productId, quantity, price);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}



