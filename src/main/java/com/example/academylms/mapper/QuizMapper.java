package com.example.academylms.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.LectureWeek;
import com.example.academylms.dto.Page;
import com.example.academylms.dto.Quiz;
import com.example.academylms.dto.QuizForm;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.dto.QuizSubmission;

@Mapper
public interface QuizMapper {
	List<HashMap<String,Object>> quizListByLectureId(int lectureId, int studentId);
	List<HashMap<String,Object>> quizOne(@Param("page") Page page, @Param("weekId") int weekId);
	String selectAnswer(int joinId, int quizId);
	int quizTotalCount(int weekId);
	List<QuizOption> quizOptionList(int quizId);
	Integer selectJoinId(int weekId, int enrollmentId);
	int selectLectureIdByweekId(int weekId);
	int selectEnrollmentId(int studentId, int lectureId);
	void insertJoinId(int weekId, int enrollmentId);
	void insertQuizAnswer(QuizSubmission quizSubmission);
	Integer findSubmissionId(QuizSubmission quizSubmission);
	void updateQuizAnswer(@Param("answer") String answer,@Param("submissionId") int submissionId);
	int countQuizByWeekId(int weekId);
	int countCorrectQuizByJoinId(int joinId);
	void updateIsCorrect(int joinId);
	void updateScore(int correctQuestion, int totalQuestion,int joinId);
	List<HashMap<String,Object>> quizResultByJoinId(int joinId);
	List<Quiz> quizExplanation(int weekId);
	String selectRoleByUserId (int userId);
	void insertQuiz(QuizForm quizForm);
	void insertQuizOption(@Param("quizForm") QuizForm quizForm, @Param("optionNo") int optionNo, @Param("option") String option);
	int selectWeekId(int lectureId, int week);
	int findSameNo(int weekId, int quizNo);
	void updateQuiz(QuizForm quizForm);
	void updateQuizOption(@Param("quizForm") QuizForm quizForm, @Param("optionNo") int optionNo, @Param("option") String option);
	List<LectureWeek> selectWeekByLectureId(int lectureId);
	void deleteQuiz(int weekId);
	List<Integer> selectQuizIdByWeekIdType(int weekId);
	void deleteQuizOption(int quizId);
	void deleteQuizOne(int weekId, int quizNo);
	List<Integer> selectQuizIdByQuizNoWeekId(int quizNo, int weekId);
	void updateQuizNo(int quizId);
	List<HashMap<String,Object>> selectQuizStatus(int lectureId);
	List<HashMap<String,Object>> selectSubmissionStudent(int weekId);
}
