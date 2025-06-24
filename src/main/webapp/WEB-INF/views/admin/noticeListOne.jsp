<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${notice.title} - 공지 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- 사이드 메뉴 -->
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
    <h2>${lecture.title} - 공지 상세</h2>

    <!-- 공지 상세 박스 -->
    <div class="notice-detail-box">
        <h3>${notice.title}</h3>
        <p><strong>유형:</strong> ${notice.noticeType}</p>
        <p><strong>작성일:</strong> ${notice.createDate}</p>

        <hr>

        <div class="notice-content">
            <p>${notice.content}</p>
        </div>
    </div>

    <!-- 돌아가기 링크 -->
    <a href="/admin/noticeList/${lecture.lectureId}" class="back-link">← 공지 목록으로</a>
</main>

<!-- 푸터 -->
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>

</body>
</html>
