package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;

@Mapper
public interface LoginMapper {
	User findByLoginInfo(UserLogin userLogin); // 로그인 정보 찾기

	User findById(Integer userId); // userId를 통해 모든 user 정보 불러오기
	
	User findPasswordById(String id); // 아이디를 통해 맞는 비밀번호를 일단 가져온뒤에 비교해야함.
	
	String findPassword(FindUserPassword info); // 이메일과 id를 통해 일치하는 이메일 조회

	int updatePassword(UserLogin userLogin);  // id로 값을 판단후 비밀번호 업데이트

	int updatePasswords(UserLogin user); // 비밀번호 수정떄 사용 비밀번호 업데이트 User_id로 값을 판단해 넣는다.
 
	int validateEmail(@Param ("id") String id, @Param ("email") String email); // 아이디 이메일 일치여부

	String findNameByuserId(int userId);  // user 이름값 받기
	
	
}
