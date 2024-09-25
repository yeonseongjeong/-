<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="kr.co.test.vo.OrdersVO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    OrdersVO order = (OrdersVO) request.getAttribute("order");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 수정</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">ERP 시스템</a>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/erp/dashboard">대시보드</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/productList">재고 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/userList">고객 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/orders">주문 내역 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">OCR 관리</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="#">EVENT 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">보고서</a>
            </li>
            <!-- 다른 메뉴 항목 추가 가능 -->
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>주문 수정</h1>
    <form action="/erp/updateOrder" method="post">
        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
        
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= order.getName() %>" required>
        </div>
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="text" class="form-control" id="phone" name="phone" value="<%= order.getPhone() %>" required>
        </div>
        <div class="form-group">
            <label for="address">주소</label>
            <input type="text" class="form-control" id="address" name="address" value="<%= order.getAddress() %>" required>
        </div>
        <div class="form-group">
            <label for="totalPrice">총 가격</label>
            <input type="text" class="form-control" id="totalPrice" name="totalPrice" value="<%= order.getTotalPrice() %>" required>
        </div>
        <button type="submit" class="btn btn-primary">수정하기</button>
        <a href="/erp/orders" class="btn btn-secondary">취소</a>
    </form>
</div>

</body>
</html>
