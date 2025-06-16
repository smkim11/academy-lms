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

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;
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
		model.addAttribute("instructorList", info);
		
		return "/admin/createLecture";
	}
	
	@PostMapping("/admin/createLecture") // 관리자 강의 개설완료
	public String createLecture(Lecture lecture){
			if(lectureService.createLecture(lecture) == false) {
				log.info("강의생성에 실패했습니다.");
				return "redirect:/admin/createLecture";
				
			}
		
		return "redirect:/admin/mypage";
	}
	
	@GetMapping("/admin/lectureOne") // 관리자 강의 상세정보 
	public String lectureOneByAdmin(@RequestParam int lectureId, Model model) {
	  Lecture lecture = lectureService.lectureOneBylectureId(lectureId);  // lectureId 로 강의 정보 가져오기
	  
	  LocalDateTime now = LocalDateTime.now();
	  
	  model.addAttribute("lecture", lecture);
	  model.addAttribute("now", now);
	  
	  return "/admin/lectureOne";
	}
	
	@GetMapping("/instructor/lectureOne") // 강사 강의 상세정보
	public String lectureOneByInstructor(@RequestParam int lectureId, Model model) {
	  Lecture lecture = lectureService.lectureOneBylectureId(lectureId);  // lectureId 로 강의 정보 가져오기
	  				    lectureService.NoticeListBylectureId(lectureId);
	  
	  
	  model.addAttribute("lecture", lecture);
	  
		
		return "/instructor/lectureOne";
	}
	
	@GetMapping("/student/lectureOne")  // 학생 강의 상세정보
	public String lectureOneByStudent() {
		return "";
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
	public String updateLecture(Lecture lecture) {
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
