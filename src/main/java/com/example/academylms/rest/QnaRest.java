package com.example.academylms.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.academylms.dto.Qna;
import com.example.academylms.dto.QnaAnswer;
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/qna") // REST API 경로는 보통 /api로 시작
public class QnaRest {

    @Autowired
    private QnaService qnaService;

    // 전체 QnA 리스트 조회 (GET /api/qna)
    @GetMapping
    public List<Map<String, Object>> getAllQna() {
        return qnaService.getQnaList();
    }

    // 특정 QnA 1개 조회 (GET /api/qna/{id})
    @GetMapping("/{id}")
    public Map<String, Object> getQnaById(@PathVariable("id") int qnaId) {
        Map<String, Object> result = new HashMap<>();

        Qna qna = qnaService.getQnaOne(qnaId);
        List<QnaAnswer> answer = qnaService.selectQnaAnswer(qnaId);

        result.put("qna", qna);
        result.put("answer", answer); // null 가능성 있음 → 프론트에서 체크 필요

        return result;
    }

    // QnA 글 작성 (POST /api/qna)
    @PostMapping
    public String addQna(@RequestParam("studentId") int studentId,
                         @RequestParam("lectureId") int lectureId,
                         @RequestParam("question") String question,
                         @RequestParam("isPublic") boolean isPublic) {

        Integer enrollmentId = qnaService.getEnrollmentId(studentId, lectureId);
        if (enrollmentId != null) {
            Qna qna = new Qna();
            qna.setEnrollmentId(enrollmentId);
            qna.setQuestion(question);
            qna.setIsPublic(isPublic ? 1 : 0);
            qnaService.insertQna(qna);
            return "QnA inserted successfully";
        } else {
            return "Enrollment not found";
        }
    }

    @DeleteMapping("/{id}")
    public String deleteQna(@PathVariable("id") int qnaId, HttpServletRequest request) {
        int loginId = (int) request.getSession().getAttribute("loginId");
        String loginRole = (String) request.getSession().getAttribute("loginRole");

        int qnaStudentId = qnaService.getStudentIdByQna(qnaId);

        if ("student".equals(loginRole) && loginId == qnaStudentId) {
            qnaService.deleteQna(qnaId);
            return "QnA deleted successfully";
        } else {
            return "You do not have permission to delete this QnA.";
        }
    }
    
    @PostMapping("/{id}/answer")
    public String addAnswer(@PathVariable("id") int qnaId,
                            @RequestParam("answer") String answer,
                            HttpServletRequest request) {
        String loginRole = (String) request.getSession().getAttribute("loginRole");

        if ("instructor".equals(loginRole)) {
            qnaService.addAnswerToQna(qnaId, answer);
            return "Answer added successfully";
        } else {
            return "Only instructors can add answers.";
        }
    }
    
    @DeleteMapping("/answer/{answerId}")
    public String deleteAnswer(@PathVariable("answerId") int answerId,
                               HttpServletRequest request) {
        String loginRole = (String) request.getSession().getAttribute("loginRole");

        // 강사만 삭제 가능
        if (!"instructor".equals(loginRole)) {
            return "Only instructors can delete answers.";
        }

        qnaService.deleteAnswer(answerId);
        return "Answer deleted successfully.";
    }
}