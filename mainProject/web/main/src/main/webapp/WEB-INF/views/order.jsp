<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>주문 페이지</title>
    <link rel="stylesheet" href="https://s3.ap-northeast-2.amazonaws.com/materials.spartacodingclub.kr/easygpt/default.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <style>
        .order-summary {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .order-summary h2 {
            margin-bottom: 20px;
        }
        .order-summary .product-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .order-summary .product-item:last-child {
            border-bottom: none;
        }
        .order-summary .product-item img {
            max-width: 80px;
            border-radius: 5px;
            margin-right: 10px;
        }
        .order-summary .product-item .product-info {
            display: flex;
            align-items: center;
        }
        .order-summary .product-item .product-info .product-name {
            font-weight: bold;
        }
        .order-summary .product-item .product-info .product-quantity {
            color: #555;
        }
        .order-summary .product-item .product-info .product-price {
            color: #b12704;
        }
        .order-summary .total {
            font-weight: bold;
            font-size: 1.2em;
        }
        .form-container {
            margin-top: 20px;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .form-container .form-group {
            margin-bottom: 15px;
        }
        .form-container .btn-submit {
            background-color: #28a745;
            color: #fff;
        }
        .form-container .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="hero d-flex align-items-center justify-content-center" style="background-color: #333333; position: relative;">
        <div class="container text-center">
            <h1 class="display-4 text-light">주문 페이지</h1>
        </div>
        <a href="/mypage" class="position-absolute" style="top: 20px; right: 20px; text-decoration: none;">
            <i class="bi bi-person-circle text-light" style="font-size: 2rem;"></i>
        </a>
        <a href="/cart" class="icon-link" style="position: absolute; top: 20px; right: 80px; text-decoration: none; color: white;">
            <i class="bi bi-cart" style="font-size: 2rem;"></i>
        </a>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">쇼핑몰</a>
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
                            <li><a class="dropdown-item" href="#">Category 1</a></li>
                            <li><a class="dropdown-item" href="#">Category 2</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Special Offers</a></li>
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

    <div class="container mt-5">
        <h2 class="text-center mb-4">주문 확인</h2>

        <!-- 주문 항목 테이블 -->
        <div class="row justify-content-center">
            <div class="col-md-8">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">상품</th>
                            <th scope="col">가격</th>
                            <th scope="col">수량</th>
                            <th scope="col">합계</th>
                        </tr>
                    </thead>
                    <tbody id="orderItems">
                        <!-- 주문 항목이 JavaScript로 삽입됩니다. -->
                    </tbody>
                </table>
            </div>
        </div>
        <!-- 주문 요약 -->
        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="card p-3">
                    <h4 class="text-center mb-4">주문 요약</h4>
                    <div class="d-flex justify-content-between">
                        <span>상품 합계</span> 
                        <span id="orderTotal">₩0</span>
                    </div>
                    <div class="d-flex justify-content-between mt-2">
                        <span>배송비</span> <span>₩3,000</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <strong>총 합계</strong> <strong id="orderGrandTotal">₩0</strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- 배송정보 -->
        <div class="container mt-5 form-container">
            <h2 class="text-center mb-4">배송 정보</h2>
            <form id="orderForm" action="/placeOrder" method="POST">
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="fullName">이름</label> 
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="이름을 입력하세요" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="phone">전화번호</label> 
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>
                    </div>
                </div>
                <div class="form-group mt-3">
                    <label for="address">주소</label> 
                    <input type="text" class="form-control" id="address" name="address" placeholder="주소를 입력하세요" required>
                </div>
                <div class="form-group mt-3">
                    <label for="email">이메일</label> 
                    <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required>
                </div>
                <input type="hidden" id="totalPriceInput" name="totalPrice">
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success btn-submit">주문하기</button>
                </div>
            </form>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const orderItemsElement = document.getElementById('orderItems');
        const orderTotalElement = document.getElementById('orderTotal');
        const orderGrandTotalElement = document.getElementById('orderGrandTotal');
        const totalPriceInput = document.getElementById('totalPriceInput');
        const shippingCost = 3000;

        // Get URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const cartItemsParam = urlParams.get('cartItems');

        // Debug: log URL parameters
        console.log('URL Parameters:', cartItemsParam);

        // Ensure cartItemsParam is valid
        if (!cartItemsParam) {
            console.error('No cartItems parameter found');
            return;
        }

        // Parse cartItems parameter
        let cartItems;
        try {
            cartItems = JSON.parse(decodeURIComponent(cartItemsParam));
        } catch (e) {
            console.error('Error parsing cartItems:', e);
            return;
        }

        // Debug: log cart items
        console.log('Cart Items:', cartItems);

        // Check if cartItems is an array
        if (!Array.isArray(cartItems)) {
            console.error('cartItems is not an array:', cartItems);
            return;
        }

        let totalPrice = 0;

        cartItems.forEach(item => {
            console.log('Price:', item.price, 'Quantity:', item.quantity);
            if (isNaN(item.price) || isNaN(item.quantity)) {
                console.error('Invalid price or quantity:', item);
            }
        });

        cartItems.forEach(item => {
            const price = Number(item.price);
            const quantity = Number(item.quantity);

            if (isNaN(price) || isNaN(quantity)) {
                console.error('Invalid item data:', item);
                return;
            }

            const itemTotal = quantity * price;
            totalPrice += itemTotal;

            const row = document.createElement('tr');
            row.innerHTML = 
                '<td>' +
                    '<div class="d-flex align-items-center">' +
                        '<img src="/images/products/' + item.productName + '.jpg" class="img-thumbnail" alt="상품 이미지">' +
                        '<span class="ms-3">' + item.productName + '</span>' +
                    '</div>' +
                '</td>' +
                '<td>₩' + price.toLocaleString() + '</td>' +
                '<td>' + quantity + '</td>' +
                '<td>₩' + itemTotal.toLocaleString() + '</td>';

            orderItemsElement.appendChild(row);
        });

        // Update totals
        orderTotalElement.innerText = '₩' + totalPrice.toLocaleString();
        orderGrandTotalElement.innerText = '₩' + (totalPrice + shippingCost).toLocaleString();
        totalPriceInput.value = totalPrice + shippingCost;

        // Handle form submission
        document.getElementById('orderForm').addEventListener('submit', function (event) {
            event.preventDefault();

            // Get shipping information
            const formData = new FormData(event.target);
            const shippingInfo = {
                fullName: formData.get('fullName'),
                phone: formData.get('phone'),
                address: formData.get('address'),
                email: formData.get('email'),
                totalPrice: totalPriceInput.value
            };

            // Log shipping info for debugging
            console.log('Shipping Info:', shippingInfo);

            // Submit order
            fetch('/placeOrder', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(shippingInfo)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('주문이 완료되었습니다.');
                    window.location.href = '/orderConfirmation'; // 주문 확인 페이지로 리다이렉트
                } else {
                    alert('주문 처리 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('주문 처리 중 오류가 발생했습니다.');
            });
        });
    });
    </script>
</body>
</html>
