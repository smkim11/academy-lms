package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.User;

@Mapper
public interface LoginMapper {

	User findByLoginInfo(User user); // 로그인 정보 찾기

}
