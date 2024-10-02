<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page session="true"%>
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
<style>
.card-img-top {
	width: 300px;
	height: 200px !important;
	object-fit: cover; /* 이미지가 고정된 크기에 맞도록 자름 */
}

.carousel-item {
	padding: 20px;
}

.carousel-inner {
	display: flex;
	align-items: center;
}

.carousel-item img {
	max-width: 100%;
	height: auto;
}

.icon-link {
	position: absolute;
	top: 20px;
	right: 20px;
	text-decoration: none;
	color: white;
}

.icon-link i {
	font-size: 2rem;
}
</style>
</head>

<body>
	<!-- 헤더 시작 -->
	<div class="hero d-flex align-items-center justify-content-center"
		style="background-color: #333333; position: relative;">
		<div class="container text-center">
			<h1 class="display-4 text-light">Computer Peripherals Online
				Store</h1>
		</div>
		<!-- 마이페이지 링크 추가 -->
		<a href="/mypage" class="position-absolute"
			style="top: 20px; right: 20px; text-decoration: none;"> <i
			class="bi bi-person-circle text-light" style="font-size: 2rem;"></i>
		</a>
		<!-- 장바구니 링크 추가 -->
		<a href="/cart" class="icon-link" style="right: 80px;"> <i
			class="bi bi-cart"></i>
		</a>
	</div>


	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">컴퓨터쇼핑몰</a>
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
							<li><a class="dropdown-item" href="/products/category/1">Mouse</a></li>
							<li><a class="dropdown-item" href="/products/category/2">Keyboard</a></li>
							<li><a class="dropdown-item" href="/products/category/3">Monitor</a></li>
							<li><a class="dropdown-item" href="/products/category/4">Webcam</a></li>
							<li><a class="dropdown-item" href="/products/category/5">Speaker</a></li>
							<li><a class="dropdown-item" href="/products/category/6">HeadPhone</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="/products">All
									products</a></li>
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
	<!-- 헤더 끝 -->

	<!-- Carousel 슬라이드 시작 -->
	<div id="productCarousel" class="carousel slide">
		<div class="carousel-inner">
			<!-- 첫 번째 슬라이드 -->
			<c:forEach var="i" begin="0" end="${fn:length(products) - 1}" step="5">
				<div class="carousel-item ${i == 0 ? 'active' : ''}">
					<div class="container">
						<div class="row justify-content-center">
							<c:forEach var="product" begin="${i}" end="${i + 4}" items="${products}">
								<div class="col-md-2">
									<div class="card" onclick="location.href='/product/${product.productId}';">
										<img src="resources/img/${product.imageUrl}" class="card-img-top" alt="${product.productName}">
										<div class="card-body">
											<h5 class="card-title">${product.productName}</h5>
											<p class="card-text">₩${product.price}</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- Carousel 제어 버튼 -->
		<button class="carousel-control-prev" type="button"
			data-bs-target="#productCarousel" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#productCarousel" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- Carousel 슬라이드 끝 -->
	<script>
        // 페이지 로드 시 추천 상품을 불러오기
        document.addEventListener('DOMContentLoaded', function() {
            // user_id는 세션에서 가져올 수 있습니다.
            const userId = 7; // 예시: 실제 로그인한 사용자 ID 사용

            // 추천 API 호출
            fetch("/recommend?user_id=" + userId)
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    const productContainer = document.getElementById("recommended-products");

                    // 추천된 product_id 배열을 순회하며 동적으로 상품 카드 생성
                    data.forEach(function(productId) {
                        const productCard = createProductCard(productId);
                        productContainer.appendChild(productCard);
                    });
                })
                .catch(function(error) {
                    console.error("Error fetching recommended products:", error);
                });
        });
        </script>
</body>

</html>
