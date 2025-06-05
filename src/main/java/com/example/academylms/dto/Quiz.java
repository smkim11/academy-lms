package com.example.academylms.dto;

import lombok.Data;

@Data
public class Quiz {
	private int quizId;
	private int weekId;
	private String question;
	private String correctAnswer;
	private String explanation;
	private String type;
	private String startedAt;
	private String endedAt;
	private String lastUpdate;
}
