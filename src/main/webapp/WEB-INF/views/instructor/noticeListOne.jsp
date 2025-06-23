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
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main class="main-container">
    <h2>${lecture.title} - 공지 상세 (강사용)</h2>
    
    <h3>${notice.title}</h3>
    <p><strong>유형:</strong> ${notice.noticeType}</p>
    <p><strong>작성일:</strong> ${notice.createDate}</p>
    <hr>
    <p>${notice.content}</p>

    <br>
    <a href="/instructor/noticeList/${lecture.lectureId}">← 공지 목록으로</a>
    </main>
    <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>