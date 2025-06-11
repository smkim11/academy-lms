package com.example.academylms.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.service.LectureService;

@RestController
public class LectureRest {
	@Autowired LectureService lectureService;
	
	@GetMapping("/admin/getMajor")
	public String getMajor(@RequestParam int instructorId) {
		
	 String major = lectureService.findInstructorInfoByinfoId(instructorId);
	 System.out.println("instructorId: " + instructorId +"major:"+ major);
		return major;
	}
	
	
}
