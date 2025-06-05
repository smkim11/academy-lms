package com.example.academylms.dto;

import lombok.Data;

@Data
public class Lecture {
	private int lectureId;
	private int adminId;
	private int instructorId;
	private String title;
	private String description;
	private String day;
	private String time;
	private String startedAt;
	private String endedAt;
	private String lastUpdate;
}
