<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>테스트 쇼핑몰 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <style>
        .card-img-top {
            width: 300px;
            height: 200px !important;
            object-fit: cover;
        }
    </style>
</head>

<body>
    <!-- 추천 상품들을 출력할 영역 -->
    <div class="container">
        <div class="row justify-content-center" id="recommended-products">
            <!-- 여기에 자바스크립트로 추천된 상품들이 추가될 예정 -->
        </div>
    </div>

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

        // 상품 카드 HTML을 동적으로 생성하는 함수
        function createProductCard(productId) {
            // 여기에 실제 상품 정보와 이미지를 바인딩
            const productCard = document.createElement("div");
            productCard.className = "col-md-2";

            productCard.innerHTML =
                '<div class="card" onclick="location.href=\'/product/' + productId + '\';">' +
                    '<img src="resources/img/product_' + productId + '.jpg" class="card-img-top" alt="Product ' + productId + '">' +
                    '<div class="card-body">' +
                        '<h5 class="card-title">상품 ' + productId + '</h5>' +
                        '<h6 class="card-subtitle mb-2 text-muted">추천된 상품입니다.</h6>' +
                        '<p class="card-text">상품 ' + productId + '의 설명을 여기에 추가하세요.</p>' +
                        '<p class="pid" hidden>' + productId + '</p>' +
                    '</div>' +
                '</div>';
            
            return productCard;
        }
    </script>
</body>

</html>
