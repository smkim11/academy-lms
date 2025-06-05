package com.example.academylms.dto;

import lombok.Data;

@Data
public class LectureMaterial {
	private int materialId;
	private int weekId;
	private String title;
	private String file_url;
	private String lastUpdate;
}
