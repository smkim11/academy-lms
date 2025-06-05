package com.example.academylms.dto;

import lombok.Data;

@Data
public class Student {
	private int studentId;
	private String name;
	private String email;
	private String phone;
	private String lastUpdate;
}
