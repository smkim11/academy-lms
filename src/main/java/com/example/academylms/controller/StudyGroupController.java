package com.example.academylms.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.academylms.dto.StudyGroup;
import com.example.academylms.dto.StudyPost;
import com.example.academylms.mapper.StudyGroupMapper;

@Controller
public class StudyGroupController {
	@Autowired StudyGroupMapper studyGroupMapper;
	
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
}
