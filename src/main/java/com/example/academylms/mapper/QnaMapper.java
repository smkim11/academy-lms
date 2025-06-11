package com.example.academylms.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Qna;
import com.example.academylms.dto.QnaAnswer;

@Mapper
public interface QnaMapper {
	List<Map<String, Object>> selectQnaList();
    Qna selectQnaOne(int qnaId);
    Integer findEnrollmentId(@Param("studentId") int studentId, @Param("lectureId") int lectureId);
    void insertQna(Qna qna);
    void deleteQna(int qnaId);
    int findStudentIdByQna(int qnaId);
    void updateQnaAnswer(@Param("qnaId") int qnaId, @Param("answer") String answer);
    void insertAnswer(QnaAnswer answer); 
    List<QnaAnswer> selectQnaAnswer(int qnaId);
    void deleteQnaAnswer(int answerId);
}
