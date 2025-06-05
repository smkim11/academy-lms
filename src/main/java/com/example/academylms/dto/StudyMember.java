package com.example.academylms.dto;

import lombok.Data;

@Data
public class StudyMember {
	private int memberId;
	private int groupId;
	private int enrollmentId;
	private String lastUpdate;
}
