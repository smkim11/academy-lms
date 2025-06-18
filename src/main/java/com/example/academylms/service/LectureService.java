package com.example.academylms.service;

import java.util.List;

import com.example.academylms.dto.QuizWeekList;
import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.dto.StudyPostList;
import com.example.academylms.dto.QnaList;
import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.LectureWeekMaterial;
import com.example.academylms.dto.Notice;

public interface LectureService {
    List<Lecture> getLecturesByInstructor(int instructorId);
    Lecture getLectureById(int lectureId);
	
    List<InstructorInfo> findInstructorInfo();
    String findInstructorInfoByinfoId(int instructorId);
	boolean createLecture(Lecture lecture);
	Lecture lectureOneBylectureId(int lectureId);
	boolean updateLecture(Lecture lecture);
	int deleteLecture(int lectureId);
	List<LectureWeekMaterial> lectureOneWeekList(int lectureId);
	List<Notice> lectureOneNoticeList(int lectureId);
	List<QuizWeekList> lectureOneQuizList(int lectureId);
	List<QnaList> lectureOneQnaList(int lectureId);
	List<StudyPostList> lectureOneStduyGroupList(int lectureId);
	boolean isScheduleConflict(Lecture lecture); 
}