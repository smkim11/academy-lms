package com.example.academylms.dto;

import lombok.Data;

@Data
public class QuizWeekList { // 강의 상세정보에 노출
	private int weekId;
	private int week;
	private String startedAt;
	private String endedAt;
}
