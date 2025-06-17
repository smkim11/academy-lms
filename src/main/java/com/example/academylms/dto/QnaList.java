package com.example.academylms.dto;

import lombok.Data;

@Data
public class QnaList {
	private int  qnaId;
	private String title;
	private int isPublic;
	private String createDate;
	private String writerName;
	
}
