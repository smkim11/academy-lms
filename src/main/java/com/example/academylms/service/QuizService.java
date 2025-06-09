package com.example.academylms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.mapper.QuizMapper;

@Service
@Transactional
public class QuizService {
	@Autowired QuizMapper quizMapper;
	
	// 강의별 퀴즈 리스트
	public List<HashMap<String,Object>> quizListByLectureId(int lectureId){
		
		return quizMapper.quizListByLectureId(lectureId);
	}
	
	// 퀴즈 문제풀이 페이지
	public List<HashMap<String,Object>> quizOne(Page page, int weekId){
		return quizMapper.quizOne(page, weekId);
	}
	
	// (강의,주차)별 퀴즈 전체 문제수
	public int quizTotalCount(int weekId) {
		return quizMapper.quizTotalCount(weekId);
	}
	
	// 퀴즈(객관식) 보기
	public List<QuizOption> quizOptionList(int quizId) {
		return quizMapper.quizOptionList(quizId);
	}
	
	// 퀴즈 응시기록 확인
	public Integer selectJoinId(int weekId, int enrollmentId) {
		return quizMapper.selectJoinId(weekId, enrollmentId);
	}
	
	// 퀴즈 응시기록 확인
	public int selectEnrollmentId(int studentId, int lectureId) {
		return quizMapper.selectEnrollmentId(studentId, lectureId);
	}
	
	// weekId에 해당하는 lectureId 반환
	public int selectLectureIdByweekId(int weekId) {
		return quizMapper.selectLectureIdByweekId(weekId);
	}
	
	// join_id등록
	public void insertJoinId(int weekId, int enrollmentId) {
		quizMapper.insertJoinId(weekId, enrollmentId);
	}
}
