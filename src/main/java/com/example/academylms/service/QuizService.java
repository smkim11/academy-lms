package com.example.academylms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.Page;
import com.example.academylms.dto.Quiz;
import com.example.academylms.dto.QuizForm;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.dto.QuizSubmission;
import com.example.academylms.mapper.QuizMapper;

@Service
@Transactional
public class QuizService {
	@Autowired QuizMapper quizMapper;
	
	// 강의별 퀴즈 리스트
	public List<HashMap<String,Object>> quizListByLectureId(int lectureId, int studentId){
		
		return quizMapper.quizListByLectureId(lectureId, studentId);
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
	
	// 퀴즈 응시중 저장한 답안 확인
	public String selectAnswer(int joinId, int quizId) {
		return quizMapper.selectAnswer(joinId, quizId);
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
	
	// 답안을 등록한적 있는지 확인
	public Integer findSubmissionId(QuizSubmission quizSubmission) {
		return quizMapper.findSubmissionId(quizSubmission);
	}
	
	// 퀴즈 문항수
	public int countQuizByWeekId(int weekId) {
		return quizMapper.countQuizByWeekId(weekId);
	}
	
	// 답을 맞춘 퀴즈 문항수
	public int countCorrectQuizByJoinId(int joinId) {
		return quizMapper.countCorrectQuizByJoinId(joinId);
	}
	
	// 퀴즈 결과
	public List<HashMap<String,Object>> quizResultByJoinId(int joinId){
		return quizMapper.quizResultByJoinId(joinId);
	}
	
	// 퀴즈 해설
	public List<Quiz> quizExplanation(int weekId) {
		return quizMapper.quizExplanation(weekId);
	}
	
	// 역할 찾기
	public String selectRoleByUserId (int userId) {
		return quizMapper.selectRoleByUserId(userId);
	}
	
	// weekId 찾기
	public int selectWeekId(int lectureId, int week) {
		return quizMapper.selectWeekId(lectureId, week);
	}
	
	// 동일주차에 동일번호문제가 있는지 확인
	public int findSameNo(int weekId, int quizNo) {
		return quizMapper.findSameNo(weekId, quizNo);
	}
	
	// 강의번호에 맞는 강의제목, 시간
	public Lecture selectTitleByLectureId(int lectureId) {
		return quizMapper.selectTitleByLectureId(lectureId);
	}
	
	// 몇주차인지 확인
	public int selectWeekByWeekId(int weekId){
		return quizMapper.selectWeekByWeekId(weekId);
	}
	
	// 객관식문제 quidId 확인
	public List<Integer> selectQuizIdByWeekIdType(int weekId){
		return quizMapper.selectQuizIdByWeekIdType(weekId);
	}
	
	// 삭제된 문제 뒤에있는 문제들의 quizId
	public List<Integer> selectQuizIdByQuizNoWeekId(int quizNo, int weekId){
		return quizMapper.selectQuizIdByQuizNoWeekId(quizNo, weekId);
	}
	
	// 강의에 수강중인 전체 학생
	public List<HashMap<String,Object>> selectQuizStatus(int lectureId){
		return quizMapper.selectQuizStatus(lectureId);
	}
	
	// 퀴즈에 응시한 학생의 정보
	public List<HashMap<String,Object>> selectSubmissionStudent(int weekId){
		return quizMapper.selectSubmissionStudent(weekId);
	}
	
	// 퀴즈에 응시한 학생의 문항별 정오
	public List<HashMap<String,Object>> selectStudentCorrect(int weekId){
		return quizMapper.selectStudentCorrect(weekId);
	}
	
	// join_id등록
	public void insertJoinId(int weekId, int enrollmentId) {
		quizMapper.insertJoinId(weekId, enrollmentId);
	}
	
	// 퀴즈 등록
	public void insertQuiz(QuizForm quizForm) {
		quizMapper.insertQuiz(quizForm);
	}
	
	// 퀴즈 보기 등록(객관식)
	public void insertQuizOption(QuizForm quizForm, int optionNo,String option) {
		quizMapper.insertQuizOption(quizForm,optionNo, option);
	}
	
	// 퀴즈 답안 등록
	public void insertQuizAnswer(QuizSubmission quizSubmission) {
		quizMapper.insertQuizAnswer(quizSubmission);
	}
	
	// 퀴즈 답안 수정
	public void updateQuizAnswer(String answer, int submissionId) {
		quizMapper.updateQuizAnswer(answer, submissionId);
	}
	
	// 퀴즈 정답, 오답 체크
	public void updateIsCorrect(int joinId) {
		quizMapper.updateIsCorrect(joinId);
	}
	
	// 퀴즈 점수(정답개수/전체개수*100)
	public void updateScore(int correctQuestion, int totalQuestion,int joinId) {
		quizMapper.updateScore(correctQuestion, totalQuestion, joinId);
	}
	
	// 퀴즈 수정
	public void updateQuiz(QuizForm quizForm) {
		quizMapper.updateQuiz(quizForm);
	}
	
	// 퀴즈 보기 수정(객관식)
	public void updateQuizOption(QuizForm quizForm, int optionNo,String option) {
		quizMapper.updateQuizOption(quizForm,optionNo, option);
	}
	
	// 퀴즈 수정페이지에서 기간수정 시 다른 문제들의 기간도 동일하게 변경
	public void updateQuizDate(QuizForm quizForm) {
		quizMapper.updateQuizDate(quizForm);
	}
	
	// 삭제된문제 뒤에있는 문제들 번호-1
	public void updateQuizNo(int quizId) {
		quizMapper.updateQuizNo(quizId);
	}
	
	// 주차에 해당하는 퀴즈 전체삭제
	public void deleteQuiz(int weekId) {
		quizMapper.deleteQuiz(weekId);
	}
	
	// 퀴즈 전체삭제할때 보기도 삭제
	public void deleteQuizOption(int quizId) {
		quizMapper.deleteQuizOption(quizId);
	}
	
	// 퀴즈 한문제 삭제
	public void deleteQuizOne(int weekId, int quizNo) {
		quizMapper.deleteQuizOne(weekId, quizNo);
	}
}
