package com.example.academylms.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.academylms.dto.User;
import com.example.academylms.service.LoginService;
import com.example.academylms.service.MainPageService;

import jakarta.servlet.http.HttpSession;
@Controller
public class MainPageController {
    @Autowired
    private MainPageService mainPageService;
    
    @Autowired
    private LoginService loginService;

    @GetMapping("/mainPage")
    public String getLectureListForMain(HttpSession session, Model model) {
        
        Map<String, List<Map<String, Object>>> lectureMap = getLectureMap(session);

        model.addAttribute("ongoingLectures", lectureMap.get("ongoing"));
        model.addAttribute("upcomingLectures", lectureMap.get("upcoming"));
        model.addAttribute("endedLectures", lectureMap.get("ended"));
     
        int userId = (int)session.getAttribute("loginUserId"); // 세션 값 호출
        User user = loginService.findById(userId); // user에 담겨있는 정보 불러오기

        System.out.println("==> loginUserId in mainPage = " + session.getAttribute("loginUserId"));
        session.setAttribute("loginUserId", user.getUserId());

           if("student".equals(user.getRole())) { // user 역할이 학생일경우
              return "student/mainPage";
           } else if ("instructor".equals(user.getRole())){
              return "instructor/mainPage";
           } else if ("admin".equals(user.getRole())){
               return "admin/mainPage";
           } else {
              return "redirect:/login";
           }
    }
    
    private Map<String, List<Map<String, Object>>> getLectureMap(HttpSession session) {
        int userId = (int)session.getAttribute("loginUserId"); // 세션 값 호출
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        
        
        List<Map<String, Object>> lectureList = new ArrayList<>();

        if ("admin".equals(role)) {
            lectureList = mainPageService.getAllLectures();
        } else if ("instructor".equals(role)) {
            lectureList = mainPageService.getLecturesByInstructor(userId);
        } else if ("student".equals(role)) {
            lectureList = mainPageService.getLecturesByStudent(userId);
        }

        // 상태별 분류
        List<Map<String, Object>> ongoingLectures = new ArrayList<>();
        List<Map<String, Object>> upcomingLectures = new ArrayList<>();
        List<Map<String, Object>> endedLectures = new ArrayList<>();

        LocalDateTime now = LocalDateTime.now();

        for (Map<String, Object> lecture : lectureList) {
        	LocalDateTime startedAt = (LocalDateTime) lecture.get("started_at");  
            LocalDateTime endedAt = (LocalDateTime) lecture.get("ended_at"); 

            if (now.isBefore(startedAt)) {
                upcomingLectures.add(lecture);
            } else if (now.isAfter(endedAt)) {
                endedLectures.add(lecture);
            } else {
                ongoingLectures.add(lecture);
            }
        }

        Map<String, List<Map<String, Object>>> resultMap = new HashMap<>();
        resultMap.put("ongoing", ongoingLectures);
        resultMap.put("upcoming", upcomingLectures);
        resultMap.put("ended", endedLectures);

        return resultMap;
    }
}