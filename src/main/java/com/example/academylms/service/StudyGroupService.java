package com.example.academylms.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.academylms.dto.Student;
import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.mapper.StudyGroupMapper;

@Service
public class StudyGroupService {
	
	@Autowired StudyGroupMapper studyGroupMapper;
	
	public StudyPost getPostById(int postId) {
        return studyGroupMapper.selectPostById(postId);
    }
	
	 public StudyGroup getGroupById(int groupId) {
	        return studyGroupMapper.getGroupById(groupId);
	    }
	 
	 public void insertStudyPost(StudyPost post) {
		    studyGroupMapper.insertStudyPost(post);
		}
	 
	 public void updateStudyPost(StudyPost post) {
		    studyGroupMapper.updateStudyPost(post);
		}
	 
	 public void deleteStudyPost(int postId) {
		    studyGroupMapper.deleteStudyPost(postId);
		}
	 
	 public void updateFeedback(int postId, String feedback) {
	        studyGroupMapper.updateFeedback(postId, feedback);
	    }
	 
	 public List<Student> getStudentsByLectureId(int lectureId) {
	        return studyGroupMapper.selectStudentsByLectureId(lectureId);
	    }
	 
	 public void createStudyGroup(int lectureId, Integer studentId) {
	        studyGroupMapper.insertStudyGroup(lectureId, studentId);
	    }
	 
	 public boolean isStudentAlreadyLeader(int studentId) {
		    Integer result = studyGroupMapper.findGroupIdByStudentId(studentId);
		    return result != null;
		}
	 
	 public Map<Integer, Integer> getStudentGroupIdsByLectureId(int lectureId) {
		    List<Map<String, Object>> list = studyGroupMapper.selectStudentGroupIdsByLectureId(lectureId);
		    Map<Integer, Integer> map = new HashMap<>();
		    for (Map<String, Object> row : list) {
		        System.out.println("row = " + row);
		    }
		    for (Map<String, Object> row : list) {
		        Integer studentId = (Integer) row.get("studentId");
		        Integer groupId = (Integer) row.get("groupId");
		        map.put(studentId, groupId);
		    }
		    System.out.println("최종 groupMap = " + map);
		    return map;
		}


	 
	 public List<Integer> getExistingGroupIdsByLecture(int lectureId) {
		    return studyGroupMapper.selectGroupIdsByLectureId(lectureId);
		}
	 
	 public void addMemberToGroup(int lectureId, int studentId, int groupId) {
		    int enrollmentId = studyGroupMapper.selectEnrollmentId(studentId, lectureId);
		    if (enrollmentId == 0) {
		        throw new RuntimeException("수강생의 수강정보(enrollment)가 존재하지 않습니다.");
		    }
		    studyGroupMapper.insertStudyMember(groupId, enrollmentId);
		}
	 
	 public List<Integer> getGroupIdsByLectureId(int lectureId) {
		    return studyGroupMapper.selectGroupIdsByLectureId(lectureId);
		}
	 
	 public void changeMemberGroup(int lectureId, int studentId, int newGroupId) {
		    // study_member 테이블에 이미 참가자가 있으면 update, 없으면 insert 처리 (예: upsert)
		    // 여기서는 studyGroupMapper의 update 또는 insert 호출

		    // 예) 기존 참가자가 있으면 update
		    int updated = studyGroupMapper.updateMemberGroup(lectureId, studentId, newGroupId);

		    if (updated == 0) {
		        // 참가자가 없으면 새로 insert
		        studyGroupMapper.insertMemberGroup(lectureId, studentId, newGroupId);
		    }
		}
	 
	 public List<Map<String, Object>> getStudentGroupMappingByLectureId(int lectureId) {
	        return studyGroupMapper.getStudentGroupMappingByLectureId(lectureId);
	    }

}

