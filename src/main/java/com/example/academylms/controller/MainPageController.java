package com.example.academylms.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
        // 세션정보
        Integer userId = (Integer) session.getAttribute("loginUserId");
        if (userId == null) return "redirect:/login";
        
        User user = loginService.findById(userId);
        String role = user.getRole();

        model.addAttribute("role", role); 
        model.addAttribute("userId", userId);

        // 진행중, 예정, 종료 강의
        Map<String, List<Map<String, Object>>> lectureMap = getLectureMap(userId, role);
        model.addAttribute("ongoingLectures", lectureMap.get("ongoing"));
        model.addAttribute("upcomingLectures", lectureMap.get("upcoming"));
        model.addAttribute("endedLectures", lectureMap.get("ended"));

        // 시간표용 ongoing 강의 조회
        List<Map<String, Object>> ongoingLectureList = new ArrayList<>();
        if ("student".equals(role)) {
            ongoingLectureList = mainPageService.getOngoingLecturesForStudent(userId);
        } else if ("instructor".equals(role)) {
            ongoingLectureList = mainPageService.getOngoingLecturesForInstructor(userId);
        }

        List<String> dayList = Arrays.asList("MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN");
        List<String> timeList = Arrays.asList("MORNING", "AFTERNOON", "EVENING");

        model.addAttribute("dayList", dayList);
        model.addAttribute("timeList", timeList);

        Map<Integer, String> lectureColorMap = new HashMap<>();
        Map<String, Map<String, Object>> timetable = createTimetable(ongoingLectureList, lectureColorMap);

        model.addAttribute("timetable", timetable);
        model.addAttribute("lectureColorMap", lectureColorMap);

        if ("student".equals(role)) {
            return "student/mainPage";
        } else if ("instructor".equals(role)) {
            return "instructor/mainPage";
        } else if ("admin".equals(role)) {
            return "admin/mainPage";
        } else {
            return "redirect:/login";
        }
    }
    
//메인페이지    
    //강의 구분(진행중,종료,진행예정) / 역할별 구분
    private Map<String, List<Map<String, Object>>> getLectureMap(int userId, String role) {
    	
        List<Map<String, Object>> lectureList = new ArrayList<>();
        if ("admin".equals(role)) {
            lectureList = mainPageService.getAllLectures();
        } else if ("instructor".equals(role)) {
            lectureList = mainPageService.getLecturesByInstructor(userId);
        } else if ("student".equals(role)) {
            lectureList = mainPageService.getLecturesByStudent(userId);
        }
        
        for (Map<String, Object> lecture : lectureList) {
            System.out.println("startedAt 타입: " + lecture.get("started_at").getClass().getName());
            System.out.println("endedAt 타입: " + lecture.get("ended_at").getClass().getName());
        }

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
            	if (endedAt.plusDays(14).isAfter(now)) {
                    endedLectures.add(lecture);
                }
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

    
    //시간표
//강의별 색 구분위한 배경색상리스트
    private final String[] COLOR_POOL = {
    	    "#FFCCCC", "#CCE5FF", "#CCFFCC", "#FFF5CC", "#E0CCFF",
    	    "#FFD9E6", "#B3E6CC", "#E6CCB3", "#D1E0E0", "#F0C9A9"
    	};

//시간표
	private Map<String, Map<String, Object>> createTimetable(List<Map<String, Object>> lectures, Map<Integer, String> lectureColorMap) {
	    String[] days = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
	    String[] times = {"MORNING", "AFTERNOON", "EVENING"};

	    //timetable[요일][시간대] = 강의정보
	    Map<String, Map<String, Object>> timetable = new LinkedHashMap<>();
	    for (String d : days) {
	        timetable.put(d, new LinkedHashMap<>());
	        for (String t : times) {
	            timetable.get(d).put(t, null);// 초기엔 다 null
	        }
	    }

	    int colorIndex = 0;

	    for (Map<String, Object> lec : lectures) {
	        String dayStr = ((String) lec.get("day")).replaceAll("\"", "").trim();
	        String time = ((String) lec.get("time")).replaceAll("\"", "").trim();
	        Integer lectureId = (Integer) lec.get("lecture_id");

	        if (dayStr == null || time == null || lectureId == null) continue;

	        // 강의별로 고유 색상 지정
	        if (!lectureColorMap.containsKey(lectureId)) {
	            lectureColorMap.put(lectureId, COLOR_POOL[colorIndex % COLOR_POOL.length]);
	            colorIndex++;
	        }

	        String[] splitDays = dayStr.split(",");
	        for (String d : splitDays) {
	            d = d.trim().toUpperCase();
	            if (!timetable.containsKey(d)) continue; // 잘못된 요일 무시
	            
	        	// 요일/시간대에 강의 매핑
	            timetable.get(d).put(time, lec);
	        }
	    }

	    return timetable;
	}
}