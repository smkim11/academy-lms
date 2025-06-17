<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main>
	<h1>${week}주차 퀴즈 ${status}</h1>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
	<table border="1">
		<tr>
			<th>이름</th>
			<th>상태</th>
			<th>점수</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<th>${list.name }</th>
				<!-- 리스트에 값이 넘어오면 응시한 학생, 안넘어오면 미응시한 학생 -->
				<c:if test="${list.status != null && list.score != null }">
					<td>${list.status }</td>
					<td>${list.score }</td>
				</c:if>
				<c:if test="${list.status == null && list.score == null }">
					<td>미응시</td>
					<td>-</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</main>
</body>
</html>