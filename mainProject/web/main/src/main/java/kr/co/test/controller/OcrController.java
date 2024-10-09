package kr.co.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
public class OcrController {

    private static final String UPLOAD_DIR = "C:\\RPAWork\\workspace\\mainproject\\mainProject\\web\\main\\src\\main\\webapp\\resources\\img\\ocr"; // 파일 저장 경로

    @GetMapping("/erp/ocr")
    public String showOcrUploadPage(Model model) {
        return "ocrUpload"; // JSP 파일 이름 (확장자 제외)
    }

    @PostMapping("/erp/uploadImage")
    public String uploadImage(@RequestParam("imageFile") MultipartFile file, RedirectAttributes redirectAttributes) {
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "파일을 선택하세요.");
            return "redirect:/erp/ocr"; // OCR 관리 페이지로 리디렉션
        }

        try {
            // 파일 저장
            File uploadFile = new File(UPLOAD_DIR + File.separator + file.getOriginalFilename());
            file.transferTo(uploadFile);
            
            // 파이썬 스크립트 실행
            ProcessBuilder processBuilder = new ProcessBuilder(
                "python", // Windows 환경에서는 python, Linux 환경에서는 python3로 설정
                "C:\\RPAWork\\workspace\\mainproject\\mainproject\\py\\ocr.py", // 파이썬 스크립트 경로
                uploadFile.getAbsolutePath() // 업로드된 파일의 절대 경로를 파라미터로 전달
            );
            
            // Process 실행
            Process process = processBuilder.start();

            // 파이썬 스크립트의 표준 출력 및 에러 출력 읽기
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                output.append("STDOUT: ").append(line).append("\n");
            }

            StringBuilder errorOutput = new StringBuilder();
            while ((line = errorReader.readLine()) != null) {
                errorOutput.append("STDERR: ").append(line).append("\n");
            }

            int exitCode = process.waitFor(); // 프로세스 완료될 때까지 대기

            if (exitCode == 0) {
                redirectAttributes.addFlashAttribute("message", "파일이 성공적으로 업로드되었고, OCR 처리가 완료되었습니다.");
                System.out.println("OCR 처리 결과: \n" + output.toString());
            } else {
                redirectAttributes.addFlashAttribute("message", "파일 업로드는 성공했지만 OCR 처리 중 오류가 발생했습니다.");
                System.out.println("OCR 처리 중 오류 발생: \n" + errorOutput.toString());
            }

        } catch (IOException | InterruptedException e) {
            redirectAttributes.addFlashAttribute("message", "파일 업로드 또는 OCR 처리에 실패했습니다.");
            e.printStackTrace();
        }

        return "redirect:/erp/ocr"; // 업로드 후 OCR 관리 페이지로 리디렉션
    }
}
