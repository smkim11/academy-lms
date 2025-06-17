package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.academylms.dto.LectureMaterial;
import com.example.academylms.dto.LectureWeek;

@Mapper
public interface LectureMaterialMapper {
    // 강의자료 전체 리스트 (week_id로 조회)
    List<LectureMaterial> selectLectureMaterialsByWeek(int weekId);

    // 강의자료 상세 조회
    LectureMaterial selectLectureMaterialById(int materialId);

    // 강의자료 등록
    int insertLectureMaterial(LectureMaterial lectureMaterial);

    // 강의자료 수정
    int updateLectureMaterial(LectureMaterial lectureMaterial);
    
    // 강의자료 삭제
    void deleteLectureMaterial(int materialId);
    
    // 주차별 게시판
    List<LectureWeek> selectWeeksByLectureId(int lectureId);
    
    // 주차 카운트
    LectureWeek getLectureWeekById(int weekId);
    
    Integer getLastWeekNumber(int lectureId);
    void insertLectureWeek(LectureWeek week);
}
