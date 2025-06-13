package com.example.academylms.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;

@Mapper
public interface StudyGroupMapper {
	List<StudyGroup> getGroupsByLectureId(@Param("lectureId") int lectureId);
	List<StudyPost> getPostsByGroupId(@Param("groupId") int groupId);
	StudyPost selectPostById(int postId);
	StudyGroup getGroupById(int groupId);
	void insertStudyPost(StudyPost post);
	void updateStudyPost(StudyPost post);
}
