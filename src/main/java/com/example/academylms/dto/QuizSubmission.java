package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizSubmission {
	private int submissionId;
	private int joinId;
	private String answer;
	private int isCorrect;
	private String lastUpdate;
	
}
