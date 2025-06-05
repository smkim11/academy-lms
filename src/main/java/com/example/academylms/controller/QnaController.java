package com.example.academylms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.academylms.dto.Qna;
import com.example.academylms.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QnaController {
    @Autowired
    private QnaService qnaService;

    @GetMapping("/qna")
    public String qnaList(HttpServletRequest request) {
        List<Qna> list = qnaService.getQnaList();
        request.setAttribute("qnaList", list);
        request.setAttribute("contentPage", "instructor/qnaList.jsp");
        return "instructor/qnaList";
    }
}
