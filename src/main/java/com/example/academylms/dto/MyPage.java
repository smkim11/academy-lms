package com.example.academylms.dto;

import lombok.Data;

@Data
public class MyPage { //  개인정보 바꾸는 dto
	private String name;
	private String email;
	private String phone;
	private String birth;
	private int userId;
}
