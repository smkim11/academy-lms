<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>스터디 게시글 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
    <h2>조 ${groupId} - 새 게시글 작성</h2>

    <form action="/student/addStudyPost" method="post" class="form-container">
        <input type="hidden" name="groupId" value="${groupId}" />

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required />
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="8" required></textarea>
        </div>

        <button type="submit" class="submit-btn">작성</button>
    </form>

    <br>
    <a href="/student/studyPost/${lectureId}" class="back-link">← 목록으로 돌아가기</a>
</main>

<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>

</body>
</html>
