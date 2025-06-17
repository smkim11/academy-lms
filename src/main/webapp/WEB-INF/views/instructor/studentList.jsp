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

<a href="/instructor/studyGroupForm?lectureId=${lectureId}">스터디 그룹 생성</a>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>가입일</th>
            <th>스터디 그룹 번호</th>
            <th>스터디 그룹 배정</th>
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
				    <c:choose>
				        <c:when test="${groupMap[student.studentId] != null}">
				            ${groupMap[student.studentId]}조
				        </c:when>
				        <c:otherwise>
				            미배정
				        </c:otherwise>
				    </c:choose>
				</td>

		        <td>
		            <form method="post" action="/instructor/studyGroup/changeGroup">
		                <input type="hidden" name="lectureId" value="${lectureId}" />
		                <input type="hidden" name="studentId" value="${student.studentId}" />
		                <select name="newGroupId" required>
		                    <option value="">-- 조 선택 --</option>
		                    <c:forEach var="gid" items="${groupIds}">
		                        <option value="${gid}" <c:if test="${groupMap[student.studentId] == gid}">selected</c:if>>${gid}조</option>
		                    </c:forEach>
		                </select>
		                <button type="submit">조 변경</button>
		            </form>
		        </td>
		    </tr>
		    <c:set var="studentIdStr" value="${student.studentId}" />

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
