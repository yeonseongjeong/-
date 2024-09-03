package kr.co.test.vo;

import lombok.Data;

@Data
public class ProductVO {
	private Long productId;
    private String productName;
    private Long categoryId;
    private Double price;
    private Integer stockQuantity;
}