<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>스터디 게시글 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- 사이드 네비게이션 -->
<div>
    <jsp:include page="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
    <h2>게시글 상세보기</h2>

    <div class="detail-box">
        <table class="detail-table">
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
                <td><pre>${post.content}</pre></td>
            </tr>
            <tr>
                <th>피드백</th>
                <td><pre>${post.feedback}</pre></td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>${post.createDate}</td>
            </tr>
        </table>

        <div class="form-actions">
            <a href="/admin/studyPost/${lectureId}" class="back-link">← 목록으로 돌아가기</a>
        </div>
    </div>
</main>

<!-- 푸터 -->
<div>
    <jsp:include page="../nav/footer.jsp"></jsp:include>
</div>

</body>
</html>
