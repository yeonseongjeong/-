package kr.co.test.dto;

import lombok.Data;

@Data
public class OrderItemDTO {
    private int productId;
    private int quantity;
    private int price;

    // Getters and setters
}
