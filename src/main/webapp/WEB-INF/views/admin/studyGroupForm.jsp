<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>스터디 그룹 생성(관리자)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- 사이드 내비 -->
<div>
    <jsp:include page="../nav/sideNav.jsp"></jsp:include>
</div>

<!-- 메인 콘텐츠 -->
<main class="main-container">
    <h2>스터디 그룹 생성</h2>

    <!-- ✅ 폼 박스 -->
    <div class="form-box">
        <form action="/admin/studyGroup/create" method="post">
            <input type="hidden" name="lectureId" value="${lectureId}" />

            <!-- ✅ 그룹 이름 입력 -->
            <div class="form-group">
                <label for="groupName">스터디 그룹 이름</label>
                <input type="text" id="groupName" name="groupName" placeholder="예: 프론트엔드 조" required />
            </div>

            <!-- ✅ 조장 선택 -->
            <div class="form-group">
                <label for="studentId">조장 선택 (선택)</label>
                <select name="studentId" id="studentId">
                    <option value="">-- 선택 안함 --</option>
                    <c:forEach var="student" items="${students}">
                        <option value="${student.studentId}">
                            ${student.name} (${student.email})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 에러 메시지 -->
            <c:if test="${not empty errorMsg}">
                <p class="error-msg">${errorMsg}</p>
            </c:if>

            <!-- 제출 버튼 -->
            <button type="submit" class="submit-btn">그룹 생성</button>
        </form>
    </div>

    <!-- 돌아가기 링크 -->
    <a href="/admin/studentList/${lectureId}" class="back-link">← 수강생 목록으로 돌아가기</a>
</main>

<!-- 푸터 -->
<div>
    <jsp:include page="../nav/footer.jsp"></jsp:include>
</div>

</body>
</html>
