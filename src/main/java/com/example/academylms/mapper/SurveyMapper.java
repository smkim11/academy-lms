package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.SatisfactionSurvey;

@Mapper
public interface SurveyMapper {

	int getEnrollmentId(@Param(value = "lectureId") int lectureId, @Param(value = "studentId") int studentId); // Enrollment 가져오기

	int addSatisfactionSurvey(SatisfactionSurvey survey); // 만족도 조사 DB 저장
 
	int checkSurveyParticipation(int enrollmentId); // 만족도 조사 참여여부 조회 

}
