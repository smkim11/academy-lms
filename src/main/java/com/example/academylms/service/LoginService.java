package com.example.academylms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.User;
import com.example.academylms.mapper.LoginMapper;

@Service
public class LoginService {
	
	@Autowired LoginMapper loginMapper; 
	
	public User findByLoginInfo(User user) {
		User userLogin = new User(); //  로그인정보를 받기 위해 정보가 있는지 체크
		
		userLogin = loginMapper.findByLoginInfo(user); 
		return userLogin;
		
	}

	public User findById(Integer userId) { // userId 를통해 userId 모든 정보 추출  
		
		
		return loginMapper.findById(userId); 
	}

	
}
