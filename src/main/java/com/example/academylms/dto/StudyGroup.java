package com.example.academylms.dto;

import lombok.Data;

@Data
public class StudyGroup {
	private int groupId;
	private int lectureId;
	private int studentId;
	private String createDate;
}
