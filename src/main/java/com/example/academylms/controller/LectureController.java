package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
		
		return "redirect:/admin/myPage";
	}
	
}
