package com.example.academylms.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.service.QuizService;

import jakarta.servlet.http.HttpSession;

@Controller
public class QuizController {
	@Autowired QuizService quizService;
	
	// 강의별 퀴즈 리스트
	@GetMapping("/quizList")
	public String quizList(Model model, @RequestParam(defaultValue = "1") int lectureId) {
		
		List<HashMap<String,Object>> list = quizService.quizListByLectureId(lectureId);
		
		// 현재 날짜/시간
		LocalDateTime now = LocalDateTime.now();
		
		model.addAttribute("lectureId",lectureId);
		model.addAttribute("quizList",list);
		model.addAttribute("now",now);
		return "/student/quizList";
	}
	
	// 퀴즈 추가
	@GetMapping("/addQuiz")
	public String addQuiz(Model model, @RequestParam(defaultValue = "1") int lectureId) {
		model.addAttribute("lectureId",lectureId);
		return "/instructor/addQuiz";
	}
	
	@PostMapping("/addQuiz")
	public String addQuiz() {
		return "";
	}
	
	// 퀴즈 응시 페이지
	@GetMapping("/quizOne")
	public String quizOne(Model model, HttpSession session
						,@RequestParam(defaultValue = "1") int currentPage
						,@RequestParam int weekId) {
		// weekId에 해당하는 lectureId
		int lId = quizService.selectLectureIdByweekId(weekId);
		
		// 로그인한 학생이 접속한 강의의 enrollmentId
		int eId = quizService.selectEnrollmentId((int)(session.getAttribute("loginUserId")), lId);
		
		// 응시 기록이 없으면 quiz_join테이블에 기록 추가
		if(quizService.selectJoinId(weekId, eId)==null) {
			quizService.insertJoinId(weekId, eId);
		}
		
		// 한페이지에 문제하나씩 나오도록 페이징
		Page page = new Page(currentPage, 1, quizService.quizTotalCount(weekId));
		
		// 퀴즈 문제 출력
		List<HashMap<String,Object>> list = quizService.quizOne(page, weekId);
		
		// 퀴즈 보기 가져오기
		if (!list.isEmpty()) {
	        HashMap<String, Object> quiz = list.get(0);
	        int quizId = (int) quiz.get("quizId");

	        List<QuizOption> options = quizService.quizOptionList(quizId);
	        model.addAttribute("options", options);
	    }
		
		model.addAttribute("p",page);
		model.addAttribute("weekId",weekId);
		model.addAttribute("list",list);
		return "/student/quizOne";
	}
	
	@PostMapping("/quizOne")
	public String quizOne(@RequestParam(defaultValue = "1") int currentPage
						,@RequestParam int weekId) {
		return "redirect:/quizOne?weekId="+weekId+"&currentPage="+currentPage;
	}
}
