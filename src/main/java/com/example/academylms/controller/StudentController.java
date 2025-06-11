package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Student;
import com.example.academylms.mapper.StudentMapper;
import com.example.academylms.service.StudentService;

@Controller
public class StudentController {
	
	@Autowired StudentService studentService;
	@Autowired StudentMapper studentMapper;
	
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
	
	@GetMapping("/admin/studentList/{lectureId}")
    public String adminStudentListByLecture(
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

        return "/admin/studentList"; // JSP 뷰 경로
    }
	
	@GetMapping("/admin/addStudent")
	public String addStudent(@RequestParam int lectureId, Model model) {
	    model.addAttribute("lectureId", lectureId);
	    return "/admin/addStudent";
	}

	
	@PostMapping("/admin/addStudent")
	public String addStudent(
	        @RequestParam int lectureId,
	        @RequestParam String name,
	        @RequestParam String userLoginId,
	        @RequestParam String email,
	        @RequestParam String phone,
	        Model model) {

	    // 1. 아이디로 user_id 조회
	    Integer userId = studentMapper.findUserIdByLoginId(userLoginId);

	    if (userId == null) {
	        model.addAttribute("error", "존재하지 않는 사용자입니다.");
	        return "/admin/addStudentForm";
	    }

	    // 2. 이미 student 테이블에 등록되어 있는지 확인
	    Student existingStudent = studentMapper.findStudentById(userId);
	    if (existingStudent == null) {
	        // 등록되지 않은 경우에만 insert
	        Student student = new Student();
	        student.setStudentId(userId);
	        student.setName(name);
	        student.setEmail(email);
	        student.setPhone(phone);
	        studentMapper.addStudent(student);
	    }

	    // 3. lecture_enrollment에 수강 등록 중복 체크
	    boolean alreadyEnrolled = studentMapper.isAlreadyEnrolled(userId, lectureId);
	    if (!alreadyEnrolled) {
	        studentMapper.insertLectureEnrollment(userId, lectureId);
	    } else {
	        model.addAttribute("error", "이미 해당 강의를 수강 중입니다.");
	    }

	    return "redirect:/admin/studentList/" + lectureId;
	}
	
	@DeleteMapping("/admin/students/{studentId}/lecture/{lectureId}")
	@ResponseBody
	public String deleteEnrollment(@PathVariable int studentId, @PathVariable int lectureId) {
	    studentService.deleteEnrollment(studentId, lectureId);
	    return "success";
	}
}
