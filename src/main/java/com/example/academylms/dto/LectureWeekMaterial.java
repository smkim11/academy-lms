package com.example.academylms.dto;

import lombok.Data;

@Data
public class LectureWeekMaterial {  // 파일 상세정보 보기에 사용
	private int week;
	private int weekId;
	private int materialId;
	private String title;
	private String fileUrl;
	private String createDate;
}
