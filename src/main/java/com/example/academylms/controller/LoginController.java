package com.example.academylms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;
import com.example.academylms.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired LoginService loginService;
	
	@GetMapping({"/login"}) // 로그인 홈페이지 이동
	public String loginForm(){
		return "/login";  //  로그인 홈페이지로 이동
	}
	
	@PostMapping("/loginForm") // 로그인 처리 진행
	public String loginForm(HttpSession session,
		UserLogin userLogin){  // dto로 값을 받아 처리
	
		
		User user2 = loginService.findByLoginInfo(userLogin); // 아이디와 비밀번호를 통해 user 정보 조회
		
		if(user2 == null) { // 정보가 없다면 Login 화면 이동
			log.info("로그인 실패");
			return "redirect:/login";
		}
		log.info("userId = {}", user2.getUserId());
		session.setAttribute("loginUserId", user2.getUserId());
		
		if(user2.getRole().equals("student") ) { // 로그인한 user 역할이 학생일 경우
			return "redirect:/student/survey";
		} else if(user2.getRole().equals("instructor")) { // 로그인한 user 역할이 강사일경우
			return "redirect:/instructor/mainPage"; 
		} else if(user2.getRole().equals("admin")) { // 로그인한 user 역할이 관리자일 경우
			return "redirect:/admin/mainPage";
		}
		
		return "redirect:/login" ;
		
		
	}	
	
	@GetMapping("/logOut") // 로그아웃시 세션 초기화
	public String logOut(HttpSession session) {
		session.invalidate(); // 모든 세션 속성 제거
		return "redirect:/login";  
	}
	
	@GetMapping("/findPassword") // findPw로 이동
	public String findPassword() {
		return "findPw";
	}
	
	@PostMapping("/findPassword") // 임시비밀번호 발급
	public String findPassword(FindUserPassword info) {
		loginService.findPassword(info);
		
		return "redirect:/login";
	}
}
