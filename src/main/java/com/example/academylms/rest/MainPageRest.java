package com.example.academylms.rest;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.service.MainPageService;

@RestController
@RequestMapping("/api/mainPage")
public class MainPageRest {

    @Autowired
    private MainPageService mainPageService;

    // 역할별 강의 목록 (전체)
    @GetMapping("/lectures")
    public List<Map<String, Object>> getLecturesByRole(@RequestParam int userId, @RequestParam String role) {
        return switch (role) {
            case "admin" -> mainPageService.getAllLectures();
            case "instructor" -> mainPageService.getLecturesByInstructor(userId);
            case "student" -> mainPageService.getLecturesByStudent(userId);
            default -> Collections.emptyList();
        };
    }

    // 현재 수강중인 강의만 반환
    @GetMapping("/ongoingLectures")
    public List<Map<String, Object>> getOngoingLectures(@RequestParam int userId, @RequestParam String role) {
        return "instructor".equals(role)
                ? mainPageService.getOngoingLecturesForInstructor(userId)
                : mainPageService.getOngoingLecturesForStudent(userId);
    }

    // 강의 상태별 분류 (진행/예정/종료)
    @GetMapping("/lectures/classified")
    public Map<String, List<Map<String, Object>>> getClassifiedLectures(@RequestParam int userId, @RequestParam String role) {
        List<Map<String, Object>> lectures = getLecturesByRole(userId, role);
        LocalDateTime now = LocalDateTime.now();

        Map<String, List<Map<String, Object>>> result = new HashMap<>();
        result.put("ongoing", new ArrayList<>());
        result.put("upcoming", new ArrayList<>());
        result.put("ended", new ArrayList<>());

        for (Map<String, Object> lec : lectures) {
            LocalDateTime start = (LocalDateTime) lec.get("started_at");
            LocalDateTime end = (LocalDateTime) lec.get("ended_at");

            if (now.isBefore(start)) result.get("upcoming").add(lec);
            else if (now.isAfter(end)) result.get("ended").add(lec);
            else result.get("ongoing").add(lec);
        }

        return result;
    }

    // 시간표 생성 (요일/시간대 + 색상)
    @GetMapping("/timetable")
    public Map<String, Object> getTimetable(@RequestParam int userId, @RequestParam String role) {
        List<Map<String, Object>> lectures = getOngoingLectures(userId, role);
        Map<Integer, String> colorMap = new HashMap<>();
        Map<String, Map<String, Object>> timetable = new LinkedHashMap<>();
        String[] days = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
        String[] times = {"MORNING", "AFTERNOON", "EVENING"};
        String[] colors = {"#FFCCCC", "#CCE5FF", "#CCFFCC", "#FFF5CC", "#E0CCFF", "#FFD9E6", "#B3E6CC", "#E6CCB3", "#D1E0E0", "#F0C9A9"};

        for (String d : days) {
            timetable.put(d, new LinkedHashMap<>());
            for (String t : times) {
                timetable.get(d).put(t, null);
            }
        }

        int colorIndex = 0;
        for (Map<String, Object> lec : lectures) {
            String dayStr = String.valueOf(lec.get("day")).replace("\"", "");
            String time = String.valueOf(lec.get("time")).replace("\"", "");
            Integer lectureId = (Integer) lec.get("lecture_id");
            if (dayStr == null || time == null || lectureId == null) continue;

            if (!colorMap.containsKey(lectureId)) {
                colorMap.put(lectureId, colors[colorIndex % colors.length]);
                colorIndex++;
            }

            for (String d : dayStr.split(",")) {
                String day = d.trim().toUpperCase();
                if (timetable.containsKey(day)) {
                    timetable.get(day).put(time, lec);
                }
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("timetable", timetable);
        result.put("lectureColorMap", colorMap);
        return result;
    }
}