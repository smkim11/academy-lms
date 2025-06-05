package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Qna;
import com.example.academylms.mapper.QnaMapper;

@Service
public class QnaService {
    @Autowired QnaMapper qnaMapper;
	
	public List<Qna> getQnaList(){
    	return qnaMapper.selectQnaList();
    }
	
	public Qna getQnaOne(int qnaId) {
	    return qnaMapper.selectQnaOne(qnaId);
	}
	
	public Integer getEnrollmentId(int studentId, int lectureId) {
	    return qnaMapper.findEnrollmentId(studentId, lectureId);
	}
	
	public void insertQna(Qna qna) {
	    qnaMapper.insertQna(qna);
	}
}
