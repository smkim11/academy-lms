<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${lecture.title} - 공지사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- ✅ 내비게이션 -->
<div>
<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<!-- ✅ 본문 컨텐츠 -->
<main class="content">
    <h2>${lecture.title} - 공지사항</h2>
    <table class="notice-table">
        <thead>
            <tr>
                <th>제목</th>
                <th>유형</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td>
                        <a href="/student/noticeListOne/${lecture.lectureId}/${notice.noticeId}">
                            ${notice.title}
                        </a>
                    </td>
                    <td>${notice.noticeType}</td>
                    <td>${notice.createDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <br>
    <a href="/student/lectureOne?lectureId=${lectureId}" class="back-link">← 강의페이지로 돌아가기</a>
</main>
<div>
   <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
