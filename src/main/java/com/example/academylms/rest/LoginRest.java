package com.example.academylms.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.service.LoginService;

@RestController
public class LoginRest {
	@Autowired LoginService loginService;
	
	// 이메일 일치 여부
	@PostMapping("/validateEmail")
	public String validateEmail(@RequestParam String id, @RequestParam String email) {
		if(loginService.validateEmail(id, email) == 1) {
			return "valid"; // 결과값이 있다면 valid 라는 문자를 리턴
		}
		
		return "novalid"; // 결과 값이 없으면 빈 문자열을 넘긴다.
		
	}
	
}
