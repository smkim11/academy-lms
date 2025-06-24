<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>스터디 그룹 생성(강사)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<main class="main-container">
    <h2>스터디 그룹 생성</h2>

    <form action="/instructor/studyGroup/create" method="post" class="form-box">
        <input type="hidden" name="lectureId" value="${lectureId}" />

        <div class="form-group">
            <label for="groupName">스터디 그룹 이름</label>
            <input type="text" id="groupName" name="groupName" required placeholder="예: 프론트엔드 조" />
        </div>

        <div class="form-group">
            <label for="studentId">조장 선택 (선택)</label>
            <select id="studentId" name="studentId">
                <option value="">-- 선택 안함 --</option>
                <c:forEach var="student" items="${students}">
                    <option value="${student.studentId}">
                        ${student.name} (${student.email})
                    </option>
                </c:forEach>
            </select>
        </div>

        <c:if test="${not empty errorMsg}">
            <p class="error-msg">${errorMsg}</p>
        </c:if>

        <button type="submit" class="submit-btn">그룹 생성</button>
    </form>

    <br />
    <a href="/instructor/studentList/${lectureId}" class="back-link">← 수강생 목록으로 돌아가기</a>
</main>

<div>
    <jsp:include page="../nav/footer.jsp" />
</div>
</body>
</html>
