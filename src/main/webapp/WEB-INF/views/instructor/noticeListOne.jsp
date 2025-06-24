<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${notice.title} - 공지 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<main class="main-container">
    <h2>${lecture.title} - 공지 상세 (강사용)</h2>

    <div class="notice-detail-box">
        <h3>${notice.title}</h3>
        <p><strong>유형:</strong> ${notice.noticeType}</p>
        <p><strong>작성일:</strong> ${notice.createDate}</p>

        <hr>

        <div class="notice-content">
            <p>${notice.content}</p>
        </div>
    </div>

    <br>
    <a href="/instructor/noticeList/${lecture.lectureId}" class="back-link">← 공지 목록으로</a>
</main>

<div>
    <jsp:include page="../nav/footer.jsp" />
</div>
</body>
</html>
