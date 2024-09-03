package kr.co.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.test.repository.UserDAO;
import kr.co.test.vo.UserVO;

import static org.junit.Assert.assertEquals;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserDAOTest {

    @Autowired
    private UserDAO userDAO;

    private UserVO testUser;

    @Before
    public void setUp() {
        // 준비: 테스트에 사용할 사용자 정보를 생성
        testUser = new UserVO();
        testUser.setUserId(1);
        testUser.setUsername("TestUser");
        testUser.setEmail("testuser@example.com");
        testUser.setPassword("password");
        testUser.setPhoneNumber("010-1234-5678");
    }

    @Test
    public void testInsertUser() {
        // Insert user and check if one row was inserted
        int rowsInserted = userDAO.insertUser(testUser);
        assertEquals(1, rowsInserted);
    }

    @Test
    public void testDeleteUser() {
        // Insert user first
        userDAO.insertUser(testUser);
        
        // Delete the user and check if one row was deleted
        int rowsDeleted = userDAO.deleteUserById(testUser.getUserId());
        assertEquals(1, rowsDeleted);
    }

    @After
    public void tearDown() {
        // 정리: 테스트 후 남은 데이터 제거
        userDAO.deleteUserById(testUser.getUserId());
    }
}
