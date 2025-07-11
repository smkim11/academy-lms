package com.example.academylms.controller;

import java.lang.ProcessBuilder.Redirect;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;
import com.example.academylms.service.LoginService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
	@Autowired LoginService loginService;
	
	@GetMapping({"/login"}) // 로그인 홈페이지 이동
	public String loginForm(){
		return "/login";  //  로그인 홈페이지로 이동
	}
	
	@PostMapping("/login") // 로그인 처리 진행
	public String loginForm( @Valid @ModelAttribute("userLogin")UserLogin userLogin , 
		BindingResult bindingResult, HttpSession session, 
		 RedirectAttributes redirectAttributes){  // dto로 값을 받아 처리
	
		if(bindingResult.hasErrors()) {
			redirectAttributes.addFlashAttribute("errorMessage", "입력값을 다시 확인해주세요.");
		}
		
		
		User user2 = loginService.findByLoginInfo(userLogin); // 아이디와 비밀번호를 통해 user 정보 조회
		
		
		if(user2 == null) { // 정보가 없다면 Login 화면 이동
			log.info("로그인 실패");
			redirectAttributes.addFlashAttribute("errorMessage", "로그인에 실패하였습니다.");
			return "redirect:/login";
		}
		log.info("userId = {}", user2.getUserId());
		String name = loginService.findNameByuserId(user2.getUserId()); 
		log.info("name:"+name);
		session.setAttribute("name", name);
		session.setAttribute("loginUserId", user2.getUserId());
		session.setAttribute("userRole", user2.getRole()); // 역할 세션을 추가로 만듬
		return "redirect:/mainPage";
		
		
		
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
	public String findPassword(@Valid @ModelAttribute("info") FindUserPassword info ,BindingResult bindingResult,
			Model model) {
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("errors", bindingResult);
		}
		
		loginService.findPassword(info);
		
		return "redirect:/login";
	}
}
