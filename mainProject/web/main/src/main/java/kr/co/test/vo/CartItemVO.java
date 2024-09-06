package kr.co.test.vo;

import lombok.Data;

@Data
public class CartItemVO {
	private int userId;
    private int productId;
    private String productName;
    private String imageUrl;
    private int quantity;
    private int price;
}