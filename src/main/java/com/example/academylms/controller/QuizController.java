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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.academylms.dto.Lecture;
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
	public String quizList(Model model, HttpSession session
									  , @RequestParam(defaultValue = "1") int lectureId) {
		
		List<HashMap<String,Object>> list = 
				quizService.quizListByLectureId(lectureId,(int)(session.getAttribute("loginUserId")));
		
		// 현재 날짜/시간
		LocalDateTime now = LocalDateTime.now();
		
		// 역할 찾기
		String role = quizService.selectRoleByUserId((int)(session.getAttribute("loginUserId")));
		
		// 강의번호에 맞는 강의제목, 시간
		Lecture lectureInfo = quizService.selectTitleByLectureId(lectureId);
		
		model.addAttribute("lectureInfo",lectureInfo);
		model.addAttribute("lectureId",lectureId);
		model.addAttribute("quizList",list);
		model.addAttribute("now",now);
		
		if(role.equals("student")) {
			return "/student/quizList";
		}else if(role.equals("admin")) {
			return "/admin/quizList";
		}
		return "/instructor/quizList";
	}
	
	// 퀴즈 추가
	@GetMapping("/addQuiz")
	public String addQuiz(Model model,@RequestParam int lectureId
									 ,@RequestParam Integer week
									 ,@RequestParam(required = false) String startedAt
									 ,@RequestParam(required = false) String endedAt
									 ,@RequestParam(required = false) String source
									 ,@RequestParam(required = false) Integer currentPage
									 ,@RequestParam(defaultValue = "0") Integer quizNo) {
		if(startedAt != null && endedAt != null) {
			model.addAttribute("startedAt",startedAt);
			model.addAttribute("endedAt",endedAt);
		}
		
		// 문항 번호 자동증가
		quizNo += 1;
		
		// 리스트에서 퀴즈추가와 수정페이지에서 문항추가가 각각 이후 이동하는 페이지가 다르게 하기위해 source와 currentPage 넘김
		model.addAttribute("source",source);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("week",week);
		model.addAttribute("quizNo",quizNo);
		model.addAttribute("lectureId",lectureId);
		return "/instructor/addQuiz";
	}
	
	@PostMapping("/addQuiz")
	public String addQuiz(QuizForm quizForm, @RequestParam(required = false) String option1
											,@RequestParam(required = false) String option2
											,@RequestParam(required = false) String option3
											,@RequestParam(required = false) String option4
											,@RequestParam(required = false) String source
											,@RequestParam(required = false) Integer currentPage
											,RedirectAttributes redirectAttributes) {
		
		int wId = quizService.selectWeekId(quizForm.getLectureId(), quizForm.getWeek());
		
		// 퀴즈를 출제하는 주차에 이미있는 번호로 출제하면 오류
		if(quizService.findSameNo(wId, quizForm.getQuizNo()) != 0) {
			redirectAttributes.addFlashAttribute("msg", "번호를 변경해주세요.");
			redirectAttributes.addFlashAttribute("startedAt", quizForm.getStartedAt());
			redirectAttributes.addFlashAttribute("endedAt", quizForm.getEndedAt());
			redirectAttributes.addAttribute("week", quizForm.getWeek());
			redirectAttributes.addAttribute("lectureId", quizForm.getLectureId());
			redirectAttributes.addAttribute("quizNo", quizForm.getQuizNo());
			
			// 수정페이지에서 문항 추가중 오류가나면 source추가
			if("update".equals(source)) {
				redirectAttributes.addAttribute("source", "update");
				redirectAttributes.addAttribute("currentPage", currentPage);
			}
			return "redirect:/addQuiz";
		}
		
		// 퀴즈 추가
		quizService.insertQuiz(quizForm);
		
		// 객관식이면 보기까지 추가
		if(option1 != null && option2 != null && option3 != null && option4 != null) {
			quizService.insertQuizOption(quizForm, 1, option1);
			quizService.insertQuizOption(quizForm, 2, option2);
			quizService.insertQuizOption(quizForm, 3, option3);
			quizService.insertQuizOption(quizForm, 4, option4);
		}
		
		// 수정페이지에서 문항 추가시 수정페이지에서 방금추가한 문항으로 이동
		if("update".equals(source)) {
			redirectAttributes.addAttribute("weekId", wId);
			if(currentPage != null) {
				currentPage +=1;
				redirectAttributes.addAttribute("currentPage", currentPage);
			}else {
				redirectAttributes.addAttribute("currentPage", 1);
			}
			return "redirect:/updateQuiz";
		}
		
		// redirectAttributes 사용하여 return문 url단축
		redirectAttributes.addAttribute("lectureId", quizForm.getLectureId());
		redirectAttributes.addAttribute("week", quizForm.getWeek());
		redirectAttributes.addAttribute("startedAt", quizForm.getStartedAt());
		redirectAttributes.addAttribute("endedAt", quizForm.getEndedAt());
		redirectAttributes.addAttribute("quizNo", quizForm.getQuizNo());
		return "redirect:/addQuiz";
	}
	
	// 퀴즈 수정
	@GetMapping("/updateQuiz")
	public String updateQuiz(Model model, @RequestParam int weekId
										 ,@RequestParam(defaultValue = "1") int currentPage) {
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
		model.addAttribute("lectureId",quizService.selectLectureIdByweekId(weekId));
		model.addAttribute("week",quizService.selectWeekByWeekId(weekId));
		model.addAttribute("list",list);
		return "/instructor/updateQuiz";
	}
	
	@PostMapping("/updateQuiz")
	public String updateQuiz(QuizForm quizForm, @RequestParam(required = false) String option1
											  , @RequestParam(required = false) String option2
											  , @RequestParam(required = false) String option3
											  , @RequestParam(required = false) String option4
											  , @RequestParam(defaultValue = "1") int currentPage
											  , @RequestParam int weekId
											  , RedirectAttributes redirectAttributes) {
		log.info("option1:"+option1);
		log.info("option2:"+option2);
		log.info("option3:"+option3);
		log.info("option4:"+option4);
		// 퀴즈 수정
		quizService.updateQuiz(quizForm);
		
		// 기간 수정 시 동일주차 기간들도 변경
		quizService.updateQuizDate(quizForm);
		
		// 객관식이면 보기까지 수정
		if(option1 != null && option2 != null && option3 != null && option4 != null) {
			quizService.updateQuizOption(quizForm, 1, option1);
			quizService.updateQuizOption(quizForm, 2, option2);
			quizService.updateQuizOption(quizForm, 3, option3);
			quizService.updateQuizOption(quizForm, 4, option4);
		}
		
		// redirectAttributes 사용하여 return문 url단축
		redirectAttributes.addAttribute("weekId", weekId);
		redirectAttributes.addAttribute("currentPage", currentPage);
		return "redirect:/updateQuiz";
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
	public String quizOne(QuizSubmission quizSubmission,RedirectAttributes redirectAttributes
													   ,@RequestParam(defaultValue = "1") int currentPage
													   ,@RequestParam int weekId ,@RequestParam int joinId
													   ,@RequestParam String btn) {
		
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
			log.info("answer1:"+quizSubmission.getAnswer());
			
			// redirectAttributes 사용하여 return문 url단축
			redirectAttributes.addAttribute("weekId", weekId);
			redirectAttributes.addAttribute("currentPage", currentPage);
			return "redirect:/quizOne";
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
		
		// redirectAttributes 사용하여 return문 url단축
		redirectAttributes.addAttribute("weekId", weekId);
		redirectAttributes.addAttribute("joinId", joinId);
		return "redirect:/student/quizResult";
	}
	
	// 학생용 퀴즈 결과 페이지
	@GetMapping("/student/quizResult")
	public String studentQuizResult(Model model, HttpSession session
										, @RequestParam int weekId
										, @RequestParam int joinId) {
		List<HashMap<String,Object>> resultList = quizService.quizResultByJoinId(joinId);
		
		// 점수
		int score = (int)(resultList.get(0).get("score"));
		
		// weekId에 해당하는 lectureId
		int lId = quizService.selectLectureIdByweekId(weekId);
		
		model.addAttribute("score",score);
		model.addAttribute("resultList", resultList);
		model.addAttribute("lectureId",lId);
		model.addAttribute("week",quizService.selectWeekByWeekId(weekId));
		model.addAttribute("explainList", quizService.quizExplanation(weekId));
		return "/student/quizResult";
	}
	
	// 강사,관리자 퀴즈 결과 페이지
	@GetMapping("/quizResult")
	public String instructorQuizResult(Model model, HttpSession session
												   ,@RequestParam int weekId
									  			   ,@RequestParam int lectureId
									  			   ,@RequestParam(required = false) String status) {
		// 강의에 수강중인 전체학생 ID
		List<HashMap<String,Object>> list1 = quizService.selectQuizStatus(lectureId);
		
		// 시험에 응시한 학생정보
		List<HashMap<String,Object>> list2 = quizService.selectSubmissionStudent(weekId);
		
		// 수강중인 전체학생 리스트에서 응시한 학생은 응시완료, 점수가 리스트에 추가
		for(HashMap<String,Object> map1 : list1) {
			for(HashMap<String,Object> map2 : list2) {
				if(map1.get("studentId").toString()
						.equals(map2.get("studentId").toString())) {
					map1.put("status", "응시완료");
					map1.put("score", map2.get("score"));
				}
			}
		}
		
		// 퀴즈가 응시중이면 현황으로 끝났으면 결과 반환
		if(status != null) {
			model.addAttribute("status","결과");
		}else {
			model.addAttribute("status","현황");
		}
		
		// 역할 찾기
		String role = quizService.selectRoleByUserId((int)(session.getAttribute("loginUserId")));
		
		model.addAttribute("list",list1);
		model.addAttribute("lectureId",lectureId);
		model.addAttribute("week",quizService.selectWeekByWeekId(weekId));
		if(role.equals("admin")) {
			return "/admin/quizResult";
		}
		return "/instructor/quizResult";
	}
	
	// 퀴즈 전체삭제
	@GetMapping("/deleteQuiz")
	public String deleteQuiz(RedirectAttributes redirectAttributes, @RequestParam int weekId
																  , @RequestParam int lectureId) {
		
		// 객관식이 있으면 객관식에 해당하는 quizId 출력
		List<Integer> list = quizService.selectQuizIdByWeekIdType(weekId);
		
		// 객관식이 있으면 보기들 먼저 삭제 후 문제전체 삭제
		if(!list.isEmpty()) {
			for(int qId : list) {
				quizService.deleteQuizOption(qId);
			}
		}
		
		// 퀴즈 전체 삭제
		quizService.deleteQuiz(weekId);
		
		redirectAttributes.addAttribute("lectureId", lectureId);
		return "redirect:/quizList";
	}
	
	// 퀴즈 한문제 삭제
	@GetMapping("/deleteQuizOne")
	public String deleteQuizOne(RedirectAttributes redirectAttributes,@RequestParam int weekId
																	 ,@RequestParam int currentPage
																	 ,@RequestParam int quizId) {
		// 객관식이 있으면 객관식에 해당하는 quizId 출력
		List<Integer> list = quizService.selectQuizIdByWeekIdType(weekId);
		
		// 삭제하는 문제가 객관식이면 보기먼저 삭제 후 문제 삭제
		if(!list.isEmpty()) {
			for(int qId : list) {
				if(qId == quizId) {
					quizService.deleteQuizOption(qId);
					break;
				}
			}
		}
		
		// 퀴즈 한문제 삭제(한 페이지에 한 문제씩이라 quizNo == currentPage)
		quizService.deleteQuizOne(weekId, currentPage);
		
		// 삭제된 문제 뒤에나오는 문제들의 quizId
		List<Integer> list2 = quizService.selectQuizIdByQuizNoWeekId(currentPage, weekId);
		
		// 삭제하는 문제가 마지막 문제가 아니라면 이후에 나오는 문제들 번호 -1씩
		if(!list2.isEmpty()) {
			for(int qId2 : list2) {
				quizService.updateQuizNo(qId2);
			}
			redirectAttributes.addAttribute("weekId", weekId);
			redirectAttributes.addAttribute("currentPage", currentPage);
			return "redirect:/updateQuiz";
		}
		
		// 마지막문제면 이전페이지로 리다이렉트
		currentPage -= 1;
		redirectAttributes.addAttribute("weekId", weekId);
		redirectAttributes.addAttribute("currentPage", currentPage);
		return "redirect:/updateQuiz";
	}
}
