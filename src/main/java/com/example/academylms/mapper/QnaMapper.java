package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.Qna;

@Mapper
public interface QnaMapper {
    List<Qna> selectQnaList();
}
