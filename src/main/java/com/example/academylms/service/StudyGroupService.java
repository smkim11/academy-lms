package com.example.academylms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}

