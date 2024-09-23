<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 수정</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
    <h1>상품 수정</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/updateProduct" method="post">
        <input type="hidden" name="productId" value="${product.productId}" />
        
        <div>
            <label for="productName">상품명:</label>
            <input type="text" id="productName" name="productName" value="${product.productName}" required />
        </div>
        
        <div>
            <label for="categoryId">카테고리 ID:</label>
            <input type="number" id="categoryId" name="categoryId" value="${product.categoryId}" required />
        </div>

        <div>
            <label for="price">가격:</label>
            <input type="number" id="price" name="price" value="${product.price}" required />
        </div>

        <div>
            <label for="stockQuantity">재고 수량:</label>
            <input type="number" id="stockQuantity" name="stockQuantity" value="${product.stockQuantity}" required />
        </div>

        <div>
            <button type="submit">수정하기</button>
            <a href="${pageContext.request.contextPath}/erp/productList">목록으로 돌아가기</a>
        </div>
    </form>
</body>
</html>
