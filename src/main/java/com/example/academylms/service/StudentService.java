package com.example.academylms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Student;
import com.example.academylms.mapper.StudentMapper;
import com.example.academylms.mapper.StudyGroupMapper;

@Service
public class StudentService {
	private final StudentMapper studentMapper;
	
	@Autowired
	private StudyGroupMapper studyGroupMapper;


	public StudentService(StudentMapper studentMapper) {
		this.studentMapper = studentMapper;
	}

	public List<Student> getStudentList(Page page) {
		return studentMapper.selectStudentList(page);
	}
	
	public List<Student> getStudentsByLecture(int lectureId, int beginRow, int rowPerPage, String searchWord) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("lectureId", lectureId);
	    param.put("beginRow", beginRow);
	    param.put("rowPerPage", rowPerPage);
	    param.put("searchWord", searchWord);
	    return studentMapper.selectStudentsByLecture(param);
	}

	public int getStudentsCountByLecture(int lectureId, String searchWord) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("lectureId", lectureId);
	    param.put("searchWord", searchWord);
	    return studentMapper.selectStudentsCountByLecture(param);
	}

	public int getStudentCount(String searchWord) {
		return studentMapper.selectStudentCount(searchWord);
	}
	
	public int addStudent(Student student) {
        return studentMapper.addStudent(student);
    }
	
	public void deleteEnrollment(int studentId, int lectureId) {
		
		studyGroupMapper.deleteStudyMembersByStudentAndLecture(studentId, lectureId);
	    studentMapper.deleteStudent(studentId, lectureId);
	}
}
