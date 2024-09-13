<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <style>
        .confirmation-box {
            max-width: 500px;
            margin: 0 auto;
            margin-top: 100px;
            padding: 40px;
            background-color: #f8f9fa;
            border: 2px solid #dee2e6;
            border-radius: 15px;
            text-align: center;
        }
        .confirmation-box i {
            font-size: 100px;
            color: #28a745;
        }
        .confirmation-box h1 {
            font-size: 2.5rem;
            margin-top: 20px;
            color: #333;
        }
        .confirmation-box p {
            font-size: 1.2rem;
            color: #6c757d;
            margin-top: 10px;
            margin-bottom: 30px;
        }
        .btn-custom {
            width: 100%;
            padding: 10px;
            font-size: 1.2rem;
            margin-bottom: 10px;
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
    <div class="confirmation-box">
        <!-- 커다란 체크 표시 -->
        <i class="bi bi-check-circle-fill"></i>

        <!-- 주문 완료 메시지 -->
        <h1>주문 완료</h1>
        <p>주문이 성공적으로 완료되었습니다!</p>

        <!-- 버튼들 -->
        <a href="/" class="btn btn-success btn-custom">홈으로 가기</a>
        <a href="/mypage" class="btn btn-outline-primary btn-custom">마이페이지로 가기</a>
    </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 세션에서 orderStatus 가져오기
    var orderStatus = '<%= session.getAttribute("orderStatus") %>';
    
    if (orderStatus !== 'success') {
        alert('비정상적인 접근입니다.');
        window.location.href = '/'; // 홈 페이지로 리디렉션
    }
});
    </script>
</body>
</html>

