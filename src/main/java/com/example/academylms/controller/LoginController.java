package com.example.academylms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.User;
import com.example.academylms.service.LoginService;


@Controller
public class LoginController {
	@Autowired LoginService loginService;
	
	@GetMapping({"login" ,"/"})
	public String loginForm(){
		return "/login";  //  로그인 홈페이지로 이동
	}
	
	@PostMapping("/loginForm")
	public String loginFrom(@RequestParam(value = "id") String id, @RequestParam(value = "password") String password ){
		User user = new User();  //  user  객체 생성
		user.setId(id);          
		user.setPassword(password);  // user 객체 아이디 비밀번호 설정
		
		loginService.findByLoginInfo(user);
		
		return " ";
	}
	
}
