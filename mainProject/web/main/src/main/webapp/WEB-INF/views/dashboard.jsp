<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP 시스템</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">ERP 시스템</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="/erp/dashboard">대시보드</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/productList">재고 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/userList">고객 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/orders">주문 내역 관리</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="salesAnalysisDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    판매 분석
                </a>
                <div class="dropdown-menu" aria-labelledby="salesAnalysisDropdown">
                    <a class="dropdown-item" href="/erp/sales-analysis-all">전체</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-category">카테고리별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-brand">브랜드별</a>
                    <a class="dropdown-item" href="/erp/sales-analysis-product">품목별</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">OCR 관리</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="#">EVENT 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">보고서</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>환영합니다!</h1>
    <p>이곳은 ERP 시스템 대시보드입니다.</p>

    <div class="row">
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">재고 현황</h5>
                    <p class="card-text">현재 재고 상황을 확인하세요.</p>
                    <a href="/erp/productList" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">고객 정보</h5>
                    <p class="card-text">고객 관리 기능을 사용하세요.</p>
                    <a href="/erp/userList" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">주문 내역 관리</h5>
                    <p class="card-text">주문 내역을 확인하고 관리하세요.</p>
                    <a href="/erp/orders" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">OCR 관리</h5>
                    <p class="card-text">OCR 내역을 확인하고 관리하세요.</p>
                    <a href="#" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">EVENT 관리</h5>
                    <p class="card-text">고객 EVENT 기능을 사용하세요.</p>
                    <a href="#" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">판매 분석</h5>
                    <p class="card-text">보고서를 생성하고 다운로드하세요.</p>
                    <a href="/erp/sales-analysis-category" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">보고서 생성</h5>
                    <p class="card-text">보고서를 생성하고 다운로드하세요.</p>
                    <a href="#" class="btn btn-primary">자세히 보기</a>
                </div>
            </div>
        </div>
        
    </div>
</div>

<footer class="bg-light text-center py-3">
    <p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
</footer>

</body>
</html>
