package com.example.academylms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.mapper.MainPageMapper;

@Service
public class MainPageService {
	@Autowired MainPageMapper mainPageMapper;
	
    public List<Map<String, Object>> getAllLectures() {
        return mainPageMapper.selectAllLectures();
    }

    public List<Map<String, Object>> getLecturesByInstructor(int instructorId) {
        return mainPageMapper.selectLecturesByInstructor(instructorId);
    }

    public List<Map<String, Object>> getLecturesByStudent(int studentId) {
        return mainPageMapper.selectLecturesByStudent(studentId);
    }
}
