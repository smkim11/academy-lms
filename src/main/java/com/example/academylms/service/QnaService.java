package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Qna;
import com.example.academylms.mapper.QnaMapper;

@Service
public class QnaService {
    @Autowired QnaMapper Qnamapper;
	
	public List<Qna> getQnaList(){
    	return Qnamapper.selectQnaList();
    }
}
