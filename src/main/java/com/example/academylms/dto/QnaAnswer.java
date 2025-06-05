package com.example.academylms.dto;

import lombok.Data;

@Data
public class QnaAnswer {
	private int answerId;
	private int qnaId;
	private String answer;
	private String lastUpdate;
}
