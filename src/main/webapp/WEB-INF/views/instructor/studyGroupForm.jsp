<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>스터디 그룹 생성(강사)</title>
</head>
<body>
<h2>스터디 그룹 생성(강사)</h2>

<form action="/instructor/studyGroup/create" method="post">
    <input type="hidden" name="lectureId" value="${lectureId}" />
	
	<label>스터디 그룹 이름: </label>
    <input type="text" name="groupName" required placeholder="예: 프론트엔드 조" />
    <br/><br/>
	
    <label>조장 선택 (선택): </label>
    <select name="studentId" required>
        <option value="">-- 선택 안함 --</option>
        <c:forEach var="student" items="${students}">
            <option value="${student.studentId}">${student.name} (${student.email})</option>
        </c:forEach>
    </select>
    <c:if test="${not empty errorMsg}">
	    <p style="color: red;">${errorMsg}</p>
	</c:if>
    <br/><br/>

    <button type="submit">그룹 생성</button>
</form>

<br/>
<a href="/instructor/studentList/${lectureId}">← 수강생 목록으로 돌아가기</a>

</body>
</html>
