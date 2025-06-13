package com.example.academylms.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.SatisfactionSurvey;

@Mapper
public interface SurveyMapper {

	int getEnrollmentId(@Param(value = "lectureId") int lectureId, @Param(value = "studentId") int studentId);

	int addSatisfactionSurvey(SatisfactionSurvey survey);

}
