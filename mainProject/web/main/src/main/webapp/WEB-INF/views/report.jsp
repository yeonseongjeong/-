<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매 보고서 생성</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                <a class="nav-link" href="/erp/ocr">OCR 관리</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="#">EVENT 관리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/erp/report">보고서</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <h1>판매 보고서 생성</h1>
    
    <form id="reportForm">
        <div class="form-group">
            <label for="startDate">시작 날짜:</label>
            <input type="date" class="form-control" id="startDate" required>
        </div>
        <div class="form-group">
            <label for="endDate">종료 날짜:</label>
            <input type="date" class="form-control" id="endDate" required>
        </div>
        <div class="form-group">
            <label for="periodType">분석 기준:</label>
            <select class="form-control" id="periodType" required>
                <option value="DAILY">일간</option>
                <option value="WEEKLY">주간</option>
                <option value="MONTHLY">월간</option>
            </select>
        </div>
        <button type="button" class="btn btn-primary" id="generateReportButton">보고서 생성</button>
    </form>

    <div id="message" class="alert alert-success mt-3" style="display:none;"></div>
</div>

<footer class="bg-light text-center py-3">
    <p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
</footer>

<script>
    $('#generateReportButton').click(function() {
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        const periodType = $('#periodType').val();

        // 유효성 검사
        if (!startDate || !endDate || !periodType) {
            alert('모든 필드를 채워주세요.');
            return;
        }

        $.ajax({
            url: '/erp/generateReport',
            type: 'POST',
            data: {
                startDate: startDate,
                endDate: endDate,
                periodType: periodType
            },
            success: function(response) {
                $('#message').text('보고서가 성공적으로 생성되었습니다.').show();
            },
            error: function(error) {
                const errorMessage = error.responseJSON?.error || '보고서 생성 중 오류가 발생했습니다.';
                console.error('보고서 생성 중 오류 발생:', error);
                alert(errorMessage);
            }
        });
    });
</script>

</body>
</html>
