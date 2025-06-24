<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 - 관리자</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- 사이드 메뉴 -->
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<main class="main-container">
    <h1>공지사항 수정 (관리자)</h1>

    <div class="form-container">
        <form action="/admin/updateNotice" method="post">
            <input type="hidden" name="noticeId" value="${notice.noticeId}" />
            <input type="hidden" name="lectureId" value="${notice.lectureId}" />

            <table class="form-table">
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="title" required value="${notice.title}" style="width: 100%;" />
                    </td>
                </tr>
                <tr>
                    <th>유형</th>
                    <td>
                        <select name="noticeType" required>
                            <option value="">-- 선택 --</option>
                            <option value="general" ${notice.noticeType == 'general' ? 'selected' : ''}>일반</option>
                            <option value="schedule" ${notice.noticeType == 'schedule' ? 'selected' : ''}>일정</option>
                            <option value="exam" ${notice.noticeType == 'exam' ? 'selected' : ''}>시험</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="content" rows="10" style="width: 100%;" required>${notice.content}</textarea>
                    </td>
                </tr>
            </table>

            <div class="form-actions">
                <button type="submit" class="btn-submit">공지 수정</button>
                <a href="/admin/noticeList/${lecture.lectureId}" class="back-link">← 목록으로</a>
            </div>
        </form>
    </div>
</main>

<!-- 푸터 -->
<div>
    <jsp:include page="../nav/footer.jsp" />
</div>

</body>
</html>
