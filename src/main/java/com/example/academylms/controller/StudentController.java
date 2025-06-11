package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Student;
import com.example.academylms.mapper.StudentMapper;
import com.example.academylms.service.StudentService;

@Controller
public class StudentController {
	
	@Autowired StudentService studentService;
	
	@GetMapping("/instructor/studentList/{lectureId}")
	public String studentListByLecture(
	        @PathVariable int lectureId,
	        @RequestParam(name = "page", defaultValue = "1") int currentPage,
	        @RequestParam(name = "searchWord", required = false) String searchWord,
	        Model model) {

	    int rowPerPage = 10;
	    int totalCount = studentService.getStudentsCountByLecture(lectureId, searchWord);
	    int beginRow = (currentPage - 1) * rowPerPage;

	    List<Student> students = studentService.getStudentsByLecture(lectureId, beginRow, rowPerPage, searchWord);
	    int totalPage = (totalCount + rowPerPage - 1) / rowPerPage;

	    model.addAttribute("students", students);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("lectureId", lectureId);
	    model.addAttribute("searchWord", searchWord);

	    return "/instructor/studentList";
	}
	
	@GetMapping("/admin/studentList")
	public String adminStudentList(
			@RequestParam(name = "page", defaultValue = "1") int currentPage,
			@RequestParam(name = "searchWord", required = false) String searchWord,
			Model model) {
		
		int rowPerPage = 10;

		// 전체 학생 수
		int totalCount = studentService.getStudentCount(searchWord);

		// Page 객체 생성 (검색어 유무에 따라 생성자 선택)
		Page page;
		if (searchWord != null && !searchWord.isEmpty()) {
			page = new Page(currentPage, rowPerPage, totalCount, searchWord);
		} else {
			page = new Page(currentPage, rowPerPage, totalCount);
		}

		// 학생 목록 조회
		List<Student> students = studentService.getStudentList(page);

		// JSP에 데이터 전달
		model.addAttribute("students", students);
		model.addAttribute("page", page);

		return "/admin/studentList";
	}
	
	@GetMapping("/admin/addStudent")
	public String addStudent() {
		return "/admin/addStudent";
	}
	
}
