package kr.co.test.vo;

import lombok.Data;

@Data
public class UserViewVO {
	private int viewId;
    private int userId;
    private int productId;
    private java.util.Date viewedAt;
}