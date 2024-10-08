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
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
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
		<div class="text-center mb-4">
			<label for="startDate">시작 날짜:</label> <input type="date"
				id="startDate" class="form-control"
				style="display: inline-block; width: auto;"> <label
				for="endDate">종료 날짜:</label> <input type="date" id="endDate"
				class="form-control" style="display: inline-block; width: auto;">

			<label for="sortBy">정렬 기준:</label> <select id="sortBy"
				class="form-select" style="display: inline-block; width: auto;">
				<option value="brand">이름순</option>
				<option value="desc">내림차순</option>
			</select>

			<button id="loadData" class="btn btn-primary">조회</button>
		</div>


		<div class="row">
			<div class="col-md-12">
				<h3 class="text-center">브랜드별 판매량</h3>
				<canvas id="salesChart" width="800" height="400"></canvas>
				<table class="table table-striped mt-4">
					<thead>
						<tr>
							<th>브랜드</th>
							<th>총 판매량</th>
						</tr>
					</thead>
					<tbody id="salesTableBody"></tbody>
				</table>
			</div>

			<div class="col-md-12 mt-5">
				<h3 class="text-center">브랜드별 매출액</h3>
				<canvas id="revenueChart" width="800" height="400"></canvas>
				<table class="table table-striped mt-4">
					<thead>
						<tr>
							<th>브랜드</th>
							<th>총 매출액</th>
						</tr>
					</thead>
					<tbody id="revenueTableBody"></tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
        let salesChart = null;
        let revenueChart = null;

        // 오늘 날짜를 구하는 함수
        function getTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
            const day = String(today.getDate()).padStart(2, '0');
            return year + '-' + month + '-' + day;
        }

        // 페이지 로드 시 기본 날짜 설정 및 데이터 자동 조회
        $(document).ready(function () {
            const startDate = '2024-09-01';  // 시작 날짜를 2024-09-01로 설정
            const today = getTodayDate();  // 오늘 날짜

            $('#startDate').val(startDate);
            $('#endDate').val(today);

            // 페이지 로드 시 자동으로 데이터를 조회
            loadSalesAndRevenueData(startDate, today, 'brand');

            // 조회 버튼 클릭 시
            $('#loadData').click(function () {
                const selectedStartDate = $('#startDate').val();
                const selectedEndDate = $('#endDate').val();
                const sortBy = $('#sortBy').val();

                if (selectedStartDate && selectedEndDate) {
                    loadSalesAndRevenueData(selectedStartDate, selectedEndDate, sortBy);
                } else {
                    alert('시작 날짜와 종료 날짜를 입력하세요.');
                }
            });
        });

        // 판매량 및 매출액 차트 로드 함수
        function loadSalesAndRevenueData(startDate, endDate, sortBy) {
            $.ajax({
                url: '/erp/sales-data-brand',
                type: 'GET',
                data: { startDate: startDate, endDate: endDate, sortBy: sortBy },
                success: function(response) {
                    let salesData = response.map(item => item.TOTAL_QUANTITY || 0);
                    let revenueData = response.map(item => item.TOTAL_REVENUE || 0);
                    let labels = response.map(item => item.BRAND || '');

                    // 내림차순 정렬
                    if (sortBy === 'desc') {
                        const combinedData = labels.map((brand, index) => {
                            return {
                                brand: brand,
                                total_quantity: salesData[index],
                                total_revenue: revenueData[index]
                            };
                        });

                        combinedData.sort((a, b) => {
                            return (b.total_quantity + b.total_revenue) - (a.total_quantity + a.total_revenue);
                        });

                        labels = combinedData.map(item => item.brand);
                        salesData = combinedData.map(item => item.total_quantity);
                        revenueData = combinedData.map(item => item.total_revenue);
                    }

                    if (salesChart) {
                        salesChart.destroy();
                    }
                    if (revenueChart) {
                        revenueChart.destroy();
                    }

                    // 판매량 차트 생성
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
                        options: { 
                            scales: { 
                                y: { beginAtZero: true },
                                x: {
                                    ticks: { autoSkip: false, maxRotation: 90, minRotation: 45 }  // X축 레이블 회전
                                }
                            }
                        }
                    });

                    // 매출액 차트 생성
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
                        options: { 
                            scales: { 
                                y: { beginAtZero: true },
                                x: {
                                    ticks: { autoSkip: false, maxRotation: 90, minRotation: 45 }  // X축 레이블 회전
                                }
                            }
                        }
                    });

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
	</script>
</body>
</html>
