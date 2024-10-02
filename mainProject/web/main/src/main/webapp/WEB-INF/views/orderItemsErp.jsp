<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.test.vo.OrderItemsVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 항목 목록</title>
</head>
<body>

<h1>주문 항목</h1>

<table>
    <thead>
        <tr>
            <th>상품 ID</th>
            <th>상품명</th>
            <th>수량</th>
            <th>가격</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<OrderItemsVO> orderItems = (List<OrderItemsVO>) request.getAttribute("orderItems");
            if (orderItems != null && !orderItems.isEmpty()) {
                for (OrderItemsVO item : orderItems) {
        %>
        <tr>
            <td><%= item.getProductId() %></td>
            <td><%= item.getProductName() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getPrice() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4">주문 항목이 없습니다.</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<a href="/erp/orders">주문 목록으로 돌아가기</a>

</body>
</html>
