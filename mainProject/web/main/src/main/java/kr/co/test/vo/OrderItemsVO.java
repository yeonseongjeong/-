package kr.co.test.vo;

import lombok.Data;

@Data
public class OrderItemsVO {
	private Long orderItemId;
    private Long orderId;
    private Long productId;
    private Integer quantity;
    private Double price;
}