<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>강의별 수강생 목록(강사)</title>
</head>
<body>

<h2>강의별 수강생 목록</h2>

<!-- 🔍 검색 폼 -->
<form method="get" action="/instructor/studentList/${lectureId}">
    <input type="text" name="searchWord" placeholder="이름 검색" value="${searchWord}" />
    <button type="submit">검색</button>
</form>

<br/>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>가입일</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="student" items="${students}">
            <tr>
                <td>${student.name}</td>
                <td>${student.email}</td>
                <td>${student.phone}</td>
                <td>${student.createDate}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty students}">
            <tr>
                <td colspan="4">수강생이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- 페이지 네비게이션 -->
<div style="margin-top:10px;">
    <c:forEach begin="1" end="${totalPage}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <b>[${i}]</b>
            </c:when>
            <c:otherwise>
                <a href="/instructor/studentList/${lectureId}?page=${i}&searchWord=${searchWord}">[${i}]</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>

</body>
</html>
