<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ERP 시스템</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
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
                <a class="nav-link" href="#">보고서</a>
            </li>
        </ul>
    </div>
</nav>

	<div class="container mt-4">
    
    <!-- 사용자 입력 영역 -->
    <div class="text-center mb-4">
        <label for="startDate">시작 날짜:</label>
        <input type="date" id="startDate" class="form-control" style="display:inline-block; width:auto;">
        
        <label for="endDate">종료 날짜:</label>
        <input type="date" id="endDate" class="form-control" style="display:inline-block; width:auto;">
        
        <label for="periodType">분석 기준:</label>
        <select id="periodType" class="form-select" style="display:inline-block; width:auto;">
            <option value="DAILY">일간</option>
            <option value="WEEKLY">주간</option>
            <option value="MONTHLY">월간</option>
        </select>
        
        <button id="loadData" class="btn btn-primary">조회</button>
    </div>

    <!-- 판매량 차트 및 테이블 -->
    <div class="row">
        <div class="col-md-6">
            <h3 class="text-center">전체 판매량</h3>
            <canvas id="salesChart" width="400" height="200"></canvas>
            <table class="table table-striped mt-4">
                <thead>
                    <tr><th>날짜</th><th>총 판매량</th></tr>
                </thead>
                <tbody id="salesTableBody"></tbody>
            </table>
        </div>
        
        <!-- 매출액 차트 및 테이블 -->
        <div class="col-md-6">
            <h3 class="text-center">전체 매출액</h3>
            <canvas id="revenueChart" width="400" height="200"></canvas>
            <table class="table table-striped mt-4">
                <thead>
                    <tr><th>날짜</th><th>총 매출액</th></tr>
                </thead>
                <tbody id="revenueTableBody"></tbody>
            </table>
        </div>
    </div>
</div>
<script>
let salesChart = null;
let revenueChart = null;
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
    const day = String(today.getDate()).padStart(2, '0');
    return year + '-' + month + '-' + day;

}

// 페이지 로드 시 날짜 필드를 오늘 날짜로 설정
$(document).ready(function () {
    const startDate = '2024-09-01';  // 시작 날짜를 2024-09-01로 설정
    const today = getTodayDate();  // 현재 날짜를 가져옴

    $('#startDate').val(startDate);  // 시작 날짜를 2024-09-01로 설정
    $('#endDate').val(today);  // 종료 날짜를 오늘 날짜로 설정

    // 페이지 로드 시 기본 데이터를 2024-09-01부터 오늘 날짜까지로 로드
    loadSalesAndRevenueData(startDate, today, 'DAILY');  // 기본값으로 일간 데이터를 로드

    $('#loadData').click(function () {
        const selectedStartDate = $('#startDate').val();
        const selectedEndDate = $('#endDate').val();
        const periodType = $('#periodType').val();

        if (selectedStartDate && selectedEndDate) {
            $('#periodDate').text(selectedStartDate + ' ~ ' + selectedEndDate);
            loadSalesAndRevenueData(selectedStartDate, selectedEndDate, periodType);
        } else {
            alert('시작 날짜와 종료 날짜를 선택해 주세요.');
        }
    });
});

// 차트 및 테이블 데이터 로드
function loadSalesAndRevenueData(startDate, endDate, periodType) {
    $.ajax({
        url: '/erp/total-sales-revenue',
        type: 'GET',
        data: { startDate: startDate, endDate: endDate, periodType: periodType },
        success: function(response) {
            // 응답 데이터에서 정확한 키를 참조합니다
            const salesData = response.map(item => item.TOTAL_QUANTITY);  // 총 판매량 데이터를 추출
            const revenueData = response.map(item => item.TOTAL_REVENUE);  // 총 매출액 데이터를 추출

            // PERIOD 값을 유닉스 타임스탬프가 아닌 날짜 형식으로 변환
            const labels = response.map(item => {
                const timestamp = item.PERIOD;
                const date = new Date(timestamp);
                const year = date.getFullYear();
                const month = date.getMonth() + 1;  // 월은 0부터 시작하므로 +1
                const day = date.getDate();

                // 두 자리 숫자로 변환
                const formattedMonth = String(month).padStart(2, '0');
                const formattedDay = String(day).padStart(2, '0');

                // 날짜 형식으로 변환
                return year + '-' + formattedMonth + '-' + formattedDay;
            });

            // 기존 차트를 정확하게 삭제
            if (salesChart) {
                salesChart.destroy();
                salesChart = null;  // 차트가 null이 되도록 설정
            }
            if (revenueChart) {
                revenueChart.destroy();
                revenueChart = null;  // 차트가 null이 되도록 설정
            }

            // 판매량 차트
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            salesChart = new Chart(salesCtx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '총 판매량',
                        data: salesData,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: { scales: { y: { beginAtZero: true } } }
            });

            // 매출액 차트
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '총 매출액',
                        data: revenueData,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: { scales: { y: { beginAtZero: true } } }
            });

            // 테이블 데이터
            let salesTableBody = '';
            let revenueTableBody = '';
            for (let i = 0; i < labels.length; i++) {
                salesTableBody += '<tr><td>' + labels[i] + '</td><td>' + salesData[i] + '</td></tr>';
                revenueTableBody += '<tr><td>' + labels[i] + '</td><td>' + revenueData[i] + '</td></tr>';
            }
            $('#salesTableBody').html(salesTableBody);
            $('#revenueTableBody').html(revenueTableBody);
        },
        error: function(error) {
            console.error('데이터 로드 중 오류 발생:', error);
        }
    });
}

// 페이지 로드 및 조회 버튼 클릭 이벤트 처리
$(document).ready(function() {
    $('#loadData').click(function() {
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        const periodType = $('#periodType').val();

        if (startDate && endDate) {
            loadSalesAndRevenueData(startDate, endDate, periodType);
        } else {
            alert('시작 날짜와 종료 날짜를 입력하세요.');
        }
    });
});

</script>
</body>
</html>
