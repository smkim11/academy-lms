package com.example.academylms.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.Quiz;
import com.example.academylms.dto.QuizOption;
import com.example.academylms.dto.QuizSubmission;

@Mapper
public interface QuizMapper {
	List<HashMap<String,Object>> quizListByLectureId(int lectureId);
	List<HashMap<String,Object>> quizOne(@Param("page") Page page, @Param("weekId") int weekId);;
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
}
