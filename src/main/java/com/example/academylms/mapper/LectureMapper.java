package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;

@Mapper
public interface LectureMapper {
	List<Lecture> findLecturesByInstructor(int instructorId);
	Lecture selectLectureById(int lectureId);
	List<InstructorInfo> findInstructorInfo(); // 강사정보 조회 
	String findInstructorInfoByinfoId(int instructorId); // 전공정보 조회
}
