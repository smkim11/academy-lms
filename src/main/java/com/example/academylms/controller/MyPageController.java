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
	
	@GetMapping("/admin/mypage")  //  관리자 마이페이지
	public String myPageByAdmin(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		 loginService.findById(userId);
		 model.addAttribute("myPage", myPage);
		 
		return "/admin/myPage";
	}
	
	@GetMapping("/instructor/mypage") // 강사 마이페이지
	public String myPageByInstructor(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/instructor/myPage";
	}
	
	@GetMapping("/student/mypage") // 학생 마이페이지
	public String myPageByStudent(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 try {
			    MyPage myPage = myPageService.getUserProfile(userId);
			    model.addAttribute("myPage", myPage);
			} catch (Exception e) {
			    e.printStackTrace(); // 로그 확인용
			    return "error/500"; // 에러 페이지로 이동
			}
 
		return "/student/myPage";
	}
	
	
	@GetMapping("/admin/updateInfo") // 관리자 개인정보 수정페이지 이동
	public String updateInfoByAdmin(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/admin/updateInfo";
	}
	
	@GetMapping("/instructor/updateInfo") // 강사 개인정보 수정페이지 이동
	public String updateInfoByInstructor(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/instructor/updateInfo";
	}
	
	@GetMapping("/student/updateInfo") // 학생 개인정보 수정페이지 이동
	public String updateInfoByStudent(Model model, HttpSession session) {
		 int userId = (int) session.getAttribute("loginUserId");  // 세션 값 호출
		 MyPage myPage = myPageService.getUserProfile(userId);
		
		 model.addAttribute("myPage", myPage);
		 
		return "/student/updateInfo";
	}
	
	
	@PostMapping("/admin/updateInfo") // 관리자 개인정보 수정
	public String updateInfoByAdmin(MyPage myPage , HttpSession session) {
		int userId = (int) session.getAttribute("loginUserId");
		myPage.setUserId(userId);  // 로그인정보를 myPage 에 넣어 수정위치 find
		
		if(myPageService.updateInfoAdmin(myPage) == true) {
			log.info("변경성공");
		} else {
			log.info("변경실패");
		}
		
		return "redirect:/admin/mypage";
	}
	
	@PostMapping("/instructor/updateInfo") // 강사 개인정보 수정
	public String updateInfoByInstructor(MyPage myPage , HttpSession session) {
		int userId = (int) session.getAttribute("loginUserId");
		myPage.setUserId(userId);  // 로그인정보를 myPage 에 넣어 수정위치 find
		
		if(myPageService.updateInfoInstructor(myPage) == true) {
			log.info("변경성공");
		} else {
			log.info("변경실패");
		}
		
		return "redirect:/instructor/mypage";
	}
	
	@PostMapping("/student/updateInfo") // 학생 개인정보 수정
	public String updateInfoByStudent(MyPage myPage , HttpSession session) {
		int userId = (int) session.getAttribute("loginUserId");
		myPage.setUserId(userId);  // 로그인정보를 myPage 에 넣어 수정위치 find
		
		if(myPageService.updateInfoStudent(myPage) == true) {
			log.info("변경성공");
		} else {
			log.info("변경실패");
		}
		
		return "redirect:/student/mypage";
	}

	
	@GetMapping("/admin/updatePw") // 관리자 비밀번호 변경 폼으로 이동 
	public String updatePwByAdmin() {
		return "/admin/updatePw"; 
	}
	
	@GetMapping("/instructor/updatePw") // 강사 비밀번호 변경 폼으로 이동 
	public String updatePwByInstructor() {
		return "/instructor/updatePw"; 
	}
	
	@GetMapping("/student/updatePw") // 학생 비밀번호 변경 폼으로 이동 
	public String updatePwByStudent() {
		return "/student/updatePw"; 
	}
	
	
	@PostMapping("/admin/updatePw") // 관리자 비밀번호 변경 처리
	public String updatePwByAdmin(ChangePasswordForm changePassword,Model model,HttpSession session) {
	  Integer userId = (Integer)session.getAttribute("loginUserId");
		User user = loginService.findById(userId); //  현재 세션의 user 정보를 가져옴. 
		
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
		
		
		return "redirect:/login";
		
	}
	
	
	@PostMapping("/instructor/updatePw") // 강사 비밀번호 변경 처리
	public String updatePwByInstructor(ChangePasswordForm changePassword,Model model,HttpSession session) {
	  Integer userId = (Integer)session.getAttribute("loginUserId");
		User user = loginService.findById(userId); //  현재 세션의 user 정보를 가져옴.
		
		// 1. 비밀번호 일치 확인
		boolean match = loginService.isPasswordMatch(changePassword.getCurrentPw(),user.getPassword());
		if(match == false) {
			model.addAttribute("error", "현재비밀번호가 일치하지 않습니다.");
			return "/instructor/updatePw";
		}
		
		// 2. 새 비밀번호 확인
		if(!changePassword.getNewPw().equals(changePassword.getNewPwCheck())) {
			model.addAttribute("error", "새 비밀번호가 서로 다릅니다.");
			return "/instructor/updatePw";
		}
		
		String hashedPw = passwordEncoder.encode(changePassword.getNewPw());  // 새 비밀번호 암호화
		if(loginService.updatePassword(userId, hashedPw) == 0) {
			model.addAttribute("error", "비밀번호 변경 오류.");
			return "/instructor/updatePw";
		}
		
		
		return "redirect:/login";
		
	}
	
	@PostMapping("/student/updatePw") // 학생 비밀번호 변경 처리
	public String updatePwByStudent(ChangePasswordForm changePassword,Model model,HttpSession session) {
	  Integer userId = (Integer)session.getAttribute("loginUserId");
		User user = loginService.findById(userId); //  현재 세션의 user 정보를 가져옴.
		
		// 1. 비밀번호 일치 확인
		boolean match = loginService.isPasswordMatch(changePassword.getCurrentPw(),user.getPassword());
		if(match == false) {
			model.addAttribute("error", "현재비밀번호가 일치하지 않습니다.");
			return "/student/updatePw";
		}
		
		// 2. 새 비밀번호 확인
		if(!changePassword.getNewPw().equals(changePassword.getNewPwCheck())) {
			model.addAttribute("error", "새 비밀번호가 서로 다릅니다.");
			return "/student/updatePw";
		}
		
		String hashedPw = passwordEncoder.encode(changePassword.getNewPw());  // 새 비밀번호 암호화
		if(loginService.updatePassword(userId, hashedPw) == 0) {
			model.addAttribute("error", "비밀번호 변경 오류.");
			return "/student/updatePw";
		}
		
		
		return "redirect:/login";
		
	}
	
}
