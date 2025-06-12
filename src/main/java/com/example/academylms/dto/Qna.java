package com.example.academylms.dto;

import lombok.Data;

@Data
public class Qna {
	private int qnaId;
	private int enrollmentId;
	private String title;
	private String question;
	private int isPublic;
	private String fileUrl;
	private String createDate;
}
