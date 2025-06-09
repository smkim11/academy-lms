package com.example.academylms.dto;

import lombok.Data;

@Data
public class Instructor {
	private int instructorId;
	private String name;
	private String email;
	private String phone;
	private String major;
	private String createDate;
}
