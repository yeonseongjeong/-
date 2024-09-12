<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
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

    <!-- Carousel 슬라이드 시작 -->
    <div id="productCarousel" class="carousel slide">
        <div class="carousel-inner">
            <!-- 첫 번째 슬라이드 -->
            <div class="carousel-item active">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-2">
                            <div class="card" onclick="location.href='/product/1';">
                                <img src="resources/img/로지텍G102.jpg" class="card-img-top" alt="Product 1">
                                <div class="card-body">
                                    <h5 class="card-title">테스트1</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진1</h6>
                                    <p class="card-text">테스트1 설명.</p>
                                    <p class ="pid" hidden>1</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="resources/img/2.jpg" class="card-img-top" alt="Product 2">
                                <div class="card-body">
                                    <h5 class="card-title">테스트2</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진2</h6>
                                    <p class="card-text">테스트2 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="resources/img/DELL UltraSharp U2723QE.jpg" class="card-img-top" alt="Product 3">
                                <div class="card-body">
                                    <h5 class="card-title">테스트3</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진3</h6>
                                    <p class="card-text">테스트3 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 4">
                                <div class="card-body">
                                    <h5 class="card-title">테스트4</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진4</h6>
                                    <p class="card-text">테스트4 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 5">
                                <div class="card-body">
                                    <h5 class="card-title">테스트5</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진5</h6>
                                    <p class="card-text">테스트5 설명.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 두 번째 슬라이드 -->
            <div class="carousel-item">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 6">
                                <div class="card-body">
                                    <h5 class="card-title">테스트6</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진6</h6>
                                    <p class="card-text">테스트6 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 7">
                                <div class="card-body">
                                    <h5 class="card-title">테스트7</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진7</h6>
                                    <p class="card-text">테스트7 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 8">
                                <div class="card-body">
                                    <h5 class="card-title">테스트8</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진8</h6>
                                    <p class="card-text">테스트8 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 9">
                                <div class="card-body">
                                    <h5 class="card-title">테스트9</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진9</h6>
                                    <p class="card-text">테스트9 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 10">
                                <div class="card-body">
                                    <h5 class="card-title">테스트10</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진10</h6>
                                    <p class="card-text">테스트10 설명.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 세 번째 슬라이드 -->
            <div class="carousel-item">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 11">
                                <div class="card-body">
                                    <h5 class="card-title">테스트11</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진11</h6>
                                    <p class="card-text">테스트11 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 12">
                                <div class="card-body">
                                    <h5 class="card-title">테스트12</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진12</h6>
                                    <p class="card-text">테스트12 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 13">
                                <div class="card-body">
                                    <h5 class="card-title">테스트13</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진13</h6>
                                    <p class="card-text">테스트13 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 14">
                                <div class="card-body">
                                    <h5 class="card-title">테스트14</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진14</h6>
                                    <p class="card-text">테스트14 설명.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="card">
                                <img src="https://via.placeholder.com/300" class="card-img-top" alt="Product 15">
                                <div class="card-body">
                                    <h5 class="card-title">테스트15</h5>
                                    <h6 class="card-subtitle mb-2 text-muted">테스트사진15</h6>
                                    <p class="card-text">테스트15 설명.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Carousel 제어 버튼 -->
        <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    <!-- Carousel 슬라이드 끝 -->

</body>

</html>
