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
import com.example.academylms.mapper.QnaMapper;
import com.example.academylms.service.LoginService;
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class QnaController {
    @Autowired
    private QnaService qnaService;
    @Autowired
    private QnaMapper qnaMapper;
    @Autowired
    private LoginService loginService;

//QnA 리스트
    @GetMapping("/qna")
    public String qnaList(@RequestParam int lectureId,
                          @RequestParam(defaultValue = "1") int page,
                          HttpServletRequest request) {
    	// 페이징
        int pageSize = 10; // 한 페이지당 게시글 수
        int offset = (page - 1) * pageSize;
        List<Map<String, Object>> qnaList = qnaService.getQnaListByPage(lectureId, offset, pageSize);
        int totalCount = qnaService.getQnaCount(lectureId);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        
        request.setAttribute("qnaList", qnaList);
        request.setAttribute("lectureId", lectureId);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // 세션정보(역할 나누기)
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("loginUserId");
        User user = loginService.findById(userId);
        String role = user.getRole();
        
        // 리스트 상단 강의정보표시
        Map<String, Object> lectureInfoMap = qnaMapper.getLectureInfoByLectureId(lectureId);
        request.setAttribute("lectureTitle", lectureInfoMap.get("title"));
        request.setAttribute("lectureDay", lectureInfoMap.get("day"));
        request.setAttribute("lectureTime", lectureInfoMap.get("time"));
        
        if ("student".equals(role)) {
            return "student/qnaList";
        } else if ("instructor".equals(role)) {
            return "instructor/qnaList";
        } else if ("admin".equals(role)) {
            return "admin/qnaList";
        } else {
            return "redirect:/login";
        }
    }
    
//QnA 글정보
    @GetMapping("/qnaOne")
    public String qnaOne(@RequestParam("id") int qnaId, @RequestParam("lectureId") int lectureId, HttpServletRequest request) {
        Qna qna = qnaService.getQnaOne(qnaId);
        request.setAttribute("qna", qna);
        request.setAttribute("lectureId", lectureId);

        //세션정보
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;
        request.setAttribute("loginUserId", userId); 
        User user = loginService.findById(userId); 
        String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
        
        // 세션에 login 정보 강제로 다시 저장
        session.setAttribute("loginUserId", userId);
        session.setAttribute("loginRole", role);
        
        // 리스트 상단 강의정보표시
        Map<String, Object> lectureInfoMap = qnaMapper.getLectureInfoByLectureId(lectureId);
        request.setAttribute("lectureTitle", lectureInfoMap.get("title"));
        request.setAttribute("lectureDay", lectureInfoMap.get("day"));
        request.setAttribute("lectureTime", lectureInfoMap.get("time"));
        
        // 글 작성자 id 조회 (enrollment → student_id 연결된 걸 가져오거나 Qna에 있으면 거기서 꺼냄)
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId); 
        if (qna.getIsPublic() == 0) { // 비공개글이면
            boolean canView = false;
            if ("instructor".equals(role)||"admin".equals(role)) {
                canView = true; // 강사 관리자는 OK
            } else if ("student".equals(role) && userId == qnaStudentId) {
                canView = true; // 작성한 학생이면 OK
            }
            if (!canView) {
            	return "redirect:/qna?lectureId=" + lectureId + "&errorMsg=privateAccessDenied";
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
        } else if ("admin".equals(role)){
            request.setAttribute("contentPage", "admin/qnaOne.jsp");
            return "admin/qnaOne";
        } else {
        	return "redirect:/login";
        }
    }
    
//QnA 글쓰기
    @GetMapping("/addQna")
    public String addQnaForm(@RequestParam int lectureId, HttpServletRequest request) {
        
        // 리스트 상단 강의정보표시
        Map<String, Object> lectureInfoMap = qnaMapper.getLectureInfoByLectureId(lectureId);
        request.setAttribute("lectureTitle", lectureInfoMap.get("title"));
        request.setAttribute("lectureDay", lectureInfoMap.get("day"));
        request.setAttribute("lectureTime", lectureInfoMap.get("time"));
    	request.setAttribute("lectureId", lectureId);
    	return "student/addQna";
    }

    @PostMapping("/addQna")
    public String submitQna(HttpServletRequest request, 
    						@RequestParam("file") MultipartFile file) throws Exception {
    	//세션정보
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
        System.out.println("==> enrollmentId = " + enrollmentId);
        
        // 유효성 검사
        if (title == null || title.trim().isEmpty() || question == null || question.trim().isEmpty()) {
            request.setAttribute("errorMsg", "제목과 내용을 모두 입력해주세요");
            request.setAttribute("lectureId", lectureId);
            return "student/addQna";
        }
        if (enrollmentId != null) {
            Qna qna = new Qna();
            qna.setEnrollmentId(enrollmentId);
            qna.setTitle(title);
            qna.setQuestion(question);
            qna.setIsPublic(isPublic ? 1 : 0);
            
            // 파일 저장 처리
            if (file != null && !file.isEmpty()) {
                String uploadDir = "/home/ubuntu/upload";
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
        
        return "redirect:/qna?lectureId=" + lectureId;
    }

    //QnA 수정/삭제
//QnA 삭제
    @PostMapping("/deleteQna")
    public String deleteQna(@RequestParam("qnaId") int qnaId, 
    						@RequestParam("lectureId") int lectureId, 
    						HttpServletRequest request) {
    	//세션정보
    	HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;

        // 글 작성자 확인
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId);
        int qnaAdminId = qnaService.getAdminIdByQna(qnaId);
        // 학생 본인&관리자만 삭제 가능
        if (userId == qnaStudentId||userId == qnaAdminId) {
            // 답변 먼저 삭제
            qnaService.deleteAnswersByQnaId(qnaId);
            // 질문 삭제
            qnaService.deleteQna(qnaId);
        }
        return "redirect:/qna?lectureId=" + lectureId;
    }
    
//QnA 수정
    @GetMapping("/updateQna")
    public String updateQnaForm(@RequestParam("qnaId") int qnaId,
                                @RequestParam("lectureId") int lectureId,
                                HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;

        // 리스트 상단 강의정보표시
        Map<String, Object> lectureInfoMap = qnaMapper.getLectureInfoByLectureId(lectureId);
        request.setAttribute("lectureTitle", lectureInfoMap.get("title"));
        request.setAttribute("lectureDay", lectureInfoMap.get("day"));
        request.setAttribute("lectureTime", lectureInfoMap.get("time"));
        
        Qna qna = qnaService.getQnaOne(qnaId);
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId);

        // 본인 확인
        if (userId != qnaStudentId) {
            return "redirect:/qnaOne?id=" + qnaId + "&lectureId=" + lectureId;
        }

        request.setAttribute("qna", qna);
        request.setAttribute("lectureId", lectureId);
        return "student/updateQna";  
    }
    @PostMapping("/updateQna")
    public String updateQna(@RequestParam("qnaId") int qnaId,
                            @RequestParam("lectureId") int lectureId,
                            @RequestParam("title") String title,
                            @RequestParam("question") String question,
                            @RequestParam("isPublic") int isPublic,
                            @RequestParam("file") MultipartFile file,
                            HttpServletRequest request) throws Exception {

        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
            return "redirect:/login";
        }
        int userId = (int) userIdObj;

        // 작성자 확인
        int qnaStudentId = qnaService.getStudentIdByQna(qnaId);
        if (userId != qnaStudentId) {
            return "redirect:/qnaOne?id=" + qnaId + "&lectureId=" + lectureId;
        }
        // 유효성 검사
        if (title == null || title.trim().isEmpty() || question == null || question.trim().isEmpty()) {
            request.setAttribute("errorMsg", "제목과 내용을 모두 입력해주세요");
            request.setAttribute("lectureId", lectureId);
            request.setAttribute("qna", qnaService.getQnaOne(qnaId));
            return "student/updateQna";
        }
        
        Qna qna = new Qna();
        qna.setQnaId(qnaId);
        qna.setTitle(title);
        qna.setQuestion(question);
        qna.setIsPublic(isPublic);

        // 파일 수정 시 새로 저장
        if (file != null && !file.isEmpty()) {
            String uploadDir = "/home/ubuntu/upload";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            file.transferTo(targetFile);
            qna.setFileUrl("/semi/" + savedFilename);
        }

        qnaService.updateQna(qna);  
        return "redirect:/qnaOne?id=" + qnaId + "&lectureId=" + lectureId;
    }

    
    //QnA 답변
