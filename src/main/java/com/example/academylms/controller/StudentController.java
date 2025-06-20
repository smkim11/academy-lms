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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Student;
import com.example.academylms.dto.StudyGroup;
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

	    // 학생 ID → 그룹 ID
	    Map<Integer, Integer> groupMap = studyGroupService.getStudentGroupIdsByLectureId(lectureId);

	    // 그룹 리스트 (groupId, groupName 포함)
	    List<StudyGroup> groups = studyGroupService.getGroupsWithNamesByLectureId(lectureId);

	    // 그룹 ID → 그룹 이름
	    Map<Integer, String> groupNameMap = new HashMap<>();
	    for (StudyGroup group : groups) {
	        groupNameMap.put(group.getGroupId(), group.getGroupName());
	    }

	    model.addAttribute("students", students);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("lectureId", lectureId);
	    model.addAttribute("searchWord", searchWord);
	    model.addAttribute("groupMap", groupMap);
	    model.addAttribute("groupNameMap", groupNameMap);
	    model.addAttribute("groups", groups);

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

	    // 1. 수강생 목록
	    List<Student> students = studentService.getStudentsByLecture(lectureId, beginRow, rowPerPage, searchWord);
	    int totalPage = (totalCount + rowPerPage - 1) / rowPerPage;

	    // 2. 학생별 그룹 매핑 정보 (studentId → groupId)
	    Map<Integer, Integer> groupMap = studyGroupService.getStudentGroupIdsByLectureId(lectureId);

	    // 3. 그룹 전체 정보 가져오기 (groupId, groupName 포함)
	    List<StudyGroup> groups = studyGroupService.getGroupsWithNamesByLectureId(lectureId);

	    // 4. 그룹 ID → 그룹 이름 매핑
	    Map<Integer, String> groupNameMap = new HashMap<>();
	    for (StudyGroup group : groups) {
	        groupNameMap.put(group.getGroupId(), group.getGroupName());
	    }

	    // 5. 모델에 담기
	    model.addAttribute("students", students);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("lectureId", lectureId);
	    model.addAttribute("searchWord", searchWord);

	    model.addAttribute("groupMap", groupMap);             // studentId → groupId
	    model.addAttribute("groupNameMap", groupNameMap);     // groupId → groupName
	    model.addAttribute("groups", groups);                 // group 리스트

	    return "/admin/studentList";
	}




	
	@GetMapping("/admin/addStudent")
	public String adminAllStudentList(
			@RequestParam int lectureId,
	        @RequestParam(name = "page", defaultValue = "1") int currentPage,
	        @RequestParam(name = "searchWord", required = false) String searchWord,
	        Model model) {

	    int rowPerPage = 10;
	    int totalCount = studentService.getStudentCount(searchWord);
	    int totalPage = (totalCount + rowPerPage - 1) / rowPerPage;

	    // Page 객체 생성
	    Page page = (searchWord == null || searchWord.isEmpty())
	            ? new Page(currentPage, rowPerPage, totalCount)
	            : new Page(currentPage, rowPerPage, totalCount, searchWord);

	    List<Student> students = studentService.getStudentList(page);

	    // 페이징 범위 계산
	    int pageSize = 10;
	    int startPage = ((currentPage - 1) / pageSize) * pageSize + 1;
	    int endPage = Math.min(startPage + pageSize - 1, page.getLastPage());
	    boolean hasPrevious = startPage > 1;
	    boolean hasNext = endPage < page.getLastPage();

	    model.addAttribute("students", students);
	    model.addAttribute("page", page);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("hasPrevious", hasPrevious);
	    model.addAttribute("hasNext", hasNext);
	    model.addAttribute("previousPage", startPage - 1);
	    model.addAttribute("nextPage", endPage + 1);
	    model.addAttribute("searchWord", searchWord);
	    model.addAttribute("lectureId", lectureId);

	    return "/admin/addStudent";
	}


	
	@PostMapping("/admin/addStudent")
	public String addStudent(
	        @RequestParam int studentId,
	        @RequestParam int lectureId,
	        RedirectAttributes redirectAttributes) {

	    // 수강 여부 확인
	    boolean alreadyEnrolled = studentMapper.isAlreadyEnrolled(studentId, lectureId);
	    if (alreadyEnrolled) {
	        redirectAttributes.addFlashAttribute("error", "이미 해당 강의를 수강 중입니다.");
	        return "redirect:/admin/addStudent?lectureId=" + lectureId;
	    }

	    // 수강 등록
	    studentMapper.insertLectureEnrollment(studentId, lectureId);
	    redirectAttributes.addFlashAttribute("success", "수강 등록이 완료되었습니다.");
	    return "redirect:/admin/addStudent?lectureId=" + lectureId;
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
