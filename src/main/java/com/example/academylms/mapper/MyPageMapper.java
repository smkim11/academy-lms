package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.MyPage;

@Mapper
public interface MyPageMapper {

	MyPage getUserProfile(int userId);

	int updateInfoAdmin(MyPage myPage);

}
