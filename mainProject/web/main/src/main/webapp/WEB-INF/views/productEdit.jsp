<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 수정</title>
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
                <a class="nav-link" href="#">보고서</a>
            </li>
            <!-- 다른 메뉴 항목 추가 가능 -->
        </ul>
    </div>
</nav>


<div class="container mt-4">
    <h1>제품 수정</h1>

    <form action="/erp/updateProduct" method="post">
        <input type="hidden" name="productId" value="${product.productId}">
        
        <div class="form-group">
            <label for="productName">제품명</label>
            <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
        </div>
        <div class="form-group">
            <label for="categoryId">카테고리 ID</label>
            <input type="number" class="form-control" id="categoryId" name="categoryId" value="${product.categoryId}" required>
        </div>
        <div class="form-group">
            <label for="price">가격</label>
            <input type="number" class="form-control" id="price" name="price" value="${product.price}" required>
        </div>
        <div class="form-group">
            <label for="stockQuantity">재고 수량</label>
            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="${product.stockQuantity}" required>
        </div>
        <button type="submit" class="btn btn-primary">수정하기</button>
    </form>
</div>
</body>
</html>