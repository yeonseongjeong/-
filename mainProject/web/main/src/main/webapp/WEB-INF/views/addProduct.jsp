<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            background-color: #f8f9fa;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            margin-bottom: 30px;
            text-align: center;
            font-weight: bold;
        }

        .btn-submit {
            background-color: #28a745;
            color: white;
            width: 100%;
        }

        .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>

<body>
    <div class="container form-container">
        <h2>상품 등록</h2>
        <form action="/addProduct" method="POST" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="productName" class="form-label">상품명</label>
                <input type="text" class="form-control" id="productName" name="productName" required>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">가격</label>
                <input type="number" class="form-control" id="price" name="price" required>
            </div>
            <div class="mb-3">
                <label for="stockQuantity" class="form-label">재고 수량</label>
                <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
            </div>
            <div class="mb-3">
                <label for="category" class="form-label">카테고리</label>
                <select class="form-select" id="category" name="categoryId" required>
                    <option value="1">Mouse</option>
                    <option value="2">Keyboard</option>
                    <option value="3">Monitor</option>
                    <option value="4">Webcam</option>
                    <option value="5">Speaker</option>
                    <option value="6">Headphone</option>
                </select>
            </div>
			<div class="mb-3">
				<label for="productImage" class="form-label">이미지 업로드</label> <input
					type="file" class="form-control" id="productImage"
					name="productImage" required>
			</div>
			<button type="submit" class="btn btn-submit">상품 등록</button>
        </form>
    </div>
</body>
</html>
