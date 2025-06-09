package com.example.academylms.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;
import com.example.academylms.mapper.LoginMapper;

@Transactional
@Service
public class LoginService {
	@Autowired LoginMapper loginMapper;
	@Autowired JavaMailSender mailSender;
	
	public User findByLoginInfo(UserLogin userLogin2) {
		User userLogin = new User(); //  로그인정보를 받기 위해 정보가 있는지 체크
		
		userLogin = loginMapper.findByLoginInfo(userLogin2); 
		return userLogin;
		
	}

	public User findById(Integer userId) { // userId 를통해 userId 모든 정보 추출  
		
		
		return loginMapper.findById(userId); 
	}

	public boolean findPassword(FindUserPassword info) { // true이면 임시비밀번호 발급 false 일시에 일치정보 없음 비밀번호 발급 x
		
		String email =  loginMapper.findPassword(info); 
		if(email == null || email.trim().isEmpty()) { //  id와 이메일 입력을 통해 일치 정보 있는지 조회
			return false;
		}
		
		String randomPassword = UUID.randomUUID().toString().substring(0, 8).replace("-", "");  // 8글자의 랜덤 패스워드 생성
		UserLogin userLogin = new UserLogin();
		userLogin.setId(info.getId()); // id 값 받아오기  
		userLogin.setPassword(randomPassword);
		
		loginMapper.updatePassword(userLogin);  // 임시 비밀번호로 로그인 정보 변경 
			
		
		
		
		SimpleMailMessage  message = new SimpleMailMessage(); // SimpleMailMessage 생성
		
		message.setTo(email);
		message.setSubject("oo어학원 임시비밀번호 안내입니다.");
		message.setText("임시비밀번호는"+randomPassword+"입니다. \n"
						+ "	로그인 이후에 비밀번호를 변경하세요.");
		
		try {
			mailSender.send(message);
		} catch (Exception e) {
			System.err.println("메일 전송 실패:" + e.getMessage());
			return false;
		}
	
		 
		return true;
	}

	
}
