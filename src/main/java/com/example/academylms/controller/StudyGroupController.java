package com.example.academylms.controller;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.academylms.dto.Student;
import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.mapper.StudyGroupMapper;
import com.example.academylms.service.StudyGroupService;

@Controller
public class StudyGroupController {
	@Autowired StudyGroupMapper studyGroupMapper;
	@Autowired StudyGroupService studyGroupService;
	
	@GetMapping("/student/studyPost/{lectureId}")
    public String getStudyBoard(@PathVariable int lectureId, Model model) {
        List<StudyGroup> groups = studyGroupMapper.getGroupsByLectureId(lectureId);
        Map<Integer, List<StudyPost>> groupPostMap = new LinkedHashMap<>();

        for (StudyGroup group : groups) {
            List<StudyPost> posts = studyGroupMapper.getPostsByGroupId(group.getGroupId());
            groupPostMap.put(group.getGroupId(), posts);
        }

        model.addAttribute("lectureId", lectureId);
        model.addAttribute("groupPostMap", groupPostMap);
        return "student/studyPost";
    }
	
	@GetMapping("/student/studyPostOne/{postId}")
	public String studyPostOne(@PathVariable int postId, Model model) {
	    StudyPost post = studyGroupService.getPostById(postId);
	    model.addAttribute("post", post);

	    int groupId = post.getGroupId();
	    int lectureId = studyGroupService.getGroupById(groupId).getLectureId();
	    model.addAttribute("lectureId", lectureId);

	    return "student/studyPostOne";
	}
	
	@GetMapping("/student/addStudyPost/{groupId}")
	public String addStudyPost(@PathVariable int groupId, Model model) {
	    StudyGroup group = studyGroupService.getGroupById(groupId);
	    if (group == null) {
	        return "redirect:/student/errorPage";
	    }

	    model.addAttribute("groupId", groupId);
	    model.addAttribute("lectureId", group.getLectureId());
	    return "student/addStudyPost";
	}
	
	@PostMapping("/student/addStudyPost")
	public String writePost(@RequestParam int groupId,
	                        @RequestParam String title,
	                        @RequestParam String content) {
	    StudyPost post = new StudyPost();
	    post.setGroupId(groupId);
	    post.setTitle(title);
	    post.setContent(content);
	    post.setCreateDate(LocalDateTime.now().toString()); // 또는 DB에 자동 생성되게

	    studyGroupService.insertStudyPost(post);
	    StudyGroup group = studyGroupService.getGroupById(groupId);
	    return "redirect:/student/studyPost/" + group.getLectureId(); // 목록으로 이동
	}
	
	// 수정 폼 보여주기
	@GetMapping("/student/updateStudyPost/{postId}")
	public String showUpdateStudyPost(@PathVariable int postId, Model model) {
	    StudyPost post = studyGroupService.getPostById(postId);
	    if (post == null) {
	        return "redirect:/student/errorPage";
	    }

	    StudyGroup group = studyGroupService.getGroupById(post.getGroupId());

	    model.addAttribute("post", post);
	    model.addAttribute("lectureId", group.getLectureId());
	    return "student/updateStudyPost";
	}

	// 수정 처리
	@PostMapping("/student/updateStudyPost")
	public String updateStudyPost(@ModelAttribute StudyPost post) {
	    studyGroupService.updateStudyPost(post);
	    return "redirect:/student/studyPostOne/" + post.getPostId();
	}
	
	// 삭제
	@DeleteMapping("/student/studyPosts/{postId}")
	@ResponseBody
	public String deleteStudyPost(@PathVariable int postId) {
	    studyGroupService.deleteStudyPost(postId);
	    return "success";
	}
	
	@GetMapping("/instructor/studyPost/{lectureId}")
    public String getStudyBoardInstructor(@PathVariable int lectureId, Model model) {
        List<StudyGroup> groups = studyGroupMapper.getGroupsByLectureId(lectureId);
        Map<Integer, List<StudyPost>> groupPostMap = new LinkedHashMap<>();

        for (StudyGroup group : groups) {
            List<StudyPost> posts = studyGroupMapper.getPostsByGroupId(group.getGroupId());
            groupPostMap.put(group.getGroupId(), posts);
        }

        model.addAttribute("lectureId", lectureId);
        model.addAttribute("groupPostMap", groupPostMap);
        return "instructor/studyPost";
    }
	
	@GetMapping("/instructor/studyPostOne/{postId}")
	public String studyPostOneInstructor(@PathVariable int postId, Model model) {
	    StudyPost post = studyGroupService.getPostById(postId);
	    model.addAttribute("post", post);

	    int groupId = post.getGroupId();
	    int lectureId = studyGroupService.getGroupById(groupId).getLectureId();
	    model.addAttribute("groupId", groupId);
	    model.addAttribute("lectureId", lectureId);

	    return "instructor/studyPostOne";
	}

	@PostMapping("/instructor/studyPostOne")
	public String updateFeedback(@RequestParam("postId") int postId,
	                             @RequestParam("feedback") String feedback,
	                             @RequestParam("groupId") int groupId,
	                             RedirectAttributes redirectAttributes) {
	    try {
	        studyGroupService.updateFeedback(postId, feedback);
	        redirectAttributes.addFlashAttribute("message", "피드백이 성공적으로 저장되었습니다.");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("message", "피드백 저장 중 오류가 발생했습니다.");
	    }

	    return "redirect:/instructor/studyPostOne/" + postId;
	}
	
	@GetMapping("/instructor/studyGroupForm")
	public String showGroupForm(@RequestParam int lectureId, Model model) {
		List<Student> students = studyGroupService.getStudentsByLectureId(lectureId); // 조장 후보
		model.addAttribute("lectureId", lectureId);
		model.addAttribute("students", students);
		return "instructor/studyGroupForm";
	   }
	
	@PostMapping("/instructor/studyGroup/create")
	public String createGroup(@RequestParam int lectureId,
	                          @RequestParam(required = false) Integer leaderStudentId) {
	    studyGroupService.createStudyGroup(lectureId, leaderStudentId);
	    return "redirect:/instructor/studyGroup/list?lectureId=" + lectureId;
	}


}
