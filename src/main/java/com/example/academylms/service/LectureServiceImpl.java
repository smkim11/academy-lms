package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;
import com.example.academylms.mapper.LectureMapper;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
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

	@Override
	public List<InstructorInfo> findInstructorInfo() {  // 강사정보 조회
		return lectureMapper.findInstructorInfo();
	}

	@Override
	public String findInstructorInfoByinfoId(int instructorId) { // 강사정보로 전공 조회
		
		return lectureMapper.findInstructorInfoByinfoId(instructorId);
	}

	@Override
	public boolean createLecture(Lecture lecture) {
		boolean result = false;  // 정상적으로 결과 출력시 1로 반환할 변수
		if(lectureMapper.createLecture(lecture) == 1) { // 강의 생성 
			log.info("강의생성 성공, ID = {}" , lecture.getLectureId());
			
			for(int i=1;  i<=lecture.getWeek(); i++) { // 강의 주차 만큼 lecture_week 생성
				lectureMapper.createLectureWeek(lecture.getLectureId(),i);			
				log.info("강의"+i+"주차생성");
				

			}
			result = true;
			return result;
		}
		 return result;
	}
	
    
    
}
