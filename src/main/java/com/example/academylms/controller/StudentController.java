package com.example.academylms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.example.academylms.service.StudyGroupService;

import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {
	
	@Autowired StudentService studentService;
	@Autowired StudentMapper studentMapper;
	@Autowired StudyGroupService studyGroupService;
	
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

	    // Map<Integer, Integer> -> Map<String, Integer> 타입으로 변경
	    Map<Integer, Integer> groupMap = studyGroupService.getStudentGroupIdsByLectureId(lectureId);

	    List<Integer> groupIds = studyGroupService.getGroupIdsByLectureId(lectureId);

	    model.addAttribute("students", students);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("lectureId", lectureId);
	    model.addAttribute("searchWord", searchWord);
	    model.addAttribute("groupMap", groupMap);
	    model.addAttribute("groupIds", groupIds);

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

	    // study_group 매핑 리스트 조회
	    List<Map<String, Object>> studentGroupList = studyGroupService.getStudentGroupMappingByLectureId(lectureId);

	    // Map<Integer, Integer>로 변환 (studentId -> groupId)
	    Map<String, Integer> groupMap = new HashMap<>();
	    for (Map<String, Object> map : studentGroupList) {
	        Object studentId = map.get("studentId");
	        Object groupId = map.get("groupId");
	        if (studentId != null && groupId != null) {
	            groupMap.put(String.valueOf(studentId), (Integer) groupId);
	        }
	    }

	    model.addAttribute("students", students);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("lectureId", lectureId);
	    model.addAttribute("searchWord", searchWord);
	    model.addAttribute("groupMap", groupMap);
	    System.out.println("groupMap = " + groupMap);
	    return "/admin/studentList";
	}


	
	@GetMapping("/admin/addStudent")
	public String addStudent(@RequestParam int lectureId, Model model) {
	    model.addAttribute("lectureId", lectureId);
	    return "/admin/addStudent";
	}

	
	@PostMapping("/admin/addStudent")
	public String addStudent(
	        @RequestParam int lectureId,
	        @RequestParam String userLoginId,
	        Model model) {

	    // 1. 아이디로 user_id 조회
	    Integer userId = studentMapper.findUserIdByLoginId(userLoginId);

	    if (userId == null) {
	        model.addAttribute("error", "존재하지 않는 사용자입니다.");
	        model.addAttribute("lectureId", lectureId);  // lectureId를 JSP에 전달
	        return "/admin/addStudent";  // lectureId 포함하지 않고 고정 뷰 이름 반환
	    }

	    // 2. 이미 student 테이블에 등록되어 있는지 확인
	    Student existingStudent = studentMapper.findStudentById(userId);
	    if (existingStudent == null) {
	        Student student = new Student();
	        student.setStudentId(userId);
	        studentMapper.addStudent(student);
	    }

	    // 3. lecture_enrollment에 등록 여부 확인
	    boolean alreadyEnrolled = studentMapper.isAlreadyEnrolled(userId, lectureId);
	    if (alreadyEnrolled) {
	        model.addAttribute("error", "이미 해당 강의를 수강 중입니다.");
	        model.addAttribute("lectureId", lectureId);  // lectureId 다시 전달
	        return "/admin/addStudent";  // 동일 뷰 반환
	    }

	    // 4. 수강 등록
	    studentMapper.insertLectureEnrollment(userId, lectureId);

	    return "redirect:/admin/studentList/" + lectureId;
	}

	
	@DeleteMapping("/admin/students/{studentId}/lecture/{lectureId}")
	@ResponseBody
	public String deleteEnrollment(@PathVariable int studentId, @PathVariable int lectureId) {
	    studentService.deleteEnrollment(studentId, lectureId);
	    return "success";
	}
	
	@GetMapping("/admin/updateStudent/{studentId}")
	public String updateStudentForm(@PathVariable int studentId, @RequestParam int lectureId, Model model) {
	    Student student = studentMapper.findStudentById(studentId);
	    model.addAttribute("student", student);
	    model.addAttribute("lectureId", lectureId); 
	    return "/admin/updateStudent";
	}

	@PostMapping("/admin/updateStudent")
	public String updateStudent(@ModelAttribute Student student,
	                            @RequestParam int lectureId) {
	    studentMapper.updateStudent(student); // 이름, 이메일, 전화번호 수정
	    return "redirect:/admin/studentList/" + lectureId; // 해당 강의로 리다이렉트
	}
}
