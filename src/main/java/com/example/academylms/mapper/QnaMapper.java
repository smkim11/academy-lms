package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Qna;

@Mapper
public interface QnaMapper {
    List<Qna> selectQnaList();
    Qna selectQnaOne(int qnaId);
    Integer findEnrollmentId(@Param("studentId") int studentId, @Param("lectureId") int lectureId);
    void insertQna(Qna qna);
}
