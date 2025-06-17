package com.example.academylms.dto;

import lombok.Data;

@Data
public class LectureWeekMaterial {
	private int week;
	private int weekId;
	private int materialId;
	private String title;
	private String fileUrl;
	private String createDate;
}
