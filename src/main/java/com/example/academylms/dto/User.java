package com.example.academylms.dto;

import lombok.Data;

@Data
public class User {
	private int userId;
	private String id;
	private String password;
	private String birth;
	private String role;
	private String lastUpdate;
}
