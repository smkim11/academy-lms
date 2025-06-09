package com.example.academylms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SurveyController {

	@GetMapping("/student/survey")
	public String survey() {
		return "/student/survey";
	}
}
