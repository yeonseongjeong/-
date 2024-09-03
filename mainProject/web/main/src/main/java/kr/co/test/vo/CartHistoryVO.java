package kr.co.test.vo;

import lombok.Data;

@Data
public class CartHistoryVO {
	private Long cartHistoryId;
    private Long userId;
    private Long productId;
    private String action; // 'ADD' or 'REMOVE'
    private java.util.Date actionDate;
}