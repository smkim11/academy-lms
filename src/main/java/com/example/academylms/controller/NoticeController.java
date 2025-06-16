package com.example.academylms.controller;

import java.util.List;

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

import com.example.academylms.dto.Instructor;
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

	@GetMapping("/instructor/noticeList/{lectureId}")
	public String lectureNotices(@PathVariable int lectureId, Model model) {
	    System.out.println("📌 lectureId = " + lectureId); // 이 값이 찍히는지 확인

	    Lecture lecture = lectureService.getLectureById(lectureId);
	    System.out.println("📌 lecture = " + lecture); // null이면 해당 id의 강의가 없거나 잘못된 id

	    List<Notice> notices = noticeService.getNoticesByLectureId(lectureId);
	    model.addAttribute("lecture", lecture);
	    model.addAttribute("notices", notices);

	    return "instructor/noticeList";
	}

    @GetMapping("/instructor/addNotice")
    public String showAddNoticeForm(@RequestParam("lectureId") int lectureId, Model model) {
        System.out.println("전달받은 lectureId = " + lectureId); // 디버깅

        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            System.out.println("lecture 객체가 null입니다!");
        }

        model.addAttribute("lecture", lecture);
        return "instructor/addNotice";
    }


    
    @GetMapping("/instructor/updateNotice/{noticeId}")
    public String showUpdateNoticeForm(@PathVariable int noticeId, Model model) {
        Notice notice = noticeService.getNoticeById(noticeId);
        if (notice == null) {
            return "redirect:/error"; // 없는 공지에 대한 요청일 경우
        }

        Lecture lecture = lectureService.getLectureById(notice.getLectureId());
        model.addAttribute("notice", notice);
        model.addAttribute("lecture", lecture);

        return "instructor/updateNotice"; // 수정 폼 JSP
    }


    
    @PostMapping("/instructor/addNotice")
    public String addNotice(@ModelAttribute Notice notice) {
        // 디버깅용 로그
        System.out.println("등록 요청 - Lecture ID: " + notice.getLectureId());
        System.out.println("제목: " + notice.getTitle());
        System.out.println("유형: " + notice.getNoticeType());

        // 공지 등록
        noticeService.addNotice(notice);

        // 등록 후 해당 강의의 공지 목록 페이지로 이동
        return "redirect:/instructor/noticeList/" + notice.getLectureId();
    }
    
    @PostMapping("/instructor/updateNotice")
    public String updateNotice(@ModelAttribute Notice notice) {
        // 디버깅용 로그
        System.out.println("수정 요청 - noticeId: " + notice.getNoticeId());
        System.out.println("Lecture ID: " + notice.getLectureId());
        System.out.println("제목: " + notice.getTitle());

        noticeService.updateNotice(notice);

        // 수정 후 해당 강의의 공지 목록으로 리다이렉트
        return "redirect:/instructor/noticeList/" + notice.getLectureId();
    }
    
    @DeleteMapping("/instructor/notices/{noticeId}")
    @ResponseBody
    public String deleteNotice(@PathVariable int noticeId) {
        noticeService.deleteNotice(noticeId);
        return "success";
    }
    
    @GetMapping("/student/noticeList/{lectureId}")
    public String studentNoticeList(@PathVariable int lectureId, Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        List<Notice> notices = noticeService.getNoticesByLectureId(lectureId);
        model.addAttribute("lecture", lecture);
        model.addAttribute("notices", notices);
        return "student/noticeList"; // 공지 리스트 페이지
    }
    
    @GetMapping("/student/noticeListOne/{lectureId}/{noticeId}")
    public String getNoticeDetail(@PathVariable int lectureId,
                                  @PathVariable int noticeId,
                                  Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        Notice notice = noticeService.getNoticeById(noticeId);

        model.addAttribute("lecture", lecture);
        model.addAttribute("notice", notice);
        return "student/noticeListOne"; // 공지상세(학생)
    }
    
    @GetMapping("/instructor/noticeListOne/{lectureId}/{noticeId}")
    public String getInstructorNoticeDetail(@PathVariable int lectureId,
                                            @PathVariable int noticeId,
                                            Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        Notice notice = noticeService.getNoticeById(noticeId);

        model.addAttribute("lecture", lecture);
        model.addAttribute("notice", notice);
        return "instructor/noticeListOne";  // 공지상세(강사용)
    }
    
    @GetMapping("/admin/noticeList/{lectureId}")
	public String adminNotices(@PathVariable int lectureId, Model model) {
	    System.out.println("📌 lectureId = " + lectureId); // 이 값이 찍히는지 확인

	    Lecture lecture = lectureService.getLectureById(lectureId);
	    System.out.println("📌 lecture = " + lecture); // null이면 해당 id의 강의가 없거나 잘못된 id

	    List<Notice> notices = noticeService.getNoticesByLectureId(lectureId);
	    model.addAttribute("lecture", lecture);
	    model.addAttribute("notices", notices);

	    return "admin/noticeList";
	}
    
    @GetMapping("/admin/noticeListOne/{lectureId}/{noticeId}")
    public String getAdminNoticeDetail(@PathVariable int lectureId,
                                            @PathVariable int noticeId,
                                            Model model) {
        Lecture lecture = lectureService.getLectureById(lectureId);
        Notice notice = noticeService.getNoticeById(noticeId);

        model.addAttribute("lecture", lecture);
        model.addAttribute("notice", notice);
        return "admin/noticeListOne";  // 공지상세(강사용)
    }
    
    @GetMapping("/admin/updateNotice/{noticeId}")
    public String showUpdateNoticeFormAdmin(@PathVariable int noticeId, Model model) {
        Notice notice = noticeService.getNoticeById(noticeId);
        if (notice == null) {
            return "redirect:/error"; // 없는 공지에 대한 요청일 경우
        }

        Lecture lecture = lectureService.getLectureById(notice.getLectureId());
        model.addAttribute("notice", notice);
        model.addAttribute("lecture", lecture);

        return "admin/updateNotice"; // 수정 폼 JSP
    }
    
    @PostMapping("/admin/updateNotice")
    public String updateNoticeAdmin(@ModelAttribute Notice notice) {
        // 디버깅용 로그
        System.out.println("수정 요청 - noticeId: " + notice.getNoticeId());
        System.out.println("Lecture ID: " + notice.getLectureId());
        System.out.println("제목: " + notice.getTitle());

        noticeService.updateNotice(notice);

        // 수정 후 해당 강의의 공지 목록으로 리다이렉트
        return "redirect:/admin/noticeList/" + notice.getLectureId();
    }
    
    @GetMapping("/admin/addNotice")
    public String showAddNoticeFormAdmin(@RequestParam("lectureId") int lectureId, Model model) {
        System.out.println("전달받은 lectureId = " + lectureId); // 디버깅

        Lecture lecture = lectureService.getLectureById(lectureId);
        if (lecture == null) {
            System.out.println("lecture 객체가 null입니다!");
        }

        model.addAttribute("lecture", lecture);
        return "admin/addNotice";
    }
    
    @PostMapping("/admin/addNotice")
    public String addNoticeAdmin(@ModelAttribute Notice notice) {
        // 디버깅용 로그
        System.out.println("등록 요청 - Lecture ID: " + notice.getLectureId());
        System.out.println("제목: " + notice.getTitle());
        System.out.println("유형: " + notice.getNoticeType());

        // 공지 등록
        noticeService.addNotice(notice);

        // 등록 후 해당 강의의 공지 목록 페이지로 이동
        return "redirect:/admin/noticeList/" + notice.getLectureId();
    }
    
    @DeleteMapping("/admin/notices/{noticeId}")
    @ResponseBody
    public String deleteNoticeAdmin(@PathVariable int noticeId) {
        noticeService.deleteNotice(noticeId);
        return "success";
    }
}
