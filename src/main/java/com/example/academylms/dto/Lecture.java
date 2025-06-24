package com.example.academylms.dto;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import io.micrometer.common.lang.NonNull;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class Lecture {
	private int lectureId;
	private int adminId;
	
	@NotNull(message = "강사는 필수입니다.")
	private Integer instructorId;
	
	@NotBlank(message = "과목이름은 필수입니다.")
	private String title;
	
	private String description;
	
	@NotBlank(message = "요일 입력은 필수입니다.")
	private String day;
	
	@NotBlank(message = "시간 입력은 필수입니다.")
	private String time;
	
	@NotBlank(message = "시작 날짜 입력은 필수입니다.")
	private String startedAt;
	
	@NotBlank(message = "종료 날짜 입력은 필수입니다.")
	private String endedAt;
	private String createDate;
	private String name; // dto에만 받을 내용
	private int week;  // dto에만 받을 내용
	private String major; // dto에만 받을 내용
	private String startedAtFormatted; // 날짜형태로 포맷
	private String endedAtFormatted; // 날짜형태로 포맷
	private List<String> dayList; // 요일을 리스트 형태로 저장 중복값 확인
}
