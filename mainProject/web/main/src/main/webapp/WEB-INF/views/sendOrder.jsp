<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 발송</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1>주문 발송</h1>
        <form action="/erp/sendOrder" method="post">
            <input type="hidden" name="orderId" value="${orderId}"/>
            <button type="submit" class="btn btn-success">주문 발송</button>
        </form>
    </div>
</body>
</html>
