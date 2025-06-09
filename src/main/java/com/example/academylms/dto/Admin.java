package com.example.academylms.dto;

import lombok.Data;

@Data
public class Admin {
	private int adminId;
	private String name;
	private String email;
	private String phone;
	private String createDate;
}
