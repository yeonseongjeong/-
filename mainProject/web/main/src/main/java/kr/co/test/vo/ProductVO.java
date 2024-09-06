package kr.co.test.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int productId;
    private String productName;
    private int categoryId;
    private int price;
    private Integer stockQuantity;
}