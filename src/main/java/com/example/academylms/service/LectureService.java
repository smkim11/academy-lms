package com.example.academylms.service;

import java.util.List;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;

public interface LectureService {
    List<Lecture> getLecturesByInstructor(int instructorId);
    Lecture getLectureById(int lectureId);
	
    List<InstructorInfo> findInstructorInfo();
    String findInstructorInfoByinfoId(int instructorId);
	boolean createLecture(Lecture lecture);
	Lecture lectureOneBylectureId(int lectureId);
	boolean updateLecture(Lecture lecture);
	int deleteLecture(int lectureId); 
}