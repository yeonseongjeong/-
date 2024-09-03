package kr.co.test.vo;

import lombok.Data;

@Data
public class ProductDescriptionVO {
	private Long descriptionId;
    private Long productId;
    private String language;
    private String description;
}