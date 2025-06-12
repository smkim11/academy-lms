package com.example.academylms.controller;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.academylms.dto.Qna;
import com.example.academylms.dto.QnaAnswer;
import com.example.academylms.dto.User;
import com.example.academylms.service.LoginService;
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
    @Autowired
    private QnaService qnaService;
    
    @Autowired
    private LoginService loginService;

//QnA 리스트
    @GetMapping("/qna")
    public String qnaList(HttpServletRequest request) {
    	List<Map<String, Object>> list = qnaService.getQnaList();
        request.setAttribute("qnaList", list);
        HttpSession session = request.getSession();
        int userId = (int)session.getAttribute("loginUserId"); // 세션 값 호출
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        if ("student".equals(role)) {
            request.setAttribute("contentPage", "student/qnaList.jsp");
            return "student/qnaList";
        } else if ("instructor".equals(role)) {
            request.setAttribute("contentPage", "instructor/qnaList.jsp");
            return "instructor/qnaList";
        } else {
            request.setAttribute("contentPage", "instructor/qnaList.jsp");
            return "instructor/qnaList";
        }
    }
    
//QnA 글정보
    @GetMapping("/qnaOne")
    public String qnaOne(@RequestParam("id") int qnaId, HttpServletRequest request) {
        Qna qna = qnaService.getQnaOne(qnaId);
        request.setAttribute("qna", qna);
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        // 글 작성자 id 조회 (enrollment → student_id 연결된 걸 가져오거나 Qna에 있으면 거기서 꺼냄)
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId); 
        if (qna.getIsPublic() == 0) { // 비공개글이면
            boolean canView = false;

            if ("instructor".equals(role)) {
                canView = true; // 강사는 OK
            } else if ("student".equals(role) && userId == qnaStudentId) {
                canView = true; // 작성한 학생이면 OK
            }

            if (!canView) {
            	return "redirect:/qna?errorMsg=privateAccessDenied";
            }
        }
        
        List<QnaAnswer> answer = qnaService.selectQnaAnswer(qnaId);

        request.setAttribute("loginRole", role);
        request.setAttribute("qnaStudentId", qnaStudentId);
        request.setAttribute("qnaAnswer", answer);
        

        if ("student".equals(role)) {
            request.setAttribute("contentPage", "student/qnaOne.jsp");
            return "student/qnaOne";
        } else if ("instructor".equals(role)) {
            request.setAttribute("contentPage", "instructor/qnaOne.jsp");
            return "instructor/qnaOne";
        } else {
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
    public String submitQna(HttpServletRequest request, 
    						@RequestParam("file") MultipartFile file) throws Exception {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        int lectureId = Integer.parseInt(request.getParameter("lectureId"));
        String title = request.getParameter("title");
        String question = request.getParameter("question");
        boolean isPublic = "1".equals(request.getParameter("isPublic"));
        
        //디버깅용
        System.out.println("==> userId = " + userId);
        System.out.println("==> lectureId = " + lectureId);
        Integer enrollmentId = qnaService.getEnrollmentId(userId, lectureId);
        //디버깅용
        System.out.println("==> enrollmentId = " + enrollmentId);
        
        if (enrollmentId != null) {
            Qna qna = new Qna();
            qna.setEnrollmentId(enrollmentId);
            qna.setTitle(title);
            qna.setQuestion(question);
            qna.setIsPublic(isPublic ? 1 : 0);
            
            // 파일 저장 처리
            if (file != null && !file.isEmpty()) {
                String uploadDir = "C:/semi";
                String originalFilename = file.getOriginalFilename();
                String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
                File targetFile = new File(uploadDir, savedFilename);
                file.transferTo(targetFile);
                qna.setFileUrl("/semi/" + savedFilename); // DTO에 파일 경로 저장
            } else {
                qna.setFileUrl(null); // 파일 없으면 null
            }
            qnaService.insertQna(qna);
        }
        
        return "redirect:/qna";
    }

//QnA 답변달기
    @PostMapping("/addAnswer")
    public String addAnswer(QnaAnswer answer) {
        qnaService.insertAnswer(answer);
        return "redirect:/qnaOne?id=" + answer.getQnaId();
    }
    
//QnA 답변삭제
    @PostMapping("/deleteAnswer")
    public String deleteAnswer(@RequestParam("answerId") int answerId,
                               @RequestParam("qnaId") int qnaId,
                               HttpServletRequest request) {
    	System.out.println("==> deleteAnswer 호출됨, answerId=" + answerId + ", qnaId=" + qnaId);
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            // 로그인 안된 상태 → 로그인 페이지로 이동
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        if (!"instructor".equals(role)) {
            return "redirect:/qnaOne?id=" + qnaId; // 강사 아니면 그냥 돌아감
        }
        qnaService.deleteAnswer(answerId);
        return "redirect:/qnaOne?id=" + qnaId;
    }
    
    @PostMapping("/deleteQna")
    public String deleteQna(@RequestParam("qnaId") int qnaId, HttpServletRequest request) {
        // 로그인 확인
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;

        // 글 작성자 확인
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId);
        // 학생 본인만 삭제 가능
        if (userId == qnaStudentId) {
            // 답변 먼저 삭제
            qnaService.deleteAnswersByQnaId(qnaId);
            // 질문 삭제
            qnaService.deleteQna(qnaId);
        }
        return "redirect:/qna";
    }
}
