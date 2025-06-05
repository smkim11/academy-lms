package com.example.academylms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.User;
import com.example.academylms.mapper.LoginMapper;

@Service
public class LoginService {
	
	@Autowired LoginMapper loginMapper; 
	
	public User findByLoginInfo(User user) {
		User userLogin = new User(); // User 의 값을 받기 위해 체크
		
		userLogin = loginMapper.findByLoginInfo(user); 
		return userLogin;
		
	}

	
}
