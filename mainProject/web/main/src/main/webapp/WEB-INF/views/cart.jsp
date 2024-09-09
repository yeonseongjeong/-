<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>테스트 쇼핑몰 페이지</title>
<link rel="stylesheet"
	href="https://s3.ap-northeast-2.amazonaws.com/materials.spartacodingclub.kr/easygpt/default.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<script>
        window.onload = function() {
            if (${loginRequired}) {
                alert("로그인이 필요합니다.");
                window.location.href = "/login"; // 로그인 페이지로 리다이렉트
            }
        }
    </script>
<style>
/* 스타일 추가 가능 */
</style>
</head>
<body>
	<div class="hero d-flex align-items-center justify-content-center"
		style="background-color: #333333; position: relative;">
		<div class="container text-center">
			<h1 class="display-4 text-light">테스트</h1>
			<p class="lead text-light">test</p>
		</div>
		<!-- 마이페이지 링크 추가 -->
		<a href="/mypage" class="position-absolute"
			style="top: 20px; right: 20px; text-decoration: none;"> <i
			class="bi bi-person-circle text-light" style="font-size: 2rem;"></i>
		</a>
		<!-- 장바구니 링크 추가 -->
		<a href="/cart" class="icon-link"
			style="position: absolute; top: 20px; right: 80px; text-decoration: none; color: white;">
			<i class="bi bi-cart" style="font-size: 2rem;"></i>
		</a>
	</div>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">쇼핑몰</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Products </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Category 1</a></li>
							<li><a class="dropdown-item" href="#">Category 2</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Special Offers</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="#">About Us</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
				</ul>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>

	<!-- 장바구니 목록 -->
	<div class="container mt-5">
		<h2 class="text-center mb-4">장바구니</h2>

		<!-- 장바구니 테이블 -->
		<div class="row justify-content-center">
			<div class="col-md-8">
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">상품</th>
							<th scope="col">가격</th>
							<th scope="col">수량</th>
							<th scope="col">합계</th>
							<th scope="col">삭제</th>
						</tr>
					</thead>
					<tbody id="cartItems">
						<c:forEach var="item" items="${cartItems}">
							<tr>
								<td>
									<div class="d-flex align-items-center">
										<img
											src="path/to/image/${item.productName}.jpg"
											class="img-thumbnail" alt="상품 이미지"> <span class="ms-3">${item.productName}</span>
									</div>
								</td>

								<td>₩<span class="price" data-price="${item.price}"><fmt:formatNumber
											value="${item.price}" /></span></td>
								<td><input type="number" class="form-control quantity"
									value="${item.quantity}" min="1" max="10" style="width: 80px;"
									data-price="${item.price}" data-id="${item.productId}" data-name="${item.productName}">
								</td>
								<td><span class="total"><fmt:formatNumber
											value="${item.price * item.quantity}" /></span></td>
								<td>
									<form action="deleteCartItem" method="POST">
										<input type="hidden" name="productName"
											value="${item.productName}">
										<button class="btn btn-danger btn-sm" type="submit">
											<i class="bi bi-trash"></i> 삭제
										</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 장바구니 합계 및 결제 버튼 -->
		<div class="row justify-content-center mt-4">
			<div class="col-md-8">
				<div class="card p-3">
					<h4 class="text-center mb-4">장바구니 요약</h4>
					<div class="d-flex justify-content-between">
						<span>상품 합계</span> <span id="totalPrice">₩<fmt:formatNumber
								value="${totalPrice}" /></span>
					</div>
					<div class="d-flex justify-content-between mt-2">
						<span>배송비</span> <span>₩3,000</span>
					</div>
					<hr>
					<div class="d-flex justify-content-between">
						<strong>총 합계</strong> <strong id="grandTotal">₩<fmt:formatNumber
								value="${totalPrice + 3000}" /></strong>
					</div>
					<div class="text-center mt-4">
						<button class="btn btn-success w-100" id="checkoutButton">결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function () {
    const quantityInputs = document.querySelectorAll('.quantity');
    const totalPriceElement = document.getElementById('totalPrice');
    const grandTotalElement = document.getElementById('grandTotal');
    const checkoutButton = document.getElementById('checkoutButton');
    const shippingCost = 3000;

    function updateTotals() {
        let totalPrice = 0;

        quantityInputs.forEach(input => {
            const quantity = parseInt(input.value);
            const price = parseInt(input.dataset.price);
            const itemTotal = quantity * price;

            // Update total for this item
            input.closest('tr').querySelector('.total').innerText = itemTotal.toLocaleString();

            // Add to total price
            totalPrice += itemTotal;
        });

        // Update total price and grand total
        totalPriceElement.innerText = '₩' + totalPrice.toLocaleString();
        grandTotalElement.innerText = '₩' + (totalPrice + shippingCost).toLocaleString();
    }

    // Add event listeners to quantity inputs
    quantityInputs.forEach(input => {
        input.addEventListener('input', updateTotals);
    });

    // Initialize totals on page load
    updateTotals();

    // Handle checkout button click
    checkoutButton.addEventListener('click', function () {
        const cartItems = [];
        quantityInputs.forEach(input => {
            const productName = input.dataset.name;
            const quantity = input.value;
            const price = input.dataset.price;

            cartItems.push({ productName, quantity, price });
        });

        if (cartItems.length > 0) {
            // Redirect to checkout page with cart items
            window.location.href = '/order?cartItems=' + encodeURIComponent(JSON.stringify(cartItems));
        } else {
            alert("장바구니가 비어 있습니다.");
        }
    });
});
</script>

</body>
</html>