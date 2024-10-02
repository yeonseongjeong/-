<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.test.vo.OrdersVO" %>
<%@ page import="kr.co.test.vo.UserVO" %>
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
    <script>
        function sortTable(column) {
            const table = document.getElementById("orderTable");
            const rows = Array.from(table.rows).slice(1);
            const isAscending = table.dataset.sortOrder === 'asc';

            rows.sort((a, b) => {
                const aText = a.cells[column].textContent.trim();
                const bText = b.cells[column].textContent.trim();

                if (column === 2) { // 주문 날짜 (인덱스 2)
                    return isAscending ? new Date(bText) - new Date(aText) : new Date(aText) - new Date(bText);
                } else if (column === 7) { // 발송 여부 (인덱스 7)
                    return isAscending ? aText.localeCompare(bText) : bText.localeCompare(aText);
                }

                return isAscending ? aText.localeCompare(bText) : bText.localeCompare(aText);
            });

            rows.forEach(row => table.appendChild(row));
            table.dataset.sortOrder = isAscending ? 'desc' : 'asc';
        }

        window.onload = function() {
            const table = document.getElementById("orderTable");
            const rows = Array.from(table.rows).slice(1);

            // 날짜 정렬
            rows.sort((a, b) => {
                const dateA = new Date(a.dataset.orderDate);
                const dateB = new Date(b.dataset.orderDate);
                return dateB - dateA;
            });

            // 정렬된 행을 다시 테이블에 추가
            rows.forEach(row => table.appendChild(row));
        };

        function filterByName() {
            const input = document.getElementById("nameSearch").value.toLowerCase();
            const table = document.getElementById("orderTable");
            const rows = Array.from(table.rows).slice(1);

            rows.forEach(row => {
                const nameCell = row.cells[5].textContent.toLowerCase(); // 이름이 있는 셀 (인덱스 5)
                if (nameCell.includes(input)) {
                    row.style.display = ""; // 포함되면 표시
                } else {
                    row.style.display = "none"; // 포함되지 않으면 숨김
                }
            });
        }
    </script>
</head>
<style>
  table {
      table-layout: fixed;
      width: 100%;
  }
  th, td {
      word-wrap: break-word;
  }
</style>
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
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="salesAnalysisDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    판매 분석
                </a>
                <div class="dropdown-menu" aria-labelledby="salesAnalysisDropdown">
                    <a class="dropdown-item" href="/erp/sales-analysis-category">카테고리별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-brand">브랜드별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-product">품목별</a>
                </div>
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
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>주문 내역</h1>

    <div class="mb-3">
        <input type="text" id="nameSearch" class="form-control" placeholder="이름으로 검색" onkeyup="filterByName()">
    </div>

    <table class="table table-striped" id="orderTable" data-sort-order="asc">
        <thead>
            <tr>
                <th>주문 ID</th>
                <th>사용자 이메일</th>
                <th onclick="sortTable(2)" style="cursor: pointer;">주문 날짜 &#x21C5;</th>
                <th>총 가격</th>
                <th style="width:300px;">주소</th>
                <th>이름</th>
                <th>전화번호</th>
                <th onclick="sortTable(7)" style="cursor: pointer;">발송 여부 &#x21C5;</th>
                <th style="width:110px;">작업</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<OrdersVO> orderList = (List<OrdersVO>) request.getAttribute("orderList");
                List<UserVO> userList = (List<UserVO>) request.getAttribute("userList");
                int totalSales = 0; // 발송된 상품의 총 가격

                if (orderList != null && userList != null) {
                    for (OrdersVO order : orderList) {
                        String userEmail = "정보 없음"; // 기본값 설정
                        for (UserVO user : userList) {
                            if (user.getUserId() == order.getUserId()) {
                                userEmail = user.getEmail();
                                break; // 이메일 찾으면 루프 종료
                            }
                        }
                        String deliveryStatus = order.getDelivery() == 1 ? "발송됨" : "발송 대기"; // 발송 여부 설정
                        if (order.getDelivery() == 1) {
                            totalSales += order.getTotalPrice(); // 발송된 상품의 가격 합산
                        }
            %>
            <tr data-order-date="<%= order.getOrderDate() %>">
                <td>
                    <a href="/erp/orderItemsErp?orderId=<%= order.getOrderId() %>" class="btn btn-info btn-sm"><%= order.getOrderId() %></a>
                </td>
                <td><%= userEmail %></td>
                <td><%= order.getOrderDate() %></td>
                <td><%= order.getTotalPrice() %></td>
                <td><%= order.getAddress() %></td>
                <td><%= order.getName() %></td>
                <td><%= order.getPhone() %></td>
                <td><%= deliveryStatus %></td> 
                <td>
                    <%
                        if (order.getDelivery() == 1) {
                    %>
                        <button class="btn btn-success btn-sm" disabled>발송 완료</button>
                    <%
                        } else {
                    %>
                        <form action="/erp/sendOrder" method="post" style="display:inline;" onsubmit="return confirm('발송하시겠습니까?');">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <button type="submit" class="btn btn-success btn-sm">발송</button>
                        </form>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9" class="text-center">주문 내역이 없습니다.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <h3>발송된 상품 전체 가격: <%= totalSales %> 원</h3>
</div>

<footer class="bg-light text-center py-3">
    <p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
</footer>

</body>
</html>