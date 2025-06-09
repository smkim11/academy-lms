package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.academylms.dto.Lecture;
import com.example.academylms.dto.Notice;
import com.example.academylms.service.LectureService;
import com.example.academylms.service.NoticeService;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
	@Autowired
	private LectureService lectureService;
	@Autowired
    private NoticeService noticeService;

    @GetMapping("/instructor/noticeList")
    public String showInstructorNoticeList(Model model) {
        model.addAttribute("notices", noticeService.getNoticeList());
        return "instructor/noticeList";
    }

    @GetMapping("/student/noticeList")
    public String showStudentNoticeList(Model model) {
        model.addAttribute("notices", noticeService.getNoticeList());
        return "student/noticeList";
    }
    
    @GetMapping("/instructor/addNotice")
    public String addNoticeForm(HttpSession session, Model model) {
        Integer instructorId = (Integer) session.getAttribute("instructorId");
        if (instructorId == null) return "redirect:/login";

        List<Lecture> lectures = lectureService.getLecturesByInstructor(instructorId);
        model.addAttribute("lectures", lectures); // JSP에서 select로 사용

        return "instructor/addNotice";
    }


    
    @GetMapping("/instructor/updateNotice/{noticeId}")
    public String showUpdateForm(@PathVariable int noticeId, Model model) {
        Notice notice = noticeService.getNoticeById(noticeId);  // 공지 1개 조회
        model.addAttribute("notice", notice);                    // JSP로 전달
        return "instructor/updateNotice";                        // 수정 폼 JSP
    }
    
    @PostMapping("/instructor/addNotice")
    public String addNotice(@ModelAttribute Notice notice) {
        // System.out.println("lectureId = " + notice.getLectureId());
        // System.out.println("title = " + notice.getTitle());
        // System.out.println("type = " + notice.getNoticeType());

        noticeService.addNotice(notice);
        return "redirect:/instructor/noticeList";
    }
    
    @GetMapping("/instructor/updateNotice")
    public String updateNotice() {
    	return "/instructor/updateNotice";
    }
}
