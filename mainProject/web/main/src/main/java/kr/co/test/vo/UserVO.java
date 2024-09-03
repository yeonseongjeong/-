package kr.co.test.vo;

import lombok.Data;

@Data
public class UserVO {
    private int userId;
    private String username;
    private String email;
    private String password;
    private String phoneNumber;
}