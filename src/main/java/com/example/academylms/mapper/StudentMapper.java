package com.example.academylms.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Student;

@Mapper
public interface StudentMapper {
	List<Student> selectStudentList(Page page);
	int selectStudentCount(String searchWord);
	int addStudent(Student student);
	int updateStudent(Student student);
	int deleteStudent(@Param("studentId") int studentId, @Param("lectureId") int lectureId);
	List<Student> selectStudentsByLecture(Map<String, Object> params);
	int selectStudentsCountByLecture(Map<String, Object> param);
	Integer findUserIdByLoginId(String userLoginId); 
	Student findStudentById(int studentId);
	boolean isAlreadyEnrolled(@Param("studentId") int studentId, @Param("lectureId") int lectureId);
	void insertLectureEnrollment(@Param("studentId") int studentId, @Param("lectureId") int lectureId);

}
