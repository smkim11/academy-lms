<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>스터디 게시글 작성</title>
</head>
<body>
    <h2>조 ${groupId} - 새 게시글 작성</h2>

    <form action="/admin/addStudyPost" method="post">
        <input type="hidden" name="groupId" value="${groupId}" />
        <p>
            제목: <input type="text" name="title" required />
        </p>
        <p>
            내용:<br>
            <textarea name="content" rows="8" cols="50" required></textarea>
        </p>
        <button type="submit">작성</button>
    </form>

    <br>
    <a href="/admin/studyPost/${lectureId}">← 목록으로 돌아가기</a>
</body>
</html>
