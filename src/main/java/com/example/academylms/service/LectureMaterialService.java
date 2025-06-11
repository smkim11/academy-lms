package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.LectureMaterial;
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
}
