<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.test.vo.ProductVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 목록 관리</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
            <li class="nav-item active">
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
            <!-- 다른 메뉴 항목 추가 가능 -->
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>상품 목록</h1>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>상품 ID</th>
                <th>상품 이름</th>
                <th>카테고리 ID</th>
                <th>가격</th>
                <th>재고 수량</th>
                <th>수정</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // 상품 목록을 가져온다고 가정
                List<ProductVO> productList = (List<ProductVO>) request.getAttribute("products");
                for (ProductVO product : productList) { 
            %>
            <tr>
                <td><%= product.getProductId() %></td>
                <td><%= product.getProductName() %></td>
                <td><%= product.getCategoryId() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getStockQuantity() != null ? product.getStockQuantity() : "품절" %></td>
                <td>
                    <a href="/erp/editProduct/<%= product.getProductId() %>" class="btn btn-warning">수정</a>
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
