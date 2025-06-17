package com.example.academylms.dto;

import lombok.Data;

@Data
public class StudyPostList {
	private int postId;
	private int groupId;
	private String title;
	private String content;
	private String feedback;
	private String createDate;
	private String id;
}
