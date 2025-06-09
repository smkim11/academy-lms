package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizJoin {
	private int joinId;
	private int weekId;
	private int enrollmentId;
	private int score;
	private String createDate;
}
