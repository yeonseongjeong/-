package kr.co.test.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
@Data
public class CartItem {

    @JsonProperty("productId")
    private Long productId;

    @JsonProperty("productName")
    private String productName;

    @JsonProperty("price")
    private Long price;

    @JsonProperty("quantity")
    private Integer quantity;

    @JsonProperty("productImage")
    private String productImage;

    // 기본 생성자
    public CartItem() {}

    // 모든 필드를 포함하는 생성자
    public CartItem(Long productId, String productName, Long price, Integer quantity, String productImage) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.productImage = productImage;
    }
}
