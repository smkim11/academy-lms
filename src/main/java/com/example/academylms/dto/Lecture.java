package com.example.academylms.dto;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

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
	private String createDate;
	private String name; // dto에만 받을 내용
	private int week;  // dto에만 받을 내용
	private String major; // dto에만 받을 내용
	private String startedAtFormatted; // 날짜형태로 포맷
	private String endedAtFormatted; // 날짜형태로 포맷
	private List<String> dayList; // 요일을 리스트 형태로 저장 중복값 확인
}
