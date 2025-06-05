package com.example.academylms.dto;

import lombok.Data;

@Data
public class LectureEnrollment {
	private int enrollmentId;
	private int studentId;
	private int lectureId;
	private int status;
	private String lastUpdate;
}
