package com.example.academylms.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.academylms.AcademyLmsApplication;
import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;
import com.example.academylms.mapper.LoginMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class LoginService {

    private final AcademyLmsApplication academyLmsApplication;
	@Autowired LoginMapper loginMapper;
	@Autowired JavaMailSender mailSender;
	@Autowired PasswordEncoder passwordEncoder;

    LoginService(AcademyLmsApplication academyLmsApplication) {
        this.academyLmsApplication = academyLmsApplication;
    }
	
	public User findByLoginInfo(UserLogin userLogin) { // 로그인 요청시 필요
		User user = loginMapper.findPasswordById(userLogin.getId());
		
		if(user == null ) {
			return null; // ID 존재 X
		}
		
		String password = user.getPassword(); // ID 의 PASSWORD
		String inputpassword =  userLogin.getPassword(); // 현재 입력한 패스워드
		boolean matched;
		
		if(password.startsWith("$2")) { // 데이터 베이스 안에 패스워드가 암호화 되어있다면
			 matched =  passwordEncoder.matches(userLogin.getPassword(), password);
		}else {
			 matched = password.equals(inputpassword);
		}
		
		if(matched) { 
			return user; // 로그인 성공
		} else {
			return null; // 로그인 실패
		}
		
		
	}

	public User findById(Integer userId) { // userId 를통해 userId 모든 정보 추출  
		return loginMapper.findById(userId); 
	}

	public boolean findPassword(FindUserPassword info) { // 이메일 발급 true이면 임시비밀번호 발급 false 일시에 일치정보 없음 비밀번호 발급 x
		
		/*
		 * String email = loginMapper.findPassword(info); // 이메일과 id 정보가 둘다 일치하는 이메일 찾기
		 * if(email == null || email.trim().isEmpty()) { // id와 이메일 입력을 통해 일치 정보 있는지 조회
		 * return false; }
		 */   // 임시 주석처리 필요없는 부분
		
		
		String randomPassword = UUID.randomUUID().toString().substring(0, 8).replace("-", "");  // 8글자의 랜덤 패스워드 생성
		UserLogin userLogin = new UserLogin();
		userLogin.setId(info.getId()); // id 값 받아오기  
		userLogin.setPassword(randomPassword);
		
	
		
		loginMapper.updatePassword(userLogin);  // 임시 비밀번호로 로그인 정보 변경 
			
		
		
		
		SimpleMailMessage  message = new SimpleMailMessage(); // SimpleMailMessage 생성
		
		message.setTo(info.getEmail());
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
		
	public boolean isPasswordMatch(String inputPw, String password) { // 비밀번호 일치 여부 비교
		if(password.startsWith("$2")) {
			return passwordEncoder.matches(inputPw, password); // bcryPt 암호화 일때
		} else {
			return inputPw.equals(password); // 평서문일때
		}
	}

	public int updatePassword(Integer userId, String hashedPw) { // 새로운 암호화된 비밀번호 저장
		UserLogin user = new UserLogin(); 
		user.setUserId(userId);
		user.setPassword(hashedPw);
		
		return loginMapper.updatePasswords(user);
	}

	public int validateEmail(String id, String email) { // 아이디 이메일 일치여부 확인
		
		return loginMapper.validateEmail(id, email);
		
	}

	
}
