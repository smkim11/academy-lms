package com.example.academylms.dto;

import lombok.Data;

@Data
public class Notice {
	private int noticeId;
	private int lectureId;
	private String noticeType;
	private String title;
	private String content;
	private String lastUpdate;
}
