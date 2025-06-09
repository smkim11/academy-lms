package com.example.academylms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {

	@GetMapping("/admin/myPage")
	public String myPage() {
		return "/admin/myPage";
	}
	
}
