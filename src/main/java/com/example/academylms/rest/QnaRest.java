package com.example.academylms.rest;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.academylms.dto.Qna;
import com.example.academylms.dto.QnaAnswer;
import com.example.academylms.service.QnaService;


@RestController
@RequestMapping("/api/qna")
public class QnaRest {

    @Autowired
    private QnaService qnaService;

    // QnA 목록 (페이징)
    @GetMapping("/list")
    public Map<String, Object> getQnaList(@RequestParam int lectureId,
                                          @RequestParam(defaultValue = "1") int page,
                                          @RequestParam(defaultValue = "10") int pageSize) {
        int offset = (page - 1) * pageSize;
        List<Map<String, Object>> list = qnaService.getQnaListByPage(lectureId, offset, pageSize);
        int total = qnaService.getQnaCount(lectureId);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        Map<String, Object> result = new HashMap<>();
        result.put("qnaList", list);
        result.put("totalPages", totalPages);
        result.put("currentPage", page);
        return result;
    }

    // QnA 상세 보기
    @GetMapping("/{qnaId}")
    public Map<String, Object> getQnaOne(@PathVariable int qnaId) {
        Qna qna = qnaService.getQnaOne(qnaId);
        List<QnaAnswer> answers = qnaService.selectQnaAnswer(qnaId);

        Map<String, Object> result = new HashMap<>();
        result.put("qna", qna);
        result.put("answers", answers);
        return result;
    }

    // QnA 작성
    @PostMapping("/add")
    public String addQna(@RequestParam int studentId,
                         @RequestParam int lectureId,
                         @RequestParam String title,
                         @RequestParam String question,
                         @RequestParam(defaultValue = "1") int isPublic,
                         @RequestParam(required = false) MultipartFile file) throws Exception {

        if (title == null || title.trim().isEmpty()) return "제목은 필수입니다";
        if (question == null || question.trim().isEmpty()) return "내용은 필수입니다";

        Integer enrollmentId = qnaService.getEnrollmentId(studentId, lectureId);
        if (enrollmentId == null) return "수강 정보 없음";

        Qna qna = new Qna();
        qna.setEnrollmentId(enrollmentId);
        qna.setTitle(title);
        qna.setQuestion(question);
        qna.setIsPublic(isPublic);

        if (file != null && !file.isEmpty()) {
            String uploadDir = "C:/semi";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            file.transferTo(targetFile);
            qna.setFileUrl("/semi/" + savedFilename);
        }

        qnaService.insertQna(qna);
        return "작성 완료";
    }

    // QnA 수정
    @PostMapping("/update")
    public String updateQna(@RequestParam int qnaId,
                            @RequestParam String title,
                            @RequestParam String question,
                            @RequestParam int isPublic,
                            @RequestParam(required = false) MultipartFile file) throws Exception {
        Qna qna = new Qna();
        qna.setQnaId(qnaId);
        qna.setTitle(title);
        qna.setQuestion(question);
        qna.setIsPublic(isPublic);

        if (file != null && !file.isEmpty()) {
            String uploadDir = "C:/semi";
            String originalFilename = file.getOriginalFilename();
            String savedFilename = UUID.randomUUID() + "_" + originalFilename;
            File targetFile = new File(uploadDir, savedFilename);
            file.transferTo(targetFile);
            qna.setFileUrl("/semi/" + savedFilename);
        }

        qnaService.updateQna(qna);
        return "수정 완료";
    }

    // QnA 삭제
    @DeleteMapping("/{qnaId}")
    public String deleteQna(@PathVariable int qnaId) {
        if (qnaId <= 0) return "잘못된 QnA ID";

        qnaService.deleteAnswersByQnaId(qnaId);
        qnaService.deleteQna(qnaId);
        return "삭제 완료";
    }
    
    // QnA 답변 등록
    @PostMapping("/answer/add")
    public String addAnswer(@RequestBody QnaAnswer answer) {
        if (answer == null || answer.getQnaId() == 0 || answer.getAnswer() == null || answer.getAnswer().trim().isEmpty()) {
            return "답변 내용이 비어있습니다";
        }
        qnaService.insertAnswer(answer);
        return "답변 완료";
    }

    // QnA 답변 삭제
    @DeleteMapping("/answer/{answerId}")
    public String deleteAnswer(@PathVariable int answerId) {
        if (answerId <= 0) return "잘못된 답변 ID";

        qnaService.deleteAnswer(answerId);
        return "답변 삭제 완료";
    }

    // 내 QnA 목록
    @GetMapping("/my")
    public List<Map<String, Object>> getMyQnaList(@RequestParam int lectureId,
                                                  @RequestParam int studentId) {
        return qnaService.getMyQnaList(lectureId, studentId);
    }

    // 특정 QnA 작성자의 ID (검증용)
    @GetMapping("/writer/{qnaId}")
    public Map<String, Object> getQnaWriter(@PathVariable int qnaId) {
        int studentId = qnaService.getStudentIdByQna(qnaId);
        int adminId = qnaService.getAdminIdByQna(qnaId);
        Map<String, Object> result = new HashMap<>();
        result.put("studentId", studentId);
        result.put("adminId", adminId);
        return result;
    }
}