package com.example.academylms.service;

import java.util.List;

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
	 
	 public void createStudyGroup(int lectureId, Integer leaderStudentId) {
	        studyGroupMapper.insertStudyGroup(lectureId, leaderStudentId);
	    }
}

