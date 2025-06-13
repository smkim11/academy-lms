<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 수정</title>
</head>
<body>
    <h2>게시글 수정</h2>

    <form action="/student/updateStudyPost" method="post">
        <input type="hidden" name="postId" value="${post.postId}" />
        <input type="hidden" name="groupId" value="${post.groupId}" />

        <p>제목: <input type="text" name="title" value="${post.title}" required /></p>
        <p>내용:<br>
            <textarea name="content" rows="8" cols="50" required>${post.content}</textarea>
        </p>

        <button type="submit">수정하기</button>
    </form>

    <br>
    <a href="/student/studyPostOne/${post.postId}">← 취소하고 돌아가기</a>
</body>
</html>
