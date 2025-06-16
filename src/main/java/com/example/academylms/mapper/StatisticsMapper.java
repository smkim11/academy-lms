package com.example.academylms.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StatisticsMapper {
	List<HashMap<String,Object>> selectCountStudentByInstructorTotal();
	List<HashMap<String,Object>> selectCountStudentByInstructorCurrent();
	List<HashMap<String,Object>> selectLectureDo();
	List<HashMap<String,Object>> selectSurveyAvg();
	List<HashMap<String,Object>> selectCountStudentByYear();
	List<HashMap<String,Object>> selectStudentAgeDistribution();
	List<HashMap<String,Object>> selectCountByLectureThePastYear();
}
