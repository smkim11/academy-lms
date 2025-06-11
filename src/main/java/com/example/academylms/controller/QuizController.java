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
import com.example.academylms.dto.QuizForm;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.dto.QuizSubmission;
import com.example.academylms.service.QuizService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QuizController {
	@Autowired QuizService quizService;
	
	// 강의별 퀴즈 리스트
	@GetMapping("/quizList")
	public String quizList(Model model, @RequestParam(defaultValue = "1") int lectureId
						  ,HttpSession session) {
		
		List<HashMap<String,Object>> list = 
				quizService.quizListByLectureId(lectureId,(int)(session.getAttribute("loginUserId")));
		
		// 현재 날짜/시간
		LocalDateTime now = LocalDateTime.now();
		
		// 역할 찾기
		String role = quizService.selectRoleByUserId((int)(session.getAttribute("loginUserId")));
		
		model.addAttribute("lectureId",lectureId);
		model.addAttribute("quizList",list);
		model.addAttribute("now",now);
		
		if(role.equals("student")) {
			return "/student/quizList";
		}
		return "/instructor/quizList";
	}
	
	// 퀴즈 추가
	@GetMapping("/addQuiz")
	public String addQuiz(Model model, @RequestParam(defaultValue = "1") int lectureId) {
		model.addAttribute("lectureId",lectureId);
		return "/instructor/addQuiz";
	}
	
	@PostMapping("/addQuiz")
	public String addQuiz(@RequestParam int lectureId, QuizForm quizForm) {
		quizService.insertQuiz(quizForm);
		return "redirect:/quizList?lectureId="+lectureId;
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
		Integer jId = quizService.selectJoinId(weekId, eId);
		if(jId == null) {
			quizService.insertJoinId(weekId, eId);
			jId = quizService.selectJoinId(weekId, eId);
		}
		log.info("joinId:"+jId);
		
		// 한페이지에 문제하나씩 나오도록 페이징
		Page page = new Page(currentPage, 1, quizService.quizTotalCount(weekId));
		
		// 퀴즈 문제 출력
		List<HashMap<String,Object>> list = quizService.quizOne(page, weekId);
		
		// 퀴즈 보기 가져오기
		if (!list.isEmpty()) {
	        HashMap<String, Object> quiz = list.get(0);
	        int quizId = (int) quiz.get("quizId");
	        int quizNo = (int) quiz.get("quizNo");
	        
	        List<QuizOption> options = quizService.quizOptionList(quizId);
	        model.addAttribute("options", options);
	        
	        // 제출한 답이 있으면 보여준다
	        String answer = quizService.selectAnswer(jId, quizNo);
	        log.info("quizNo:"+quizNo);
	        log.info("answer:"+answer);
	        model.addAttribute("answer", answer);
	    }
		
		model.addAttribute("p",page);
		model.addAttribute("weekId",weekId);
		model.addAttribute("joinId",jId);
		model.addAttribute("list",list);
		return "/student/quizOne";
	}
	
	@PostMapping("/quizOne")
	public String quizOne(@RequestParam(defaultValue = "1") int currentPage
						,@RequestParam int weekId
						,@RequestParam int joinId
						,@RequestParam String btn
						,QuizSubmission quizSubmission) {
		
		// 답안 제출이력 확인
		Integer sId = quizService.findSubmissionId(quizSubmission);
		log.info("submissionId:"+sId);
		log.info("btn:"+btn);
		
		// 저장버튼 클릭시
		if(btn.equals("save")) {
			// 답안을 처음등록하면 insert 등록한 기록이 있다면 update
			if(sId == null) {
				// 답안 등록
				quizService.insertQuizAnswer(quizSubmission);
			}else {
				// 답안 수정
				quizService.updateQuizAnswer(quizSubmission.getAnswer(), sId);
			}
			
			// 답안 확인(정답이면 isCorrect=1, 오답이면 isCorrect=0)
			quizService.updateIsCorrect(joinId);
			// 저장버튼 누르면 다음문제 이동
			currentPage+=1;
			return "redirect:/quizOne?weekId="+weekId+"&currentPage="+currentPage;
		}
		
		
		
		// 제출버튼 클릭시
		// 답안을 처음등록하면 insert 등록한 기록이 있다면 update
		if(sId == null) {
			// 답안 등록
			quizService.insertQuizAnswer(quizSubmission);
		}else {
			// 답안 수정
			quizService.updateQuizAnswer(quizSubmission.getAnswer(), sId);
		}
		
		// 답안 확인(정답이면 isCorrect=1, 오답이면 isCorrect=0)
		quizService.updateIsCorrect(joinId);
		
		// 문항개수
		int totalQuestion = quizService.countQuizByWeekId(weekId);
		log.info("문항개수:"+totalQuestion);
		
		// 정답개수
		int correctQuestion = quizService.countCorrectQuizByJoinId(joinId);
		log.info("정답개수:"+correctQuestion);
		
		// 점수 등록
		quizService.updateScore(correctQuestion, totalQuestion, joinId);
		return "redirect:/quizResult?weekId="+weekId+"&joinId="+joinId;
	}
	
	// 퀴즈 결과 페이지
	@GetMapping("/quizResult")
	public String quizResult(Model model, @RequestParam int weekId
										, @RequestParam int joinId) {
		List<HashMap<String,Object>> resultList = quizService.quizResultByJoinId(joinId);
		
		// 점수
		int score = (int)(resultList.get(0).get("score"));
		
		// weekId에 해당하는 lectureId
		int lId = quizService.selectLectureIdByweekId(weekId);
		
		model.addAttribute("score",score);
		model.addAttribute("resultList", resultList);
		model.addAttribute("lectureId",lId);
		model.addAttribute("explainList", quizService.quizExplanation(weekId));
		return "/student/quizResult";
	}
}
