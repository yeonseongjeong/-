package kr.co.test.controller;

import kr.co.test.service.SalesAnalysisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/erp")
public class ReportController {

    @Autowired
    private SalesAnalysisService salesAnalysisService;

    // 보고서 생성 페이지 반환
    @GetMapping("/report")
    public String showReportPage(Model model) {
        return "report"; // JSP 파일 이름
    }

    // 보고서 생성 요청 처리
    @PostMapping("/generateReport")
    @ResponseBody
    public ResponseEntity<Map<String, String>> generateReport(
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam String periodType) {

        String fileName;
        String filePath;

        // 시작일과 종료일을 파싱
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);

        if ("WEEKLY".equals(periodType)) {
            // 주의 시작일과 종료일 계산
            LocalDate weekStart = start.with(TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
            LocalDate weekEnd = end.with(TemporalAdjusters.nextOrSame(java.time.DayOfWeek.SUNDAY));

            // 날짜 형식 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
            
            // 사용자가 입력한 startDate를 사용하여 파일 이름 생성
            fileName = String.format("report_%s~%s.csv", start.format(formatter), end.format(formatter));
        } else {
            // 일간 보고서 이름 수정
            DateTimeFormatter dailyFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
            String formattedStartDate = start.format(dailyFormatter);
            String formattedEndDate = end.format(dailyFormatter);
            fileName = String.format("report_%s~%s.csv", formattedStartDate, formattedEndDate);
        }

        filePath = Paths.get("D:\\rpawork\\workspace", fileName).toString();

        try (PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(filePath)))) {
            if ("WEEKLY".equals(periodType)) {
                writer.println("주간 기간,총 판매량,총 매출액");

                LocalDate current = start.with(TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));

                while (current.isBefore(end) || current.isEqual(end)) {
                    LocalDate weekEndDate = current.plusDays(6); // 주의 마지막 날

                    // 주간 데이터 가져오기
                    List<Map<String, Object>> salesData = salesAnalysisService.getTotalSalesAndRevenueData(
                            current.format(DateTimeFormatter.ISO_LOCAL_DATE),
                            weekEndDate.format(DateTimeFormatter.ISO_LOCAL_DATE),
                            "WEEKLY");

                    String totalQuantity = "0"; // 총 판매량 초기화
                    String totalRevenue = "0"; // 총 매출액 초기화

                    // 데이터 집계
                    for (Map<String, Object> row : salesData) {
                        totalQuantity = row.get("TOTAL_QUANTITY").toString();
                        totalRevenue = row.get("TOTAL_REVENUE").toString();
                    }

                    // 주간 범위와 판매량 및 매출액 기록
                    writer.printf("%s~%s,%s,%s\n",
                            current.format(DateTimeFormatter.ofPattern("yyyy.MM.dd")),
                            weekEndDate.format(DateTimeFormatter.ofPattern("yyyy.MM.dd")),
                            totalQuantity, totalRevenue);

                    // 다음 주로 이동
                    current = current.plusWeeks(1);
                }
            } else {
                // 일간 및 기타 데이터 작성
                writer.println("날짜,총 판매량,총 매출액");
                List<Map<String, Object>> salesData = salesAnalysisService.getTotalSalesAndRevenueData(startDate, endDate, periodType);

                for (Map<String, Object> row : salesData) {
                    String period = row.get("PERIOD").toString().split(" ")[0]; // 시간 부분 제거
                    String totalQuantity = row.get("TOTAL_QUANTITY").toString();
                    String totalRevenue = row.get("TOTAL_REVENUE").toString();
                    writer.printf("%s,%s,%s\n", period, totalQuantity, totalRevenue);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", "보고서 생성 중 I/O 오류 발생: " + e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", "보고서 생성 중 오류 발생: " + e.getMessage()));
        }

        return ResponseEntity.ok(Map.of("message", "보고서가 성공적으로 생성되었습니다."));
    }
}
