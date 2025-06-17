package com.example.academylms.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.LectureMaterial;
import com.example.academylms.dto.LectureWeek;
import com.example.academylms.mapper.LectureMaterialMapper;

@Service
public class LectureMaterialService {
	@Autowired LectureMaterialMapper lectureMaterialMapper;
	
    public List<LectureMaterial> getLectureMaterialsByWeek(int weekId){
    	return lectureMaterialMapper.selectLectureMaterialsByWeek(weekId);
    };

    public LectureMaterial getLectureMaterialById(int materialId) {
    	return lectureMaterialMapper.selectLectureMaterialById(materialId);
    };

    public void addLectureMaterial(LectureMaterial material) {
    	lectureMaterialMapper.insertLectureMaterial(material);
    };

    public void updateLectureMaterial(LectureMaterial material) {
    	 lectureMaterialMapper.updateLectureMaterial(material);
    };
    
    public void deleteLectureMaterial(int materialId) {
    	lectureMaterialMapper.deleteLectureMaterial(materialId);
    };
    
    public List<LectureWeek> getWeeksByLectureId(int lectureId) {
        return lectureMaterialMapper.selectWeeksByLectureId(lectureId);
    }
    
    public LectureWeek getLectureWeekById(int weekId) {
        return lectureMaterialMapper.getLectureWeekById(weekId);
    }
    
    public Integer getLastWeekNumber(int lectureId) {
    	return lectureMaterialMapper.getLastWeekNumber(lectureId);
    };
    
    public void insertLectureWeek(LectureWeek week) {
    	lectureMaterialMapper.insertLectureWeek(week);
    };
}
