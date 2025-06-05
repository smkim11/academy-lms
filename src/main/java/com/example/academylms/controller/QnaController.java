package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.academylms.dto.Qna;
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QnaController {
    @Autowired
    private QnaService qnaService;

    //QnA 리스트
    @GetMapping("/qna")
    public String qnaList(HttpServletRequest request) {
        List<Qna> list = qnaService.getQnaList();
        request.setAttribute("qnaList", list);

        String role = (String) request.getSession().getAttribute("loginRole");
        if ("student".equals(role)) {
            request.setAttribute("contentPage", "student/qnaList.jsp");
            return "student/qnaList";
        } else if ("instructor".equals(role)) {
            request.setAttribute("contentPage", "instructor/qnaList.jsp");
            return "instructor/qnaList";
        } else {
            // 관리자 등은 일단 강사 화면 재활용하거나 별도 처리
            request.setAttribute("contentPage", "instructor/qnaList.jsp");
            return "instructor/qnaList";
        }
    }
    
    //QnA 글정보
    @GetMapping("/qnaOne")
    public String qnaOne(@RequestParam("id") int qnaId, HttpServletRequest request) {
        Qna qna = qnaService.getQnaOne(qnaId);
        request.setAttribute("qna", qna);

        String role = (String) request.getSession().getAttribute("loginRole");
        if ("student".equals(role)) {
            request.setAttribute("contentPage", "student/qnaOne.jsp");
            return "student/qnaOne";
        } else if ("instructor".equals(role)) {
            request.setAttribute("contentPage", "instructor/qnaOne.jsp");
            return "instructor/qnaOne";
        } else {
            // 관리자거나 기타 역할은 강사용 화면 재활용
            request.setAttribute("contentPage", "instructor/qnaOne.jsp");
            return "instructor/qnaOne";
        }
    }
    
    //QnA 글쓰기
    @GetMapping("/addQna")
    public String addQnaForm(HttpServletRequest request) {
        return "student/addQna";
    }

    @PostMapping("/addQna")
    public String submitQna(HttpServletRequest request) {
        int studentId = (int) request.getSession().getAttribute("loginId"); // user_id
        int lectureId = Integer.parseInt(request.getParameter("lectureId"));
        String question = request.getParameter("question");
        boolean isPublic = "1".equals(request.getParameter("isPublic"));
        Integer enrollmentId = qnaService.getEnrollmentId(studentId, lectureId);
        if (enrollmentId != null) {
            Qna qna = new Qna();
            qna.setEnrollmentId(enrollmentId);
            qna.setQuestion(question);
            qna.setIsPublic(isPublic ? 1 : 0);
            qnaService.insertQna(qna);
        }
        return "redirect:/qna";
    }
}
