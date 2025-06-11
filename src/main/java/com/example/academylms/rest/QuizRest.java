package com.example.academylms.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.service.QuizService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class QuizRest {
	@Autowired QuizService quizService;
	
	// 객관식 주관식 체크
	@GetMapping("/questionType/{type}")
	public String questionType(@PathVariable String type) {
		if(type.equals("객관식")) {
			return "gek";
		}
		return "ju";
	}
	
}
