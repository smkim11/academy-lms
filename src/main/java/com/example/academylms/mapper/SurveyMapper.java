package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Page;
import com.example.academylms.dto.SatisfactionSurvey;

@Mapper
public interface SurveyMapper {

	int getEnrollmentId(@Param(value = "lectureId") int lectureId, @Param(value = "studentId") int studentId); // Enrollment 가져오기

	int addSatisfactionSurvey(SatisfactionSurvey survey); // 만족도 조사 DB 저장
 
	int checkSurveyParticipation(int enrollmentId); // 만족도 조사 참여여부 조회 

	Double surveyAvgResult(int lectureId); // 만족도 평균 구하기

	int countSurveys(int lectureId); // 전체 설문 갯수 카운트

	List<SatisfactionSurvey> getSurveyPage(@Param(value ="lectureId") int  lectureId, @Param(value = "page") Page page); // 설문 페이징처리

}
