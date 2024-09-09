package kr.co.test.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersVO {
	private Long orderId;
    private Long userId;
    private Date orderDate;
    private Double totalAmount;
    private String city;
    private String streetAddress;
    private String details;
}