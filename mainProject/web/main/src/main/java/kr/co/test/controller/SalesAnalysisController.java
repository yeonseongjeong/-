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

    @GetMapping("/erp/sales-analysis-category")
    public String showSalesAnalysisPage() {
        return "sales-analysis-category";  // JSP 페이지 이름 (카테고리별 분석)
    }
    
    @GetMapping("/erp/sales-analysis-all")
    public String showSalesAnalysisPageAll() {
        return "sales-analysis-all";  // JSP 페이지 이름 (전체 분석)
    }
    @GetMapping("/erp/sales-analysis-brand")
    public String showSalesAnalysisPageBrand() {
        return "sales-analysis-brand";  // JSP 페이지 이름 (전체 분석)
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

    // 특정 기간 동안 전체 판매 데이터를 반환하는 메서드
    @GetMapping("/erp/total-sales-revenue")
    @ResponseBody
    public List<Map<String, Object>> getTotalSalesData(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("periodType") String periodType) {
        return salesAnalysisService.getTotalSalesAndRevenueData(startDate, endDate, periodType);
    }
    @GetMapping("/erp/sales-data-brand")
    @ResponseBody
    public List<Map<String, Object>> getBrandSalesData(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("periodType") String periodType) {
        return salesAnalysisService.getSalesDataByBrand(startDate, endDate);
    }
}
