package kr.co.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.test.service.SalesAnalysisService;

import java.util.List;
import java.util.Map;

@Controller
public class SalesAnalysisController {

    @Autowired
    private SalesAnalysisService salesAnalysisService;

    @GetMapping("/erp/sales-analysis")
    public String showSalesAnalysisPage() {
        return "sales-analysis";  // JSP 페이지 이름
    }

    // 특정 기간 동안 카테고리별 판매 데이터를 반환하는 메서드
    @GetMapping("/erp/sales-data")
    @ResponseBody
    public List<Map<String, Object>> getSalesData(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate) {
        return salesAnalysisService.getCategorySalesData(startDate, endDate);
    }

    // 특정 기간 동안 카테고리별 매출 데이터를 반환하는 메서드
    @GetMapping("/erp/revenue-data")
    @ResponseBody
    public List<Map<String, Object>> getRevenueData(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate) {
        return salesAnalysisService.getRevenueDataByCategory(startDate, endDate);
    }
}
