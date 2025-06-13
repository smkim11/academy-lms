package com.example.academylms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.SatisfactionSurvey;
import com.example.academylms.service.SurveyService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SurveyController {
	@Autowired SurveyService surveyService; 
	
	@GetMapping("/student/survey") // 만족도조사 하는 페이지로 이동
	public String survey(@RequestParam int lectureId ,HttpSession session , Model model) {
	 int studentId = (int)session.getAttribute("loginUserId");  // 로그인된 StudentId 가져옴.
	 
	 int enrollmentId = surveyService.getEnrollmentId(lectureId, studentId);
	 
	 
	 model.addAttribute("enrollmentId", enrollmentId);
	 	
		
	 return "/student/survey";
	}
	
	@PostMapping("/student/survey") // 만족도 조사 동작
	public String survey(SatisfactionSurvey survey) {
		
		surveyService.addSatisfactionSurvey(survey);
		
		
		return "";
	}
	
	
	@GetMapping("/admin/surveyResult")
	public String surveyResult() {
		
		
		return "/admin/surveyResult";
	}
}
