<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>학생 목록</title>
</head>
<body>

<h2>학생 목록</h2>

<!-- 🔍 검색 폼 -->
<form method="get" action="/admin/studentList">
    <input type="text" name="searchWord" value="${page.searchWord}" placeholder="이름 검색" />
    <button type="submit">검색</button>
</form>

<!-- 학생 등록 -->
<a href="/admin/addStudent">학생 등록</a>

<!-- 📋 학생 리스트 테이블 -->
<table border="1">
    <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>가입일</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="student" items="${students}">
            <tr>
                <td>${student.name}</td>
                <td>${student.email}</td>
                <td>${student.phone}</td>
                <td>${student.createDate}</td>
                <td>
                	<a href="/admin/updateStudent">수정</a>
                	<a href="/">삭제</a>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty students}">
            <tr>
                <td colspan="4">검색 결과가 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- 📄 페이지네이션 -->
<div>
    <c:forEach begin="1" end="${page.lastPage}" var="i">
        <a href="?page=${i}&searchWord=${page.searchWord}">
            <c:choose>
                <c:when test="${i == page.currentPage}"><b>[${i}]</b></c:when>
                <c:otherwise>[${i}]</c:otherwise>
            </c:choose>
        </a>
    </c:forEach>
</div>

</body>
</html>
