package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.MyPage;

@Mapper
public interface MyPageMapper {

	MyPage getUserProfile(int userId); // 마이페이지 개인정보 조회

	int updateInfoAdmin(MyPage myPage); // 관리자 개인정보 수정
 
	int updateInfoInstructor(MyPage myPage); // 강사 개인정보 수정
	
	int updateInfoStudent(MyPage myPage); // 학생 개인정보 수정

}
