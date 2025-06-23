<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>전체 학생 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main class="main-container">
    <h1>전체 학생 목록</h1>
		
<!-- 검색 -->
<form method="get" action="">
    <input type="text" name="searchWord" placeholder="이름 검색" value="${searchWord}">
    <input type="hidden" name="lectureId" value="${lectureId}">
    <button type="submit">검색</button>
</form>
<c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
</c:if>
<c:if test="${not empty success}">
    <p style="color:green;">${success}</p>
</c:if>
<!-- 테이블 -->
<table border="1">
    <thead>
        <tr>
            <th>학생 ID</th>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>등록일</th>
            <th>강의 등록</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="s" items="${students}">
            <tr>
                <td>${s.studentId}</td>
                <td>${s.name}</td>
                <td>${s.email}</td>
                <td>${s.phone}</td>
                <td>${s.createDate}</td>
                <td>
				    <form action="/admin/addStudent" method="post" style="display:inline;">
				        <input type="hidden" name="studentId" value="${s.studentId}" />
				        <input type="hidden" name="lectureId" value="${lectureId}" />
				        <button type="submit">등록</button>
				    </form>
				</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<br>
<a href="/admin/studentList/${lectureId}">← 수강생 목록으로 돌아가기</a>

<!-- 페이징 -->
<div class="pagination">
    <c:if test="${hasPrevious}">
        <a href="?lectureId=${lectureId}&page=${previousPage}&searchWord=${searchWord}">◀ 이전</a>
    </c:if>
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <a href="?lectureId=${lectureId}&page=${i}&searchWord=${searchWord}" 
           style="${i == page.currentPage ? 'font-weight:bold; color:red;' : ''}">
           ${i}
        </a>
    </c:forEach>
    <c:if test="${hasNext}">
        <a href="?lectureId=${lectureId}&page=${nextPage}&searchWord=${searchWord}">다음 ▶</a>
    </c:if>
</div>
</main>
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
