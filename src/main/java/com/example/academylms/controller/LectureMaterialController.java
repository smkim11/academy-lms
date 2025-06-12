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
import com.example.academylms.dto.User;
import com.example.academylms.service.LectureMaterialService;
import com.example.academylms.service.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LectureMaterialController {
    @Autowired
    private LectureMaterialService lectureMaterialService;
    
    @Autowired
    private LoginService loginService;

//강의자료리스트    
    @GetMapping("/lectureMaterialList")
    public String lectureMaterialList(@RequestParam int weekId, Model model, HttpSession session) {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
    	if (userIdObj == null) {
    		return "redirect:/login";
    	}
    	int userId = (int) userIdObj;
    	User user = loginService.findById(userId);
    	String role = user.getRole();
    	
        List<LectureMaterial> materialList = lectureMaterialService.getLectureMaterialsByWeek(weekId);
        model.addAttribute("materialList", materialList);
        model.addAttribute("weekId", weekId);

        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialList";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialList";
        } else {
            return "lectureOne";
        }
    }

//강의자료상세정보
    @GetMapping("/lectureMaterialOne")
    public String lectureMaterialDetail(@RequestParam int materialId,
    									HttpServletRequest request,
    									Model model) {
    	//세션정보
    	HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId); 
        String role = user.getRole();
        
        //나머지 작업들
        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        model.addAttribute("material", material);
        request.setAttribute("loginRole", role);
        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialOne";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialOne";
        } else {
            return "lectureMaterialList";
        }
    }

//강의자료추가
    @GetMapping("/addLectureMaterial")
    public String lectureMaterialAddForm(@RequestParam int weekId, Model model, HttpSession session) {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        
        if (!"instructor".equals(role)) {
            // 권한 없음 → 강사는 아니므로 redirect
            return "redirect:/lectureMaterialList?weekId=" + weekId;
        }

        model.addAttribute("weekId", weekId);
        return "/instructor/addLectureMaterial";
    }

//강의자료추가    
    @PostMapping("/addLectureMaterial")
    public String lectureMaterialAdd(@RequestParam int weekId,
                                     @RequestParam String title,
                                     @RequestParam MultipartFile file,
                                     HttpSession session) throws IOException {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        
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

//강의자료수정
    @GetMapping("/updateLectureMaterial")
    public String lectureMaterialEditForm(@RequestParam int materialId, Model model, HttpSession session) {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        
        if (!"instructor".equals(role)) {
            // 권한 없음 → redirect
            LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
            return "redirect:/lectureMaterialOne?materialId=" + materialId;
        }

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        model.addAttribute("material", material);
        return "instructor/updateLectureMaterial";
    }

//강의자료수정
    @PostMapping("/updateLectureMaterial")
    public String lectureMaterialEdit(@RequestParam int materialId,
                                      @RequestParam String title,
                                      @RequestParam MultipartFile file,
                                      HttpSession session) throws IOException {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        
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
    
//강의자료삭제    
    @GetMapping("/deleteLectureMaterial")
    public String deleteLectureMaterial(@RequestParam int materialId, HttpSession session) {
    	//세션정보
    	Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        
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
