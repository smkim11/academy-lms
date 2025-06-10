package com.example.academylms.rest;

import com.example.academylms.dto.Notice;
import com.example.academylms.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notices")
public class NoticeRest {

    @Autowired
    private NoticeService noticeService;

    // 특정 공지 조회
    @GetMapping("/{id}")
    public Notice getNotice(@PathVariable int id) {
        return noticeService.getNoticeById(id);
    }

    // 공지 등록
    @PostMapping
    public void addNotice(@RequestBody Notice notice) {
        noticeService.addNotice(notice);
    }

    // 공지 수정
    @PutMapping("/{id}")
    public void updateNotice(@PathVariable int id, @RequestBody Notice notice) {
        notice.setNoticeId(id);
        noticeService.updateNotice(notice);
    }

    // 공지 삭제
    @DeleteMapping("/{id}")
    public void deleteNotice(@PathVariable int id) {
        noticeService.deleteNotice(id);
    }
}
