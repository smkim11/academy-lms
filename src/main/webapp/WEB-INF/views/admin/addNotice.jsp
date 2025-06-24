<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>공지사항 등록(관리자)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<!-- 사이드바 -->
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<!-- 메인 -->
<main class="main-container">
    <h2>${lecture.title} - 공지사항 등록</h2>

    <div class="form-container">
        <form action="/admin/addNotice" method="post">
            <input type="hidden" name="lectureId" value="${lecture.lectureId}" />

            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required placeholder="공지 제목을 입력하세요">
            </div>

            <div class="form-group">
                <label for="noticeType">공지 유형</label>
                <select id="noticeType" name="noticeType" required>
                    <option value="">-- 선택 --</option>
                    <option value="general">일반</option>
                    <option value="schedule">일정</option>
                    <option value="exam">시험</option>
                </select>
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="8" class="feedback-textarea" required></textarea>
            </div>

            <div style="margin-top: 20px;">
                <button type="submit" class="submit-btn">등록</button>
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
