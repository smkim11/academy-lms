package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Lecture;
import com.example.academylms.mapper.LectureMapper;

@Service
public class LectureServiceImpl implements LectureService {

    @Autowired
    private LectureMapper lectureMapper;

    @Override
    public List<Lecture> getLecturesByInstructor(int instructorId) {
        return lectureMapper.findLecturesByInstructor(instructorId);
    }
    
    @Override
    public Lecture getLectureById(int lectureId) {
        return lectureMapper.selectLectureById(lectureId);  // 🔽 이 메서드가 Mapper에 있어야 함
    }
}
