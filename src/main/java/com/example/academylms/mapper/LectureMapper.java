package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;

@Mapper
public interface LectureMapper {
	List<Lecture> findLecturesByInstructor(int instructorId);
	Lecture selectLectureById(int lectureId);
	List<InstructorInfo> findInstructorInfo(); // 강사정보 조회 
	String findInstructorInfoByinfoId(int instructorId); // 전공정보 조회
	int createLecture(Lecture lecture); // 강의 개설
	int createLectureWeek(@Param("lectureId")int lectureId, @Param("week") int week); // 강의 주차 개설
	Lecture lectureOneBylectureId(int lectureId); // lectureId 로 강의 정보 조회
	int deleteLectureWeek(int lectureId); // lectureId로 강의 정보 삭제
	int updateLecture(Lecture lecture); // 강의 업데이트 
	

}
