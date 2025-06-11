package com.example.academylms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.MyPage;
import com.example.academylms.mapper.MyPageMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyPageService {

	@Autowired MyPageMapper myPageMapper;
	
	
	public MyPage getUserProfile(int userId) { // 마이페이지 개인정보 조회
		return myPageMapper.getUserProfile(userId);
		
		
	}


	public boolean updateInfoAdmin(MyPage myPage) { // 관리자 개인정보 수정  
		if(myPageMapper.updateInfoAdmin(myPage) == 1) {
			log.info("변경성공");
			return true;
		};
		return false;
	}
	
	public boolean updateInfoInstructor(MyPage myPage) { // 강사 개인정보 수정  
		if(myPageMapper.updateInfoInstructor(myPage) == 1) {
			log.info("변경성공");
			return true;
		};
		return false;
	}
	
	public boolean updateInfoStudent(MyPage myPage) { // 학생 개인정보 수정  
		if(myPageMapper.updateInfoStudent(myPage) == 1) {
			log.info("변경성공");
			return true;
		};
		return false;
	}

}
