package com.example.academylms.dto;

import lombok.Data;

@Data
public class SatisfactionSurvey {
	private int surveyId;
	private int enrollmentId;
	private int rating;
	private String comment;
	private String lastUpdate;
}
