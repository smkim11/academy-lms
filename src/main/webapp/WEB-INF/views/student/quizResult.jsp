<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/quizStyles.css">
<style>
.quiz-tables-wrapper {
  display: flex;
  gap: 20px;
  justify-content: center;
  align-items: flex-start;
  flex-wrap: wrap;
}

.quiz-tables-wrapper .result-table {
  width: 30%;
}

.quiz-tables-wrapper .explanation-table {
  width: 65%;
}
</style>
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main>
	<h1 class="page-title">${week}주차 퀴즈 결과</h1>
	<div class="quiz-tables-wrapper">
		<table class="quiz-table result-table">
			<tr>
				<th>번호</th>
				<th>작성한 답</th>
				<th>정답</th>
				<th>O/X</th>
			</tr>
			<c:forEach var="resultList" items="${resultList}">
			<c:if test="${resultList.isCorrect eq 'O' }">
				<tr>
					<th>${resultList.quizNo }</th>
					<td>${resultList.answer }</td>
					<td>${resultList.correctAnswer }</td>
					<th>${resultList.isCorrect }</th>
				</tr>
			</c:if>
			<c:if test="${resultList.isCorrect eq 'X' }">
				<tr>
					<th style="color:red;">${resultList.quizNo }</th>
					<td style="color:red;">${resultList.answer }</td>
					<td style="color:red;">${resultList.correctAnswer }</td>
					<th style="color:red;">${resultList.isCorrect }</th>
				</tr>
			</c:if>
			</c:forEach>
			<tr>
				<th colspan="2">점수</th>
				<th colspan="2">${score }점</th>
			</tr>
		</table>
		
		<table class="quiz-table explanation-table">
			<tr>
				<th>번호</th>
				<th>문제</th>
				<th>해설</th>
			</tr>
			<c:forEach var="explainList" items="${explainList}">
				<tr>
					<th>${explainList.quizNo}</th>
					<td>${explainList.question}</td>
					<td>${explainList.explanation}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>