//QnA 답변달기
    @PostMapping("/addAnswer")
    public String addAnswer(@RequestParam("lectureId") int lectureId, QnaAnswer answer, HttpServletRequest request) {
        if (answer.getAnswer() == null || answer.getAnswer().trim().isEmpty()) {
            request.setAttribute("errorMsg", "답변 내용을 입력해주세요");
            return "redirect:/qnaOne?id=" + answer.getQnaId() + "&lectureId=" + lectureId;
        }
        // 세션 정보
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("loginUserId");
        if (userIdObj == null) {
        	return "redirect:/login";
        }
        int userId = (int) userIdObj;
        User user = loginService.findById(userId);
        String role = user.getRole();

        // 강사만 답변 허용
        if (!"instructor".equals(role)) {
            return "redirect:/qnaOne?id=" + answer.getQnaId() + "&lectureId=" + lectureId + "&error=unauthorized";
        }

        qnaService.insertAnswer(answer);
        return "redirect:/qnaOne?id=" + answer.getQnaId() + "&lectureId=" + lectureId;
    }
      
//QnA 답변삭제
      @PostMapping("/deleteAnswer")
      public String deleteAnswer(@RequestParam("answerId") int answerId,
                                 @RequestParam("qnaId") int qnaId, 
                                 @RequestParam("lectureId") int lectureId, 
                                 HttpServletRequest request) {
      	System.out.println("==> deleteAnswer 호출됨, answerId=" + answerId + ", qnaId=" + qnaId);
      	//세션정보
      	HttpSession session = request.getSession();
          Object userIdObj = session.getAttribute("loginUserId");
          if (userIdObj == null) {
              // 로그인 안된 상태 → 로그인 페이지로 이동
              return "redirect:/login";
          }
          int userId = (int) userIdObj;
          User user = loginService.findById(userId); 
          String role = user.getRole(); //user에 담겨있는정보로 role 역할 분리
          
          if (!"instructor".equals(role)&&!"admin".equals(role)) {
          	return "redirect:/qnaOne?id=" + qnaId + "&lectureId=" + lectureId;
          }
          qnaService.deleteAnswer(answerId);
          return "redirect:/qnaOne?id=" + qnaId + "&lectureId=" + lectureId;
      }

//내가 쓴 QnA글만 보기
      @GetMapping("/myQna")
      public String myQnaList(@RequestParam int lectureId, HttpServletRequest request) {
          HttpSession session = request.getSession();
          Object userIdObj = session.getAttribute("loginUserId");
          if (userIdObj == null) return "redirect:/login";

          // 리스트 상단 강의정보표시
          Map<String, Object> lectureInfoMap = qnaMapper.getLectureInfoByLectureId(lectureId);
          request.setAttribute("lectureTitle", lectureInfoMap.get("title"));
          request.setAttribute("lectureDay", lectureInfoMap.get("day"));
          request.setAttribute("lectureTime", lectureInfoMap.get("time"));
          
          int userId = (int) userIdObj;
          User user = loginService.findById(userId);
          String role = user.getRole();
          if (!"student".equals(role)) return "redirect:/qna?lectureId=" + lectureId;

          List<Map<String, Object>> myQnaList = qnaService.getMyQnaList(lectureId, userId);

          request.setAttribute("qnaList", myQnaList);
          request.setAttribute("lectureId", lectureId);
          request.setAttribute("currentPage", 1);
          request.setAttribute("totalPages", 1); // 페이징 안 했으면 1로 고정
          return "student/qnaList"; 
      }
}
