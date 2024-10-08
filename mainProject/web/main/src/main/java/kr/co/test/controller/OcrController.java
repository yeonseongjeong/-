package kr.co.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;

@Controller
public class OcrController {

    private static final String UPLOAD_DIR = "D:\\rpawork\\workspace\\mainproject\\mainProject\\web\\main\\src\\main\\webapp\\resources\\img"; // 파일 저장 경로
    
    @GetMapping("/erp/ocr")
    public String showOcrUploadPage(Model model) {
        // 업로드 결과 메시지를 모델에 추가 (선택적)
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
            redirectAttributes.addFlashAttribute("message", "파일이 성공적으로 업로드되었습니다.");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("message", "파일 업로드에 실패했습니다.");
            e.printStackTrace();
        }

        return "redirect:/erp/ocr"; // 업로드 후 OCR 관리 페이지로 리디렉션
    }
}
