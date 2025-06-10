package com.example.academylms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.academylms.dto.ChangePasswordForm;
import com.example.academylms.dto.MyPage;
import com.example.academylms.dto.User;
import com.example.academylms.service.LoginService;
import com.example.academylms.service.MyPageService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageController {
	@Autowired MyPageService myPageService;
	@Autowired LoginService loginService;
	@Autowired PasswordEncoder passwordEncoder;
	
	@GetMapping("/admin/myPage")
	public String myPage(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/admin/myPage";
	}
	
	@GetMapping("/admin/updateInfo")
	public String updateInfo(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/admin/updateInfo";
	}
	
	@PostMapping("/admin/updateInfo")
	public String updateInfo(MyPage myPage , HttpSession session) {
		int userId = (int) session.getAttribute("loginUserId");
		myPage.setUserId(userId);  // 로그인정보를 myPage 에 넣어 수정위치 find
		
		if(myPageService.updateInfoAdmin(myPage) == true) {
			log.info("변경성공");
		} else {
			log.info("변경실패");
		}
		
		return "redirect:/admin/myPage";
	}
	
	@GetMapping("/admin/createUser")
	public String createUser() {
		return "/admin/createUser";
	}
	
	@GetMapping("/admin/updatePw") // 비밀번호 변경 폼으로 이동 
	public String updatePw() {
		
		
		return "/admin/updatePw"; 
	}
	
	@PostMapping("/admin/updatePw") // 비밀번호 변경 처리
	public String updatePw(ChangePasswordForm changePassword,Model model,HttpSession session) {
	  Integer userId = (Integer)session.getAttribute("loginUserId");
		User user = loginService.findById(userId);
		
		// 1. 비밀번호 일치 확인
		boolean match = loginService.isPasswordMatch(changePassword.getCurrentPw(),user.getPassword());
		if(match == false) {
			model.addAttribute("error", "현재비밀번호가 일치하지 않습니다.");
			return "/admin/updatePw";
		}
		
		// 2. 새 비밀번호 확인
		if(!changePassword.getNewPw().equals(changePassword.getNewPwCheck())) {
			model.addAttribute("error", "새 비밀번호가 서로 다릅니다.");
			return "/admin/updatePw";
		}
		
		String hashedPw = passwordEncoder.encode(changePassword.getNewPw());  // 새 비밀번호 암호화
		if(loginService.updatePassword(userId, hashedPw) == 0) {
			model.addAttribute("error", "비밀번호 변경 오류.");
			return "/admin/updatePw";
		}
		
		
		return "/login";
		
	}
	
}
