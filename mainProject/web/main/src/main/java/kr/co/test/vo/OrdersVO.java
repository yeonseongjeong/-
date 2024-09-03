package kr.co.test.vo;

import lombok.Data;

@Data
public class OrdersVO {
	private Long orderId;
    private Long userId;
    private java.util.Date orderDate;
    private Double totalAmount;
    private String city;
    private String streetAddress;
    private String details;
}