package com.example.academylms.mapper;

import com.example.academylms.dto.Notice;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NoticeMapper {
    List<Notice> selectAllNotices();
    Notice selectNoticeById(int noticeId);
    void addNotice(Notice notice);
    void updateNotice(Notice notice);
    void deleteNotice(int noticeId);
    List<Notice> selectNoticesByLectureId(int lectureId);
}
