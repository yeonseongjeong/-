package kr.co.test.vo;

import lombok.Data;

@Data
public class UserViewVO {
	private Long viewId;
    private Long userId;
    private Long productId;
    private java.util.Date viewedAt;
}