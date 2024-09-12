<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>테스트 쇼핑몰 페이지</title>
    <link rel="stylesheet" href="https://s3.ap-northeast-2.amazonaws.com/materials.spartacodingclub.kr/easygpt/default.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
        <script>
    // JSTL을 사용하여 Flash 메시지를 JSP에서 처리
    <c:if test="${not empty message}">
        alert('${message}');
    </c:if>
</script>
    <style>
        /* Your existing CSS styles */
         .product-image {
        width: 300px;
        height: 300px;
        object-fit: cover; /* 이미지 비율 유지하면서 300x300으로 자름 */
    }
        .hero {
            padding: 20px;
            color: #fff;
        }
        .product {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border: 1px solid #ddd; /* 블록 외곽선 추가 */
        }
        .product img {
            max-width: 300px;
            border-radius: 8px;
            border: 1px solid #ddd; /* 이미지 외곽선 추가 */
        }
        .details {
            flex: 1;
            max-width: 60%;
        }
        .product-info, .quantity-controls, .stock-info {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd; /* 블록 구분선 추가 */
            border-radius: 8px;
            background: #f8f9fa; /* 블록 배경색 추가 */
        }
        .product-info h1 {
            margin-top: 0;
        }
        .product-info .price {
            color: #b12704;
            font-size: 1.5em;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-controls button {
            padding: 5px 10px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f8f9fa;
            cursor: pointer;
        }
        .quantity-controls button:hover {
            background-color: #e2e6ea;
        }
        .quantity-controls input {
            width: 60px;
            text-align: center;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
        }
        .stock-info p {
            font-size: 1.2em;
            color: #555;
        }
        .total-price {
            font-weight: bold;
            color: #b12704;
            font-size: 1.5em;
        }
        .description {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd; /* 설명 블록 외곽선 추가 */
            margin-top: 20px;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .buy-button, .cart-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1em;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            margin-right: 10px;
        }
        .buy-button {
            background-color: #28a745;
        }
        .buy-button:hover {
            background-color: #218838;
        }
        .cart-button {
            background-color: #007bff;
        }
        .cart-button:hover {
            background-color: #0056b3;
        }
        .related-products {
            margin-top: 40px;
        }
        .related-products h2 {
            margin-bottom: 20px;
        }
        .related-products .card {
            margin-bottom: 20px;
            border: 1px solid #ddd; /* 관련 상품 카드 외곽선 추가 */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>
    <!-- 헤더 시작 -->
	<div class="hero d-flex align-items-center justify-content-center" style="background-color: #333333; position: relative;">
    <div class="container text-center">
        <h1 class="display-4 text-light">Computer Peripherals Online Store</h1>
        <!-- <p class="lead text-light">test</p> -->
    </div>
    <!-- 마이페이지 링크 추가 -->
    <a href="/mypage" class="position-absolute" style="top: 20px; right: 20px; text-decoration: none;">
        <i class="bi bi-person-circle text-light" style="font-size: 2rem;"></i>
        <!-- <span class="text-light"></span> -->
    </a>
     <!-- 장바구니 링크 추가 -->
        <a href="/cart" class="icon-link" style="right: 80px;">
            <i class="bi bi-cart"></i>
        </a>
</div>


    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">컴퓨터쇼핑몰</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Products
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="#">Mouse</a></li>
                            <li><a class="dropdown-item" href="#">Keyboard</a></li>
                            <li><a class="dropdown-item" href="#">Monitor</a></li>
                            <li><a class="dropdown-item" href="#">Webcam</a></li>
                            <li><a class="dropdown-item" href="#">Speaker</a></li>
                            <li><a class="dropdown-item" href="#">HeadPhone</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/products">All products</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact</a></li>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
    <!-- 헤더 끝 -->

    <div class="container">
        <div class="product">
            <img src="${pageContext.request.contextPath}/resources/img/${product.imageUrl}" class="product-image" alt="Product Image">
            <div class="details">
                <div class="product-info">
                    <h1>${product.productName}</h1>
                    <p class="price">가격: <span id="price">${product.price}</span>원</p>
                </div>
                <div class="quantity-controls">
                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(-1)">-</button>
                    <input type="number" id="quantity" value="1" min="1" />
                    <button type="button" class="btn btn-outline-secondary" onclick="changeQuantity(1)">+</button>
                </div>
                <div class="stock-info">
                    <p>재고: ${product.stockQuantity}</p>
                    <p class="total-price">총 가격: <span id="totalPrice">${product.price}</span>원</p>
                </div>
            </div>
        </div>

        <!-- 설명 추가 -->
        <div class="description">
            <h2>상품 설명</h2>
            <p>${description.description}자세한 설명은 여기서</p>
        </div>

        <!-- 버튼 그룹 추가 -->
        <div class="button-group">
            <a href="/buy/${product.productId}" class="buy-button">구매하기</a>
            <form action="/addToCart" method="post" style="display: inline;">
                <input type="hidden" name="productId" value="${product.productId}">
                <input type="hidden" name="quantity" id="hiddenQuantity" value="1">
                <!-- 기본 수량 1 -->
                <input type="hidden" name="price" value="${product.price}">
                <!-- 가격 정보 수정 -->
                <button type="submit" class="cart-button">장바구니로 보내기</button>
            </form>
        </div>

        <!-- 비슷한 카테고리 상품들 추가 -->
        <div class="related-products">
            <h2>비슷한 카테고리의 상품들</h2>
            <div class="row">
                <!-- 반복되는 카드 예제 -->
                <div class="col-md-4">
                    <div class="card">
                        <img src="https://via.placeholder.com/200" class="card-img-top" alt="Related Product 1">
                        <div class="card-body">
                            <h5 class="card-title">상품명 1</h5>
                            <p class="card-text">가격: 10,000원</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <img src="https://via.placeholder.com/200" class="card-img-top" alt="Related Product 2">
                        <div class="card-body">
                            <h5 class="card-title">상품명 2</h5>
                            <p class="card-text">가격: 15,000원</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <img src="https://via.placeholder.com/200" class="card-img-top" alt="Related Product 3">
                        <div class="card-body">
                            <h5 class="card-title">상품명 3</h5>
                            <p class="card-text">가격: 20,000원</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var stockQuantity = ${product.stockQuantity}; 
        var pricePerUnit = ${product.price}; 

        function changeQuantity(change) {
            var quantityInput = document.getElementById('quantity');
            var hiddenQuantityInput = document.getElementById('hiddenQuantity');
            var currentQuantity = parseInt(quantityInput.value);
            var newQuantity = currentQuantity + change;

            // Ensure newQuantity is within bounds
            if (newQuantity < 1) newQuantity = 1;
            if (newQuantity > stockQuantity) newQuantity = stockQuantity;

            quantityInput.value = newQuantity;
            hiddenQuantityInput.value = newQuantity; // Sync hidden input

            // Update the total price based on the new quantity
            updatePrice(newQuantity);
        }

        function updatePrice(quantity) {
            var totalPrice = pricePerUnit * quantity;
            document.getElementById('totalPrice').textContent = totalPrice.toLocaleString();
        }
        
        // Initialize total price on page load
        updatePrice(parseInt(document.getElementById('quantity').value));
    </script>
</body>
</html>
