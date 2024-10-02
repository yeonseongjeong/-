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
		<!-- 메인 컨텐츠 영역 -->
		<div class="text-center mb-4">
			<label for="startDate">시작 날짜:</label> <input type="date"
				id="startDate" class="form-control"
				style="display: inline-block; width: auto;"> <label
				for="endDate">종료 날짜:</label> <input type="date" id="endDate"
				class="form-control" style="display: inline-block; width: auto;">
			<button id="loadData" class="btn btn-primary">조회</button>
		</div>
		<div class="row">
			<!-- 좌측: 판매량 -->
			<div class="col-md-6 p-3"
				style="box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 10px; margin-bottom: 20px;">
				<h2 class="text-center mb-4">카테고리별 판매량 분석</h2>

				<div class="text-center">
					<canvas id="salesChart" width="400" height="200"></canvas>
				</div>

				<h2 class="mt-4">판매 내역</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>총 판매량</th>
						</tr>
					</thead>
					<tbody id="salesTableBody">
					</tbody>
				</table>
			</div>

			<!-- 우측: 매출액 -->
			<div class="col-md-6 p-3"
				style="box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 10px; margin-bottom: 20px;">
				<h2 class="text-center mb-4">카테고리별 매출액 분석</h2>
				<div class="text-center">
					<canvas id="revenueChart" width="400" height="200"></canvas>
				</div>

				<h2 class="mt-4">매출액 내역</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>카테고리</th>
							<th>총 매출액</th>
						</tr>
					</thead>
					<tbody id="revenueTableBody">
					</tbody>
				</table>
			</div>
		</div>

		<script>
        let salesChart, revenueChart;

        // 오늘 날짜를 'YYYY-MM-DD' 형식으로 반환하는 함수
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
    const today = getTodayDate(); // 현재 날짜를 가져옴

    $('#startDate').val(startDate);  // 시작 날짜를 2024-09-01로 설정
    $('#endDate').val(today);  // 종료 날짜를 오늘 날짜로 설정

    // 기본 데이터를 2024-09-01부터 오늘 날짜까지로 로드
    getSalesData(startDate, today);
    getRevenueData(startDate, today);

    $('#loadData').click(function () {
        const selectedStartDate = $('#startDate').val();
        const selectedEndDate = $('#endDate').val();

        if (selectedStartDate && selectedEndDate) {
            $('#periodDate').text(selectedStartDate + ' ~ ' + selectedEndDate);
            getSalesData(selectedStartDate, selectedEndDate);
            getRevenueData(selectedStartDate, selectedEndDate);
        } else {
            alert('날짜를 선택해 주세요.');
        }
    });
});


        // 판매량 차트 생성 함수
        function createSalesChart(labels, data) {
            if (salesChart) {
                salesChart.destroy(); 
            }

            const ctx = document.getElementById('salesChart').getContext('2d');
            salesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '판매량',
                        data: data,
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // 매출액 차트 생성 함수
        function createRevenueChart(labels, data) {
            if (revenueChart) {
                revenueChart.destroy();
            }

            const ctx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '매출액',
                        data: data,
                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // 판매 데이터 가져오기
        function getSalesData(startDate, endDate) {
            $.ajax({
                url: '/erp/sales-data', 
                type: 'GET',
                data: { startDate: startDate, endDate: endDate },
                success: function (response) {
                    const labels = response.map(item => item.CATEGORY_NAME);
                    const data = response.map(item => item.TOTAL_QUANTITY);
                    const tableBody = document.getElementById("salesTableBody");
                    tableBody.innerHTML = "";

                    response.forEach(item => {
                        let row = "<tr>" +
                            "<td>" + item.CATEGORY_NAME + "</td>" +
                            "<td>" + item.TOTAL_QUANTITY + "</td>" +
                            "</tr>";
                        tableBody.innerHTML += row;
                    });
                    createSalesChart(labels, data);
                },
                error: function (error) {
                    console.error('데이터를 가져오는 중 오류 발생:', error);
                }
            });
        }

        // 매출 데이터 가져오기
        function getRevenueData(startDate, endDate) {
            $.ajax({
                url: '/erp/revenue-data', 
                type: 'GET',
                data: { startDate: startDate, endDate: endDate },
                success: function (response) {
                    const labels = response.map(item => item.CATEGORY_NAME);
                    const data = response.map(item => item.TOTAL_REVENUE);
                    const tableBody = document.getElementById("revenueTableBody");
                    tableBody.innerHTML = "";

                    response.forEach(item => {
                        let row = "<tr>" +
                            "<td>" + item.CATEGORY_NAME + "</td>" +
                            "<td>" + item.TOTAL_REVENUE + "</td>" +
                            "</tr>";
                        tableBody.innerHTML += row;
                    });
                    createRevenueChart(labels, data);
                },
                error: function (error) {
                    console.error('데이터를 가져오는 중 오류 발생:', error);
                }
            });
        }

    </script>
	</div>

	<footer class="bg-light text-center py-3">
		<p>&copy; 2024 ERP 시스템. 모든 권리 보유.</p>
	</footer>

</body>
</html>
