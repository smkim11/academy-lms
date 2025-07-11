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
    <jsp:include page="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
    <h2>전체 학생 목록</h2>

    <!-- 🔍 검색 -->
    <form method="get" action="" class="search-form">
        <input type="text" name="searchWord" placeholder="이름 검색" value="${searchWord}" />
        <input type="hidden" name="lectureId" value="${lectureId}" />
        <button type="submit">검색</button>
    </form>

    <!-- ✅ 메시지 -->
    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color:green;">${success}</p>
    </c:if>

    <!-- 📋 학생 목록 테이블 -->
    <div class="post-table">
        <table>
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
                            <form action="/admin/addStudent" method="post" class="group-form">
                                <input type="hidden" name="studentId" value="${s.studentId}" />
                                <input type="hidden" name="lectureId" value="${lectureId}" />
                                <button type="submit">등록</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty students}">
                    <tr>
                        <td colspan="6">학생 데이터가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 🔙 돌아가기 -->
    <a href="/admin/studentList/${lectureId}" class="back-link">← 수강생 목록으로 돌아가기</a>

    <!-- 📄 페이징 -->
    <div class="pagination">
        <c:if test="${hasPrevious}">
            <a href="?lectureId=${lectureId}&page=${previousPage}&searchWord=${searchWord}">◀ 이전</a>
        </c:if>

        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <c:choose>
                <c:when test="${i == page.currentPage}">
                    <span class="current-page">[${i}]</span>
                </c:when>
                <c:otherwise>
                    <a href="?lectureId=${lectureId}&page=${i}&searchWord=${searchWord}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${hasNext}">
            <a href="?lectureId=${lectureId}&page=${nextPage}&searchWord=${searchWord}">다음 ▶</a>
        </c:if>
    </div>
</main>

<div>
    <jsp:include page="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
