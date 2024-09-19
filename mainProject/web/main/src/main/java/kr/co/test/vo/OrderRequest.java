package kr.co.test.vo;

import java.util.List;

import kr.co.test.dto.OrderItemDTO;
import lombok.Data;

@Data
public class OrderRequest {
    private int userId;
    private String name;
    private String address;
    private String phone;
    private List<OrderItemDTO> items;
}

