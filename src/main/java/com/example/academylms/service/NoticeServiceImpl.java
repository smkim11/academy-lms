package com.example.academylms.service;

import com.example.academylms.dto.Notice;
import com.example.academylms.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public List<Notice> getNoticeList() {
        return noticeMapper.selectAllNotices();
    }

    @Override
    public Notice getNoticeById(int noticeId) {
        return noticeMapper.selectNoticeById(noticeId);
    }

    @Override
    public void addNotice(Notice notice) {
        noticeMapper.addNotice(notice);
    }

    @Override
    public void updateNotice(Notice notice) {
        noticeMapper.updateNotice(notice);
    }

    @Override
    public void deleteNotice(int noticeId) {
        noticeMapper.deleteNotice(noticeId);
    }
    
    
}
