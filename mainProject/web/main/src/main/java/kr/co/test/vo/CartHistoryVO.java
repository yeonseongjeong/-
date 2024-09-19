package kr.co.test.vo;

import lombok.Data;

@Data
public class CartHistoryVO {
	private Long cartHistoryId;
    private int userId;
    private int productId;
    private String action; // 'ADD' or 'REMOVE'
    private java.util.Date actionDate;
}