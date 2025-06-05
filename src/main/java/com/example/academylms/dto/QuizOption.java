package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizOption {
	private int optionId;
	private int quizId;
	private String option;
	private String lastUpdate;
}
