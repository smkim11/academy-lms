package com.example.academylms.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.academylms.dto.Student;
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
	void deleteStudyPost(int postId);
	void updateFeedback(@Param("postId") int postId, @Param("feedback") String feedback);
	List<Student> selectStudentsByLectureId(int lectureId);
	void insertStudyGroup(@Param("lectureId") int lectureId,
            @Param("studentId") Integer studentId);
	Integer findGroupIdByStudentId(@Param("studentId") int studentId);
	List<Map<String, Object>> selectStudentGroupIdsByLectureId(int lectureId);
	List<Integer> selectGroupIdsByLectureId(int lectureId);
	int selectEnrollmentId(@Param("studentId") int studentId, @Param("lectureId") int lectureId);
    void insertStudyMember(@Param("groupId") int groupId,
                           @Param("enrollmentId") int enrollmentId);
    int updateMemberGroup(@Param("lectureId") int lectureId,
            @Param("studentId") int studentId,
            @Param("newGroupId") int newGroupId);
    int insertMemberGroup(@Param("lectureId") int lectureId,
            @Param("studentId") int studentId,
            @Param("newGroupId") int newGroupId);
    List<Map<String, Object>> getStudentGroupMappingByLectureId(int lectureId);
    
}
