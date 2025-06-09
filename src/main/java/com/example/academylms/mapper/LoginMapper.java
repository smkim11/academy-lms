package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.FindUserPassword;
import com.example.academylms.dto.User;
import com.example.academylms.dto.UserLogin;

@Mapper
public interface LoginMapper {
	User findByLoginInfo(UserLogin userLogin); // 로그인 정보 찾기

	User findById(Integer userId); // userId를 통해 모든 user 정보 불러오기

	String findPassword(FindUserPassword info); // 이메일과 id를 통해 임시비밀번호 패스워드 발급

	int updatePassword(UserLogin userLogin);
}
