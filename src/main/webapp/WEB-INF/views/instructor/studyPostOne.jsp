<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>스터디 게시글 상세보기(강사)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<main class="main-container">
    <h2>스터디 게시글 상세보기</h2>

    <c:if test="${not empty message}">
        <div style="margin: 10px 0; color: green; font-weight: bold;">
            ${message}
        </div>
    </c:if>

    <form action="/instructor/studyPostOne" method="post">
        <input type="hidden" name="postId" value="${postId}" />
        <input type="hidden" name="groupId" value="${groupId}" />

        <table class="detail-table">
            <tr>
                <th>조번호</th>
                <td>${post.groupId}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${post.title}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td style="white-space: pre-wrap;">${post.content}</td>
            </tr>
            <tr>
                <th>피드백</th>
                <td>
                    <textarea name="feedback" class="feedback-textarea">${post.feedback}</textarea>
                </td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>${post.createDate}</td>
            </tr>
        </table>

        <br>
        <button type="submit" class="tag-btn">피드백 저장</button>
    </form>

    <br>
    <a href="/instructor/studyPost/${lectureId}" class="back-link">← 목록으로 돌아가기</a>
</main>

<div>
    <jsp:include page="../nav/footer.jsp" />
</div>
</body>
</html>
