package com.example.academylms.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

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
import com.example.academylms.dto.LectureWeek;
import com.example.academylms.dto.User;
import com.example.academylms.mapper.LectureMaterialMapper;
import com.example.academylms.service.LectureMaterialService;
import com.example.academylms.service.LoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LectureMaterialController {
    @Autowired
    private LectureMaterialService lectureMaterialService;
    
    @Autowired
    private LectureMaterialMapper lectureMaterialMapper;
    
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

        // 주차 번호 조회해서 추가
        LectureWeek weekInfo = lectureMaterialService.getLectureWeekById(weekId); 
        if (weekInfo != null) {
            model.addAttribute("week", weekInfo.getWeek());  // JSP에서 사용할 ${week}
        }
        
        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialList";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialList";
        } else if ("admin".equals(role)) {
            return "admin/lectureMaterialList";
        } else {
            return "lectureOne";
        }
    }

//강의자료상세정보
    @GetMapping("/lectureMaterialOne")
    public String lectureMaterialDetail(@RequestParam int materialId,
                                        HttpServletRequest request,
                                        Model model) {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("loginUserId");
        User user = loginService.findById(userId);
        String role = user.getRole();

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        model.addAttribute("material", material);
        request.setAttribute("loginRole", role);

        // 여기서 weekId를 material에서 꺼내서 이후 redirect 등에 써야 함
        int weekId = material.getWeekId();
        model.addAttribute("weekId", weekId); // 필요시 추가

        if ("instructor".equals(role)) {
            return "instructor/lectureMaterialOne";
        } else if ("student".equals(role)) {
            return "student/lectureMaterialOne";
        } else if ("admin".equals(role)) {
            return "admin/lectureMaterialOne";
        }	else {
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
        
        if (!"instructor".equals(role) && !"admin".equals(role)) {
            // 권한 없음 → 강사는 아니므로 redirect
            return "redirect:/lectureMaterialList?weekId=" + weekId;
        }

        model.addAttribute("weekId", weekId);
        return "/instructor/addLectureMaterial";
    }

//강의자료추가    
    @PostMapping("/addLectureMaterial")
    public String lectureMaterialAdd(@RequestParam int weekId,
                                     @RequestParam("titles") List<String> titles,
                                     @RequestParam("files") MultipartFile[] files,
                                     HttpSession session) throws IOException {

        if (titles == null || titles.isEmpty()) return "redirect:/lectureMaterialWeekList";
        if (files == null || files.length == 0) return "redirect:/lectureMaterialWeekList";

        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) return "redirect:/login";

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String title = titles.get(i);

            if (file != null && !file.isEmpty() && title != null && !title.trim().isEmpty()) {
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
            }
        }

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
        
        if (!"instructor".equals(role) && !"admin".equals(role)) {
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
        if (title == null || title.trim().isEmpty()) return "redirect:/lectureMaterialOne?materialId=" + materialId;

        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }

        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        if (material == null) return "redirect:/lectureMaterialWeekList";

        material.setTitle(title);

        if (file != null && !file.isEmpty()) {
            String uploadDir = "C:/semi";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            if (!targetFile.getParentFile().exists()) {
                targetFile.getParentFile().mkdirs();
            }
            file.transferTo(targetFile);
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
        
        if (!"instructor".equals(role) && !"admin".equals(role)) {
            return "redirect:/lectureMaterialOne?materialId=" + materialId;
        }

        // 1️.삭제 전에 먼저 weekId 조회
        LectureMaterial material = lectureMaterialService.getLectureMaterialById(materialId);
        int weekId = material != null ? material.getWeekId() : 0; // 혹시 모르니 안전하게 처리

        // 2️.삭제 수행
        lectureMaterialService.deleteLectureMaterial(materialId);

        return "redirect:/lectureMaterialList?weekId=" + weekId;
    }
    
//주차별 게시판
    @GetMapping("/lectureMaterialWeekList")
    public String lectureWeekList(@RequestParam int lectureId, Model model, HttpSession session) {
    	//세션정보
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();

        // 전체 주차 리스트 불러오기 (주차에 자료가 있는 주차만)
        List<LectureWeek> weekList = lectureMaterialService.getWeeksByLectureId(lectureId);
        model.addAttribute("weekList", weekList);
        model.addAttribute("lectureId", lectureId);
        model.addAttribute("loginRole", role);
        
        if ("student".equals(role)) {
            return "student/lectureMaterialWeekList";
        } else if("instructor".equals(role)) {
        	return "instructor/lectureMaterialWeekList";
        } else if("admin".equals(role)){
        	return "admin/lectureMaterialWeekList";
        }
        	return "redirect:/login";
    }

//새 주차 생성
    @GetMapping("/addLectureWeek")
    public String addLectureWeek(@RequestParam int lectureId, Model model, HttpSession session) {
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }

        // 권한 확인
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();
        if (!"instructor".equals(role) && !"admin".equals(role)) {
            return "redirect:/lectureMaterialWeekList?lectureId=" + lectureId;
        }
        model.addAttribute("loginRole", role);
        
        // 1.현재 lecture에 대한 가장 마지막 주차 번호 조회
        Integer lastWeek = lectureMaterialMapper.getLastWeekNumber(lectureId);
        int newWeek = (lastWeek == null) ? 1 : lastWeek + 1;

        // 2️.새로운 LectureWeek 생성
        LectureWeek newLectureWeek = new LectureWeek();
        newLectureWeek.setLectureId(lectureId);
        newLectureWeek.setWeek(newWeek);

        // 3️.삽입 (자동으로 weekId 생성됨)
        lectureMaterialMapper.insertLectureWeek(newLectureWeek);

        // 4️.바로 새로 생성된 주차로 이동
        return "redirect:/lectureMaterialList?weekId=" + newLectureWeek.getWeekId();
    }
}
