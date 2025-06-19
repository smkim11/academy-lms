package com.example.academylms.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.LectureWeekMaterial;
import com.example.academylms.dto.Notice;
import com.example.academylms.dto.QnaList;
import com.example.academylms.dto.QuizWeekList;
import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.dto.StudyPostList;
import com.example.academylms.service.LectureService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LectureController {

@Autowired LectureService lectureService;
	
	@GetMapping("/admin/createLecture")  // 관리자 강의 개설페이지로 이동
	public String createLecture(HttpSession session, Model model) {
		int adminId  = (int) session.getAttribute("loginUserId");
		List<InstructorInfo> info = lectureService.findInstructorInfo();
		
		
		model.addAttribute("adminId", adminId);
		model.addAttribute("instructorList",info);
		
		return "/admin/createLecture";
	}
	
	@PostMapping("/admin/createLecture") // 관리자 강의 개설완료
	public String createLecture(Lecture lecture , Model model){
			lecture.setDayList(Arrays.asList(lecture.getDay().split(",")));	
			if(lectureService.isScheduleConflict(lecture) == false) {
				 model.addAttribute("message", "해당 시간과 요일에 이미 강의가 존재합니다. 다른 시간이나 요일을 선택해주세요.");
				 model.addAttribute("redirectUrl", "/admin/createLecture");
				 return "/common/alert";
			}
		
			if(lectureService.createLecture(lecture) == false) {
				log.info("강의생성에 실패했습니다.");
				return "redirect:/admin/createLecture";
			}

			
		
		return "redirect:/mainPage";
	}
	
	@GetMapping("/admin/lectureOne") // 관리자 강의 상세정보 
	public String lectureOneByAdmin(@RequestParam int lectureId, Model model) {
	  Lecture lecture = lectureService.lectureOneBylectureId(lectureId);  // lectureId 로 강의 정보 가져오기
	  List<LectureWeekMaterial> lectureWeekMaterial = lectureService.lectureOneWeekList(lectureId); // 강의자료 5주차까지 출력
	  List<Notice> lectureNoticeList = lectureService.lectureOneNoticeList(lectureId); // 공지사항 가져오기
	  List<QuizWeekList> quizList = lectureService.lectureOneQuizList(lectureId); // quiz 리스트 가져오기
	  List<QnaList> qnaList = lectureService.lectureOneQnaList(lectureId); // qna 리스트 가져오기
	  List<StudyPostList> postList = lectureService.lectureOneStduyGroupList(lectureId); // 스터디 그룹 리스트 가져오기
	  
	  Map<Integer, List<LectureWeekMaterial>> weekMaterialMap = new HashMap<>();
	  for (LectureWeekMaterial m : lectureWeekMaterial) { // 강의주차 가지고 옴.
		  int week = m.getWeek();
		  weekMaterialMap.computeIfAbsent(week , k  -> new ArrayList<>())
		  .add(m);
		  
	  }
	  
	 
	 
	  
	  LocalDateTime now = LocalDateTime.now();
	  
	  model.addAttribute("lecture", lecture);
	  model.addAttribute("lectureNoticeList", lectureNoticeList);
	  model.addAttribute("now", now);
	  model.addAttribute("weekMaterialMap", weekMaterialMap);
	  model.addAttribute("quizList", quizList);
	  model.addAttribute("qnaList", qnaList);
	  model.addAttribute("postList", postList);
	  model.addAttribute("lectureId", lectureId);
	  
	  return "/admin/lectureOne";
	}
	
	@GetMapping("/instructor/lectureOne") // 강사 강의 상세정보
	public String lectureOneByInstructor(@RequestParam int lectureId, Model model) {
		Lecture lecture = lectureService.lectureOneBylectureId(lectureId);  // lectureId 로 강의 정보 가져오기
		  List<LectureWeekMaterial> lectureWeekMaterial = lectureService.lectureOneWeekList(lectureId); // 강의자료 5주차까지 출력
		  List<Notice> lectureNoticeList = lectureService.lectureOneNoticeList(lectureId); // 공지사항 가져오기
		  List<QuizWeekList> quizList = lectureService.lectureOneQuizList(lectureId); // quiz 리스트 가져오기
		  List<QnaList> qnaList = lectureService.lectureOneQnaList(lectureId); // qna 리스트 가져오기
		  List<StudyPostList> postList = lectureService.lectureOneStduyGroupList(lectureId); // 스터디 그룹 리스트 가져오기
		  
		  Map<Integer, List<LectureWeekMaterial>> weekMaterialMap = new HashMap<>();
		  for (LectureWeekMaterial m : lectureWeekMaterial) { // 강의주차 가지고 옴.
			  int week = m.getWeek();
			  weekMaterialMap.computeIfAbsent(week , k  -> new ArrayList<>())
			  .add(m);
			  
		  }
		  
		  LocalDateTime now = LocalDateTime.now();
		  
		  model.addAttribute("lecture", lecture);
		  model.addAttribute("lectureNoticeList", lectureNoticeList);
		  model.addAttribute("now", now);
		  model.addAttribute("weekMaterialMap", weekMaterialMap);
		  model.addAttribute("quizList", quizList);
		  model.addAttribute("qnaList", qnaList);
		  model.addAttribute("postList", postList);
		  model.addAttribute("lectureId", lectureId);
		
		return "/instructor/lectureOne";
	}
	
	@GetMapping("/student/lectureOne")  // 학생 강의 상세정보
	public String lectureOneByStudent(@RequestParam int lectureId, Model model) {
		Lecture lecture = lectureService.lectureOneBylectureId(lectureId);  // lectureId 로 강의 정보 가져오기
		  List<LectureWeekMaterial> lectureWeekMaterial = lectureService.lectureOneWeekList(lectureId); // 강의자료 5주차까지 출력
		  List<Notice> lectureNoticeList = lectureService.lectureOneNoticeList(lectureId); // 공지사항 가져오기
		  List<QuizWeekList> quizList = lectureService.lectureOneQuizList(lectureId); // quiz 리스트 가져오기
		  List<QnaList> qnaList = lectureService.lectureOneQnaList(lectureId); // qna 리스트 가져오기
		  List<StudyPostList> postList = lectureService.lectureOneStduyGroupList(lectureId); // 스터디그룹 리스트 가져오기
		  
		  Map<Integer, List<LectureWeekMaterial>> weekMaterialMap = new HashMap<>();
		  for (LectureWeekMaterial m : lectureWeekMaterial) { // 강의주차 가지고 옴.
			  int week = m.getWeek();
			  weekMaterialMap.computeIfAbsent(week , k  -> new ArrayList<>())
			  .add(m);
			  
		  }
		  
		  LocalDateTime now = LocalDateTime.now();
		  
		  model.addAttribute("lecture", lecture);
		  model.addAttribute("lectureNoticeList", lectureNoticeList);
		  model.addAttribute("now", now);
		  model.addAttribute("weekMaterialMap", weekMaterialMap);
		  model.addAttribute("quizList", quizList);
		  model.addAttribute("qnaList", qnaList);
		  model.addAttribute("postList", postList);
		  model.addAttribute("lectureId", lectureId);
		  
		return "/student/lectureOne";
	}
	
	@GetMapping("/admin/updateLecture")  // 관리자 강의 수정 페이지 이동
	public String updateLecture(@RequestParam int lectureId, Model model, HttpSession session) {
		
		log.info("lectureId 값확인:"+ lectureId);
		
		
		
		Lecture lecture = lectureService.lectureOneBylectureId(lectureId);
		List<InstructorInfo> info = lectureService.findInstructorInfo(); // 강사정보 찾아옴.
		
		
		lecture.setStartedAtFormatted(lecture.getStartedAt().substring(0, 10));
		lecture.setEndedAtFormatted(lecture.getEndedAt().substring(0, 10));
		
		int adminId  = (int) session.getAttribute("loginUserId");
		
		model.addAttribute("lecture", lecture);
		model.addAttribute("adminId", adminId);
		model.addAttribute("instructorList", info);
		
		return "/admin/updateLecture";
	}
	
	@PostMapping("/admin/updateLecture") // 관리자 강의 페이지 이동
	public String updateLecture(Lecture lecture , Model model) {
		
		lecture.setDayList(Arrays.asList(lecture.getDay().split(",")));	
		if(lectureService.isScheduleConflict(lecture) == false) { //  해당 시간 요일에 강의 존재 여부
			 model.addAttribute("message", "해당 시간과 요일에 이미 강의가 존재합니다. 다른 시간이나 요일을 선택해주세요.");
			 model.addAttribute("redirectUrl", "/admin/createLecture");
			 return "/common/alert";
		}
		
		if(lectureService.updateLecture(lecture) == true) {
			log.info("업데이트 성공");
			return "redirect:/mainPage";
		} else if(lectureService.updateLecture(lecture) == false) {
			log.info("업데이트 실패");
			return "redirect:/mainPage";
		} else {
			log.info("예외발생 ");
			
			return "redirect:/mainPage";
		}
	}
	
	@GetMapping("/admin/lectureDelete") // 강의 삭제
	public String deleteLecture(@RequestParam int lectureId) {
		if(lectureService.deleteLecture(lectureId) != 0) {
			log.info("강의 삭제");
			return  "redirect:/mainPage";
		}
			log.info("강의 삭제 x");
			return "redirect:/admin/lectureOne?lectureId="+lectureId;
	}
	
	
}
