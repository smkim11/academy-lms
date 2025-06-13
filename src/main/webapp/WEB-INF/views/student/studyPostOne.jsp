<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>스터디 게시글 상세보기</title>
</head>
<body>

<h2>게시글 상세보기</h2>

<table border="1">
    <tr>
        <th>조 번호</th>
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
<a href="/student/studyPost/${lectureId}">← 목록으로 돌아가기</a>

</body>
</html>
