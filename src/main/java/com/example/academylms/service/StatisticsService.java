package com.example.academylms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.mapper.StatisticsMapper;

@Service
@Transactional
public class StatisticsService {
	@Autowired StatisticsMapper statisticsMapper;
	
	// 강사별 누적 수강인원 수
	public List<HashMap<String,Object>> selectCountStudentByInstructorTotal(){
		return statisticsMapper.selectCountStudentByInstructorTotal();
	}
	
	// 강사별 현재 수강인원 수
	public List<HashMap<String,Object>> selectCountStudentByInstructorCurrent(){
		return statisticsMapper.selectCountStudentByInstructorCurrent();
	}

	// 강사별 진행중, 예정 총 강의 수
	public List<HashMap<String,Object>> selectLectureDo(){
		return statisticsMapper.selectLectureDo();
	}
	
	// 강사별 별점 평균
	public List<HashMap<String,Object>> selectSurveyAvg(){
		return statisticsMapper.selectSurveyAvg();
	}
	
	// 연도별 누적 학생 수
	public List<HashMap<String,Object>> selectCountStudentByYear(){
		return statisticsMapper.selectCountStudentByYear();
	}
	
	// 수강생들 나이 분포
	public List<HashMap<String,Object>> selectStudentAgeDistribution(){
		return statisticsMapper.selectStudentAgeDistribution();
	}
	
	// 수강생들 나이 분포
	public List<HashMap<String,Object>> selectCountByLectureThePastYear(){
		return statisticsMapper.selectCountByLectureThePastYear();
	}
}
