package com.example.academylms.rest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.service.StatisticsService;

@RestController
public class StatisticsRest {
	@Autowired StatisticsService statisticsService;
	
	// 강사별 누적 수강인원 수
	@PostMapping("/statistics/CountStudentByInstructorTotal")
	public List<HashMap<String,Object>> CountStudentByInstructorTotal(){
		return statisticsService.selectCountStudentByInstructorTotal();
	}
	
	// 강사별 현재 수강인원 수
	@PostMapping("/statistics/CountStudentByInstructorCurrent")
	public List<HashMap<String,Object>> CountStudentByInstructorCurrent(){
		return statisticsService.selectCountStudentByInstructorCurrent();
	}
	
	// 강사별 진행중, 예정 총 강의 수
	@PostMapping("/statistics/LectureDo")
	public List<HashMap<String,Object>> LectureDo(){
		return statisticsService.selectLectureDo();
	}
	
	// 강사별 별점 평균
	@PostMapping("/statistics/SurveyAvg")
	public List<HashMap<String,Object>> SurveyAvg(){
		return statisticsService.selectSurveyAvg();
	}
	
	// 강사별 별점 평균
	@PostMapping("/statistics/CountStudentByYear")
	public List<HashMap<String,Object>> CountStudentByYear(){
		return statisticsService.selectCountStudentByYear();
	}
	
	// 수강생들 나이 분포
	@PostMapping("/statistics/StudentAgeDistribution")
	public List<HashMap<String,Object>> StudentAgeDistribution(){
		return statisticsService.selectStudentAgeDistribution();
	}
	
	// 최근 1년간 강의별 인원 수
	@PostMapping("/statistics/CountByLectureThePastYear")
	public List<HashMap<String,Object>> selectCountByLectureThePastYear(){
		return statisticsService.selectCountByLectureThePastYear();
	}
}
