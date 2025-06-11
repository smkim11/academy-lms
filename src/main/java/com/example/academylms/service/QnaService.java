package com.example.academylms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Qna;
import com.example.academylms.dto.QnaAnswer;
import com.example.academylms.mapper.QnaMapper;

@Service
public class QnaService {
    @Autowired QnaMapper qnaMapper;
	
    public List<Map<String, Object>> getQnaList() {
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
	
	public void deleteQna(int qnaId) {
	    qnaMapper.deleteQna(qnaId);
	}

	public int getStudentIdByQna(int qnaId) {
	    return qnaMapper.findStudentIdByQna(qnaId);
	}

	public void addAnswerToQna(int qnaId, String answer) {
	    qnaMapper.updateQnaAnswer(qnaId, answer);
	}
	
	public void insertAnswer(QnaAnswer answer) {
        qnaMapper.insertAnswer(answer);
    }
	
	public List<QnaAnswer> selectQnaAnswer(int qnaId) {
	    return qnaMapper.selectQnaAnswer(qnaId);
	}
	
	public void deleteAnswer(int answerId) {
	    qnaMapper.deleteQnaAnswer(answerId);
	}
}
