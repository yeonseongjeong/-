<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.test.vo.OrdersVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 내역 관리</title>
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
            <li class="nav-item active">
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
    <h1>주문 내역</h1>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>주문 ID</th>
                <th>사용자 ID</th>
                <th>주문 날짜</th>
                <th>총 가격</th>
                <th>주소</th>
                <th>이름</th>
                <th>전화번호</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // 주문 목록을 가져온다고 가정
                List<OrdersVO> orderList = (List<OrdersVO>) request.getAttribute("orderList");
                for (OrdersVO order : orderList) { 
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getUserId() %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getTotalPrice() %></td>
                <td><%= order.getAddress() %></td>
                <td><%= order.getName() %></td>
                <td><%= order.getPhone() %></td>
                <td>
		            <a href="/erp/editOrder?orderId=<%= order.getOrderId() %>" class="btn btn-warning btn-sm">수정</a>
		            <a href="/erp/deleteOrder?orderId=<%= order.getOrderId() %>" class="btn btn-danger btn-sm" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
		        </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <h3>전체 판매 가격: <%= request.getAttribute("totalSales") %> 원</h3> <!-- 전체 판매 가격 출력 -->
</div>

<footer class="bg-light text-center py-3">
    <p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
</footer>

</body>
</html>
