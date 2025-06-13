package com.example.academylms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.SatisfactionSurvey;
import com.example.academylms.mapper.SurveyMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SurveyService{ 
	@Autowired SurveyMapper surveyMapper;
	
	public int getEnrollmentId(int lectureId, int studentId) { // EnrollmentId 조회
		 return surveyMapper.getEnrollmentId(lectureId, studentId);  
		
	}

	public int addSatisfactionSurvey(SatisfactionSurvey survey) { // 설문 데이터 베이스 추가
		
		return surveyMapper.addSatisfactionSurvey(survey);
	}

	public int checkSurveyParticipation(int enrollmentId) { // 설문 여부 조회
		 
		return surveyMapper.checkSurveyParticipation(enrollmentId);
		
	}
	
	
	
}
