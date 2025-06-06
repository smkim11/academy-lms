package com.example.academylms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.User;
import com.example.academylms.service.LoginService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired LoginService loginService;
	
	@GetMapping({"/login"})
	public String loginForm(){
		return "/login";  //  로그인 홈페이지로 이동
	}
	
	@PostMapping("/loginForm")
	public String loginForm(HttpSession session,
			@RequestParam(value = "id") String id, @RequestParam(value = "password") String password ){
		User user = new User();  //  user  객체 생성
		user.setId(id);          
		user.setPassword(password);  // user 객체 아이디 비밀번호 설정
		
		User user2 = loginService.findByLoginInfo(user); // 아이디와 비밀번호를 통해 user 정보 조회
		
		if(user2 == null) { // 정보가 없다면 Login 화면 이동
			log.info("로그인 실패");
			return "redirect:/login";
		}
		
		session.setAttribute("loginUserId", user2.getUserId());
		
		if(user2.getRole().equals("student") ) { // 로그인한 user 역할이 학생일 경우
			return "redirect:/student/mainPage";
		} else if(user2.getRole().equals("instructor")) { // 로그인한 user 역할이 강사일경우
			return "redirect:/instructor/mainPage"; 
		} else if(user2.getRole().equals("admin")) { // 로그인한 user 역할이 관리자일 경우
			return "redirect:/admin/mainPage";
		}
		
		return "redirect:/login" ;
		
		
	}	
	
}
