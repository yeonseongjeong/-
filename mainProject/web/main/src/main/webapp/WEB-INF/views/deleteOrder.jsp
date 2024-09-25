<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="kr.co.test.repository.OrdersDAO" %>
<%@ page import="kr.co.test.vo.OrdersVO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    Long orderId = Long.parseLong(request.getParameter("orderId"));
    OrdersDAO ordersDAO = new OrdersDAO(); // 실제 환경에서는 의존성 주입 사용
    OrdersVO order = ordersDAO.getOrderById(orderId);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 삭제 확인</title>
</head>
<body>
    <h1>주문 삭제 확인</h1>
    <p>주문 ID: <%= order.getOrderId() %></p>
    <p>이름: <%= order.getName() %></p>
    <p>전화번호: <%= order.getPhone() %></p>
    <p>주소: <%= order.getAddress() %></p>
    <p>총 가격: <%= order.getTotalPrice() %></p>

    <form action="/erp/deleteOrder" method="post">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        <button type="submit">삭제</button>
    </form>
    <a href="/erp/orders">취소</a>
</body>
</html>
