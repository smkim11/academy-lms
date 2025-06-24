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

    <form action="/admin/addStudyPost" method="post">
        <input type="hidden" name="groupId" value="${groupId}" />
        
        <label for="title">제목:</label><br/>
        <input type="text" id="title" name="title" required style="width: 100%; max-width: 600px;" />
        
        <br/><br/>
        
        <label for="content">내용:</label><br/>
        <textarea id="content" name="content" rows="10" cols="60" required style="width: 100%; max-width: 600px;"></textarea>
        
        <br/><br/>
        
        <button type="submit">작성</button>
    </form>

    <br/>
    <a href="/admin/studyPost/${lectureId}" class="back-link">← 목록으로 돌아가기</a>
</main>
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
