package com.example.academylms.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainPageMapper {
    List<Map<String, Object>> selectAllLectures();
    List<Map<String, Object>> selectLecturesByInstructor(int instructorId);
    List<Map<String, Object>> selectLecturesByStudent(int studentId);
    List<Map<String, Object>> selectOngoingLecturesForStudent(int studentId);
    List<Map<String, Object>> selectOngoingLecturesForInstructor(int instructorId);
}