package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizSubmission {
	private int submissionId;
	private int scoreId;
	private String answer;
	private int isCorrect;
	private String lastUpdate;
	
}
