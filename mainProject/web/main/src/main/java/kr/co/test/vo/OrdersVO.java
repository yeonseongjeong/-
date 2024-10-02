package kr.co.test.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersVO {
	private Long orderId;
    private Long userId;
    private Date orderDate;
    private Double totalPrice;
    private String address;
    private String name;
    private String phone;
    private int delivery;
}