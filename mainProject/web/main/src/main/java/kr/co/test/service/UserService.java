package kr.co.test.service;

import kr.co.test.vo.UserVO;
import kr.co.test.repository.UserDAO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    // 회원 등록 (Insert)
    public boolean registerUser(UserVO user) {
        try {
            userDAO.insertUser(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 회원 조회 (Get by ID)
    public UserVO getUserById(int userId) {
        return userDAO.selectUserById(userId);
    }

    // 회원 삭제 (Delete)
    public boolean deleteUser(int userId) {
        try {
            int rowsDeleted = userDAO.deleteUserById(userId);
            return rowsDeleted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 로그인 처리 (간단한 예시)
    public UserVO login(String email, String password) {
        UserVO user = userDAO.selectUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
    public List<UserVO> getAllUsers() {
        return userDAO.selectAllUsers(); // DAO에서 모든 유저를 가져오는 메서드 호출
    }

}

