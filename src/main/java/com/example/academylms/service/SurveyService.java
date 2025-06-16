package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Page;
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

	public double surveyAvgResult(int lectureId) { // 설문 평균 구하기
		return surveyMapper.surveyAvgResult(lectureId); // 평균 점수
		
	}

	public int countSurveys(int lectureId) { // 전체 설문 개수 가지고 오기
 		return surveyMapper.countSurveys(lectureId);
	}

	public List<SatisfactionSurvey> getSurveyPage(int lectureId, Page page) { // 설문 리스트 가져오기 
		return surveyMapper.getSurveyPage(lectureId, page); // 설문리스트 페이징 처리
	}


	
	
	
}
