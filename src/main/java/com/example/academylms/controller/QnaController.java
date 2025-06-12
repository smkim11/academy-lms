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
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QnaController {
    @Autowired
    private QnaService qnaService;

    //QnA 리스트
    @GetMapping("/qna")
    public String qnaList(HttpServletRequest request) {
    	List<Map<String, Object>> list = qnaService.getQnaList();
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

        // 로그인 정보
        String role = (String) request.getSession().getAttribute("loginRole");
     //로그인작동시 주석해제하고 아래부분삭제   int loginId = (int) request.getSession().getAttribute("loginId");
        //여기부터
        Object loginIdObj = request.getSession().getAttribute("loginId");
        if (role == null) role = "instructor";
        int loginId = -1; // 기본값 넣어줌 (비로그인 상태 대응 가능)
        if (loginIdObj != null) {
            loginId = (int) loginIdObj;
        }
        //여기까지 삭제

        // 글 작성자 id 조회 (enrollment → student_id 연결된 걸 가져오거나 Qna에 있으면 거기서 꺼냄)
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId); 
        
        
        if (qna.getIsPublic() == 0) { // 비공개글이면
            boolean canView = false;

            if ("instructor".equals(role)) {
                canView = true; // 강사는 OK
            } else if ("student".equals(role) && loginId == qnaStudentId) {
                canView = true; // 작성한 학생이면 OK
            }

            if (!canView) {
                // 접근 금지 - 예를 들어 에러페이지로 보내거나, 목록으로 리다이렉트
                return "redirect:/qna"; // 지금은 그냥 목록으로 보내는 예시
            }
        }
        
        List<QnaAnswer> answer = qnaService.selectQnaAnswer(qnaId);

        request.setAttribute("loginRole", role);
        request.setAttribute("loginId", loginId);
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
        //int studentId = (int) request.getSession().getAttribute("loginId"); // user_id
        //여기부터
        // ★ 테스트용으로 강제로 loginId=1 설정
        request.getSession().setAttribute("loginId", 1); // 강제 설정
        int studentId = 1; // 여기서 studentId 도 1 고정
        //여기까지 지우고 윗줄살리기
        
        int lectureId = Integer.parseInt(request.getParameter("lectureId"));
        String title = request.getParameter("title");
        String question = request.getParameter("question");
        boolean isPublic = "1".equals(request.getParameter("isPublic"));
        
        //디버깅용
        System.out.println("==> studentId = " + studentId);
        System.out.println("==> lectureId = " + lectureId);

        Integer enrollmentId = qnaService.getEnrollmentId(studentId, lectureId);

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
    	String role = (String) request.getSession().getAttribute("loginRole");
    	//여기부터 삭제(로그인기능 생기면)
    	if (role == null) {
    	    role = "instructor";
    	    request.getSession().setAttribute("loginRole", role); // 세션에도 넣어줘야 POST에서 반영됨
    	}
    	//여기까지
        // 강사만 삭제 가능
        if (!"instructor".equals(role)) {
            return "redirect:/qnaOne?id=" + qnaId; // 강사 아니면 그냥 돌아감
        }

        qnaService.deleteAnswer(answerId);
        return "redirect:/qnaOne?id=" + qnaId;
    }
}
