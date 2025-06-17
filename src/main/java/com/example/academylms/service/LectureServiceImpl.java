package com.example.academylms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.academylms.dto.InstructorInfo;
import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.LectureWeekMaterial;
import com.example.academylms.dto.Notice;
import com.example.academylms.dto.QnaList;
import com.example.academylms.dto.QuizWeekList;
import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.dto.StudyPostList;
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
	public boolean createLecture(Lecture lecture) { // 강의 생성 
		boolean result = false;  // 정상적으로 결과 출력시 true로 반환
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

	@Override
	public Lecture lectureOneBylectureId(int lectureId) { // 강의 상세정보 강의 id로 조회
		return lectureMapper.lectureOneBylectureId(lectureId); 
		
	}

	@Override
	public boolean updateLecture(Lecture lecture) { // 강의 정보 수정
		
		boolean result = false;
		
		if(lectureMapper.deleteLectureWeek(lecture.getLectureId())!= 0) { // 지운정보가 0이 아니라면 삭제성공
			log.info("삭제성공");
			
			if(lectureMapper.updateLecture(lecture)!= 0) { // 업데이트 정보가 없다면 강의 데이터 반영안됨.
				 log.info("업데이트 성공");
				 
				 for(int i=1;  i<=lecture.getWeek(); i++) { // 강의 주차 만큼 lecture_week 생성
					lectureMapper.createLectureWeek(lecture.getLectureId(),i);			
					log.info("강의"+i+"주차생성");
						

				}
				 
				 result = true;
				 return result;
			}
	
		}
		
		log.info("오류발생");
		return result;
	}

	@Override
	public int deleteLecture(int lectureId) { // 강의 정보 삭제
		int result = 0;
		if(lectureMapper.deleteLectureWeek(lectureId)!= 0) { // 강의 주차 삭제
			
			log.info("강의주차 삭제");
			
			lectureMapper.deleteLecture(lectureId); // 강의 정보 삭제
			result = 1;
		}
		
		
		return result; // 0이면 삭제 오류 1이면 삭제
	}

	@Override
	public List<LectureWeekMaterial> lectureOneWeekList(int lectureId) { // 5주차까지 강의 상세정보
		return lectureMapper.lectureOneWeekList(lectureId);
	}

	@Override
	public List<Notice> lectureOneNoticeList(int lectureId) { // 5개까지의 공지사항 상세정보 노출
		return lectureMapper.lectureOneNoticeList(lectureId);
	}

	@Override
	public List<QuizWeekList> lectureOneQuizList(int lectureId) { // 5주차까지 퀴즈 정보 노출
		return lectureMapper.lectureOneQuizList(lectureId);
	}

	@Override
	public List<QnaList> lectureOneQnaList(int lectureId) {
		return lectureMapper.lectureOneQnaList(lectureId);
	}

	@Override
	public List<StudyPostList> lectureOneStduyGroupList(int lectureId) {
		return lectureMapper.lectureOneStduyGroupList(lectureId);
	}


    
    
}
