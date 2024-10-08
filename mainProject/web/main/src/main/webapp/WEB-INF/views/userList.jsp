<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.test.vo.UserVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유저 관리</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function filterByName() {
            const input = document.getElementById("nameSearch").value.toLowerCase();
            const table = document.getElementById("userTable");
            const rows = Array.from(table.rows).slice(1);

            rows.forEach(row => {
                const nameCell = row.cells[1].textContent.toLowerCase(); // 이름이 있는 셀 (인덱스 1)
                if (nameCell.includes(input)) {
                    row.style.display = ""; // 포함되면 표시
                } else {
                    row.style.display = "none"; // 포함되지 않으면 숨김
                }
            });
        }

        function sortByGrade() {
            const table = document.getElementById("userTable");
            const rows = Array.from(table.rows).slice(1);
            const isAscending = table.dataset.sortOrder === 'asc';

            rows.sort((a, b) => {
                const gradeA = a.cells[4].textContent.trim(); // 회원등급이 있는 셀 (인덱스 4)
                const gradeB = b.cells[4].textContent.trim();

                return isAscending ? gradeA.localeCompare(gradeB) : gradeB.localeCompare(gradeA);
            });

            rows.forEach(row => table.appendChild(row));
            table.dataset.sortOrder = isAscending ? 'desc' : 'asc';
        }
    </script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">ERP 시스템</a>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
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
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="salesAnalysisDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    판매 분석
                </a>
                <div class="dropdown-menu" aria-labelledby="salesAnalysisDropdown">
                    <a class="dropdown-item" href="/erp/sales-analysis-all">전체</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-category">카테고리별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-brand">브랜드별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-product">품목별</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/ocr">OCR 관리</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="#">EVENT 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/report">보고서</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>유저 목록</h1>
    <a href="/erp/signup" class="btn btn-primary mb-3">회원가입</a>

    <div class="mb-3">
        <input type="text" id="nameSearch" class="form-control" placeholder="이름으로 검색" onkeyup="filterByName()">
    </div>

    <table class="table table-striped" id="userTable" data-sort-order="asc">
        <thead>
            <tr>
                <th>사용자 ID</th>
                <th>사용자 이름</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th onclick="sortByGrade()" style="cursor: pointer;">회원등급 &#x21C5;</th>
                <th>행동</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<UserVO> userList = (List<UserVO>) request.getAttribute("userList");
                for (UserVO user : userList) { 
            %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhoneNumber() %></td>
                <td><%= user.getGrade() %></td>
                <td>
                    <a href="/erp/userEdit?userId=<%= user.getUserId() %>" class="btn btn-warning btn-sm">수정</a>
                    <a href="/erp/userDelete?userId=<%= user.getUserId() %>" class="btn btn-danger btn-sm">삭제</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<footer class="bg-light text-center py-3">
    <p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
</footer>

</body>
</html>
