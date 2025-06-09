package com.example.academylms.service;

import com.example.academylms.dto.Notice;

import java.util.List;

public interface NoticeService {
    List<Notice> getNoticeList();
    Notice getNoticeById(int noticeId);
    void addNotice(Notice notice);
    void updateNotice(Notice notice);
    void deleteNotice(int noticeId);
}
