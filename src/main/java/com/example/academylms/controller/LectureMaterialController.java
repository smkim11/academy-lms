package com.example.academylms.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.academylms.dto.LectureMaterial;
import com.example.academylms.service.LectureMaterialService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LectureMaterialController {
    @Autowired
    private LectureMaterialService lectureMaterialService;

    @GetMapping("/lectureMaterialList")
    public String lectureMaterialList(@RequestParam int weekId, Model model, HttpSession session) {
        List<LectureMaterial> materialList = lectureMaterialService.getLectureMaterialsByWeek(weekId);
        model.addAttribute("materialList", materialList);
        model.addAttribute("weekId", weekId);

        //String role = (String) session.getAttribute("role");
        //여기부터
        String role = "instructor";
        //여기까지 삭제		
        
        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialList";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialList";
        } else {
            return "lectureOne";
        }
    }

    @GetMapping("/lectureMaterialOne")
    public String lectureMaterialDetail(@RequestParam int materialId, Model model) {
        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        model.addAttribute("material", material);

        // 임시로 강사 고정 (테스트 후 원복!)
        String role = "instructor"; // 나중에 String role = (String) session.getAttribute("role"); 로 바꿀 것

        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialOne";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialOne";
        } else {
            return "lectureMaterialList";
        }
    }

    @GetMapping("/addLectureMaterial")
    public String lectureMaterialAddForm(@RequestParam int weekId, Model model, HttpSession session) {
    	String role = "instructor"; // 나중에 String role = (String) session.getAttribute("role"); 로 바꿀 것
    	
        if (!"instructor".equals(role)) {
            // 권한 없음 → 강사는 아니므로 redirect
            return "redirect:/lectureMaterialList?weekId=" + weekId;
        }

        model.addAttribute("weekId", weekId);
        return "/instructor/addLectureMaterial";
    }

    @PostMapping("/addLectureMaterial")
    public String lectureMaterialAdd(@RequestParam int weekId,
                                     @RequestParam String title,
                                     @RequestParam MultipartFile file,
                                     HttpSession session) throws IOException {

    	String role = "instructor"; // 나중에 String role = (String) session.getAttribute("role"); 로 바꿀 것
        if (!"instructor".equals(role)) {
            return "redirect:/lectureMaterialList?weekId=" + weekId;
        }

        String uploadDir = "C:/semi";
        String originalFilename = file.getOriginalFilename();
        String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
        File targetFile = new File(uploadDir, savedFilename);
        file.transferTo(targetFile);

        LectureMaterial material = new LectureMaterial();
        material.setWeekId(weekId);
        material.setTitle(title);
        material.setFileUrl("/semi/" + savedFilename);

        lectureMaterialService.addLectureMaterial(material);

        return "redirect:/lectureMaterialList?weekId=" + weekId;
    }

    @GetMapping("/updateLectureMaterial")
    public String lectureMaterialEditForm(@RequestParam int materialId, Model model, HttpSession session) {
        String role = "instructor";
        //나중에 위에꺼 이걸로 바꿔주기String role = (String) session.getAttribute("role");
        
        if (!"instructor".equals(role)) {
            // 권한 없음 → redirect
            LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
            return "redirect:/lectureMaterialOne?materialId=" + materialId;
        }

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        model.addAttribute("material", material);
        return "instructor/updateLectureMaterial";
    }

    @PostMapping("/updateLectureMaterial")
    public String lectureMaterialEdit(@RequestParam int materialId,
                                      @RequestParam String title,
                                      @RequestParam MultipartFile file,
                                      HttpSession session) throws IOException {

        String role = "instructor";
        //나중에 위에꺼 이걸로 바꿔주기String role = (String) session.getAttribute("role");
        
        
        if (!"instructor".equals(role)) {
            return "redirect:/lectureMaterialOne?materialId=" + materialId;
        }

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        material.setTitle(title);

        // 파일이 비어있지 않을 때만 새로 저장
        if (!file.isEmpty()) {
            String uploadDir = "C:/semi";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            
            // 디렉토리 존재하지 않으면 생성
            if (!targetFile.getParentFile().exists()) {
                targetFile.getParentFile().mkdirs();
            }
            file.transferTo(targetFile);
            
            // 새 파일 URL 설정
            material.setFileUrl("/semi/" + savedFilename);
        }

        lectureMaterialService.updateLectureMaterial(material);

        return "redirect:/lectureMaterialOne?materialId=" + materialId;
    }
    
    @GetMapping("/deleteLectureMaterial")
    public String deleteLectureMaterial(@RequestParam int materialId, HttpSession session) {
        String role = "instructor";
        // 나중에 String role = (String) session.getAttribute("role");

        if (!"instructor".equals(role)) {
            return "redirect:/lectureMaterialOne?materialId=" + materialId;
        }

        // 1️⃣ 삭제 전에 먼저 weekId 조회
        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        int weekId = material != null ? material.getWeekId() : 0; // 혹시 모르니 안전하게 처리

        // 2️⃣ 삭제 수행
        lectureMaterialService.deleteLectureMaterial(materialId);

        // 3️⃣ 리다이렉트
        return "redirect:/lectureMaterialList?weekId=" + weekId;
    }
}
