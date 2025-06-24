<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main class="main-container">
    <h2>게시글 수정</h2>

    <form action="/admin/updateStudyPost" method="post">
        <input type="hidden" name="postId" value="${post.postId}" />
        <input type="hidden" name="groupId" value="${post.groupId}" />

        <label for="title">제목:</label><br/>
        <input type="text" id="title" name="title" value="${post.title}" required style="width: 100%; max-width: 600px;" />

        <br/><br/>

        <label for="content">내용:</label><br/>
        <textarea id="content" name="content" rows="10" cols="60" required style="width: 100%; max-width: 600px;">${post.content}</textarea>

        <br/><br/>

        <button type="submit">수정하기</button>
    </form>

    <br/>
    <a href="/admin/studyPostOne/${post.postId}" class="back-link">← 취소하고 돌아가기</a>
</main>
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
