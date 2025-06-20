<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/quizStyles.css">
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main>
	<h1 class="page-title">${week}주차 퀴즈 ${status}</h1>
	<table class="quiz-table">
		<tr>
			<th>이름</th>
			<th>상태</th>
			<c:forEach var="list" items="${quizNo }">
				<th>${list.quizNo}번</th>
			</c:forEach>
			<th>점수</th>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<th>${list.name }</th>
				<!-- 리스트에 값이 넘어오면 응시한 학생, 안넘어오면 미응시한 학생 -->
				<c:if test="${list.status != null && list.score != null }">
					<td>${list.status }</td>
					<!-- 문항별 정오 -->
					<c:forEach var="i" begin="0" end="${fn:length(list.isCorrect) - 1}">
						<c:if test="${list.isCorrect[i] eq 'O'}">
							<td>${list.isCorrect[i]}</td>
						</c:if>
						<c:if test="${list.isCorrect[i] eq 'X'}">
							<td style="color:red;'">${list.isCorrect[i]}</td>
						</c:if>
					</c:forEach>
					<td>${list.score }</td>
				</c:if>
				<c:if test="${list.status == null && list.score == null }">
					<td>미응시</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<a class="back-link" href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>