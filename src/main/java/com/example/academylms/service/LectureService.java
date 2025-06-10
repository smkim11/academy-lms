package com.example.academylms.service;

import java.util.List;
import com.example.academylms.dto.Lecture;

public interface LectureService {
    List<Lecture> getLecturesByInstructor(int instructorId);
    Lecture getLectureById(int lectureId);
}