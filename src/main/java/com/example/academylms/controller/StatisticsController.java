package com.example.academylms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StatisticsController {
	
	// 통계 페이지
	@GetMapping("/statistics")
	public String statistics() {
		return "/admin/statistics";
	}
}
