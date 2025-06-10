package com.example.academylms.dto;

import lombok.Data;

@Data
public class ChangePasswordForm {
	
	private String currentPw;
	private String newPw;
	private String newPwCheck;
	private int userId;
}
