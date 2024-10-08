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

function loadSalesAndRevenueData(startDate, endDate, periodType) {
    $.ajax({
        url: '/erp/total-sales-revenue',
        type: 'GET',
        data: { startDate: startDate, endDate: endDate, periodType: periodType },
        success: function(response) {
            const salesData = response.map(item => item.TOTAL_QUANTITY || 0);  // 총 판매량 데이터를 추출 (데이터가 없을 경우 0)
            const revenueData = response.map(item => item.TOTAL_REVENUE || 0);  // 총 매출액 데이터를 추출 (데이터가 없을 경우 0)

            const labels = response.map(item => {
                const timestamp = item.PERIOD;

                if (!timestamp) {
                    // 타임스탬프가 없으면 '-- ~ --'로 표시
                    return '-- ~ --';
                }

                const date = new Date(timestamp);

                if (periodType === 'WEEKLY') {
                    // 주간 데이터인 경우 "연도 월 n번째 주"로 표시
                    const weekNumber = getWeekNumberOfMonth(date);
                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1);  // 월은 0부터 시작하므로 +1
                    return year + '년 ' + month + '월 ' + weekNumber + '번째 주';
                } else {
                    // 일간 또는 월간 데이터인 경우 기존 방식
                    const year = date.getFullYear();
                    const month = date.getMonth() + 1;  // 월은 0부터 시작하므로 +1
                    const day = date.getDate();

                    // 두 자리 숫자로 변환
                    const formattedMonth = String(month).padStart(2, '0');
                    const formattedDay = String(day).padStart(2, '0');

                    // 날짜 형식으로 변환
                    return year + '-' + formattedMonth + '-' + formattedDay;
                }
            });

            // 기존 차트 제거
            if (salesChart) {
                salesChart.destroy();
                salesChart = null;
            }
            if (revenueChart) {
                revenueChart.destroy();
                revenueChart = null;
            }

            // 판매량 꺾은선 차트
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            salesChart = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '총 판매량',
                        data: salesData,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        fill: true,
                        borderWidth: 2,
                        tension: 0.3
                    }]
                },
                options: { scales: { y: { beginAtZero: true } } }
            });

            // 매출액 꺾은선 차트
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '총 매출액',
                        data: revenueData,
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        fill: true,
                        borderWidth: 2,
                        tension: 0.3
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

// 해당 날짜가 해당 월의 몇 번째 주인지 계산하는 함수
function getWeekNumberOfMonth(date) {
    const firstDayOfMonth = new Date(date.getFullYear(), date.getMonth(), 1);
    const targetDate = new Date(date);  // 대상 날짜를 복사하여 수정
    const dayOfWeek = firstDayOfMonth.getDay();  // 해당 월의 첫 날이 무슨 요일인지 (0: 일요일, 1: 월요일, ..., 6: 토요일)

    // 날짜 기준으로 주차 계산
    const adjustedDate = targetDate.getDate() + dayOfWeek;
    const weekNumber = Math.ceil(adjustedDate / 7);

    return weekNumber;
}

</script>
</body>
</html>
