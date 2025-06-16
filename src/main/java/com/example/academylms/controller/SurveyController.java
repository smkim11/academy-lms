package com.example.academylms.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.Page;
import com.example.academylms.dto.SatisfactionSurvey;
import com.example.academylms.service.LectureService;
import com.example.academylms.service.SurveyService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SurveyController {
	@Autowired SurveyService surveyService; 
	@Autowired LectureService lectureService;
	
	@GetMapping("/student/survey") // 만족도조사 하는 페이지로 이동
	public String survey(@RequestParam int lectureId ,HttpSession session , Model model) {
	 int studentId = (int)session.getAttribute("loginUserId");  // 로그인된 StudentId 가져옴.
	 
	 int enrollmentId = surveyService.getEnrollmentId(lectureId, studentId); // 학생 강의 등록정보 기본키 조회
	 if(surveyService.checkSurveyParticipation(enrollmentId) != 0) { // 등록정보 기본키로 참여 여부 조회
		 model.addAttribute("message", "만족도 조사에 이미 참여하셨습니다!");
		 model.addAttribute("redirectUrl", "/mainPage");
		 
		 return "/common/alert";
	 }
	 
	 model.addAttribute("enrollmentId", enrollmentId);
	 	
		
	 return "/student/survey";
	}
	
	@PostMapping("/student/survey") // 만족도 조사 동작
	public String survey(SatisfactionSurvey survey) {
		
		if(surveyService.addSatisfactionSurvey(survey)!= 0) {
			log.info("만족도 조사 추가완료");
		}
		
		
		return "redirect:/mainPage";
	}
	
	
	@GetMapping("/admin/surveyResult")
	public String surveyResult(@RequestParam int lectureId, 
		@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "8") int size,
		Model model) {
		
		double surveyAvg = surveyService.surveyAvgResult(lectureId); // 설문평균
		int totalCount = surveyService.countSurveys(lectureId); // 전체 설문 갯수 가지고 오기
		
		
		Page page = new Page(currentPage, size, totalCount);
		List<SatisfactionSurvey> surveyList = surveyService.getSurveyPage(lectureId, page); //  설문 리스트
		
		Lecture lecture = lectureService.lectureOneBylectureId(lectureId);
		
		
		String startedAtStr = lecture.getStartedAt().substring(0, 10); // "2024-06-01"
		String endedAtStr = lecture.getEndedAt().substring(0, 10);

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDate = LocalDate.parse(startedAtStr, formatter);
		LocalDate endDate = LocalDate.parse(endedAtStr, formatter);

		
		
		
	
		model.addAttribute("surveyAvg", surveyAvg != 0.00 ? String.format("%.2f", surveyAvg): "0.00");
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("surveyList", surveyList);
		model.addAttribute("lectureId", lectureId);
		model.addAttribute("totalPages", page.getLastPage());
		model.addAttribute("size", size);
		model.addAttribute("lecture",lecture);
		model.addAttribute("endDate", endDate);
		model.addAttribute("startDate", startDate);
		return "/admin/surveyResult";
	}
}
