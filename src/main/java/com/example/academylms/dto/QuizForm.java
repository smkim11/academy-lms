package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizForm {
	private int quizNo;
	private int week;
	private int lectureId;
	private String question;
	private String correctAnswer;
	private String explanation;
	private String type;
	private String startedAt;
	private String endedAt;
}
