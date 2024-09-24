package kr.co.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.test.repository.SalesAnalysisDAO;

import java.util.List;
import java.util.Map;

@Service
public class SalesAnalysisService {

    @Autowired
    private SalesAnalysisDAO salesAnalysisDAO;

    // 특정 기간 동안 카테고리별 판매 데이터를 가져오는 서비스 메서드
    public List<Map<String, Object>> getCategorySalesData(String startDate, String endDate) {
        return salesAnalysisDAO.getSalesDataByCategory(startDate, endDate);
    }

    // 특정 기간 동안 카테고리별 매출 데이터를 가져오는 서비스 메서드
    public List<Map<String, Object>> getRevenueDataByCategory(String startDate, String endDate) {
        return salesAnalysisDAO.getRevenueDataByCategory(startDate, endDate);
    }
 // 특정 기간 동안 전체 판매 데이터를 가져오는 서비스 메서드
    public List<Map<String, Object>> getTotalSalesAndRevenueData(String startDate, String endDate, String periodType) {
        return salesAnalysisDAO.getTotalSalesAndRevenue(startDate, endDate, periodType);
    }

}
