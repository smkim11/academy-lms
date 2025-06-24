<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
    <title>스터디 게시글 상세보기</title>
</head>
<body>
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main class="main-container">
<h2>게시글 상세보기</h2>

<table class="post-table">
    <tr>
        <th>조</th>
        <td>${post.groupId}</td>
    </tr>
    <tr>
        <th>제목</th>
        <td>${post.title}</td>
    </tr>
    <tr>
        <th>내용</th>
        <td>${post.content}</td>
    </tr>
    <tr>
        <th>피드백</th>
        <td>${post.feedback}</td>
    </tr>
    <tr>
        <th>작성일</th>
        <td>${post.createDate}</td>
    </tr>
</table>

<br>
<a href="/student/studyPost/${lectureId}" class="back-link">← 목록으로 돌아가기</a>
</main>
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
