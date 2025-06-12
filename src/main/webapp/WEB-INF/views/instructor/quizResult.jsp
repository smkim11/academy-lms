<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
<div class="top-bar">
  <div class="logo">MyLMS</div>
  <div class="user-info">
    <div class="user-name">${loginUserId }님</div>
    <a class="edit-profile" href="/mypage">개인정보 수정</a>
  </div>
</div>
<div class="side-bar">
  <ul>
    <li><a href="#">대시보드</a></li>
    <li><a href="#">강의목록</a></li>
    <li><a href="#">수강관리</a></li>
    <li><a href="#">설정</a></li>
  </ul>
</div>
	
<main>
	<h1>강사용 퀴즈 결과</h1>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>작성한 답</th>
			<th>정답</th>
			<th>O/X</th>
		</tr>
		<c:forEach var="resultList" items="${resultList}">
			<tr>
				<th>${resultList.quizNo }</th>
				<td>${resultList.answer }</td>
				<td>${resultList.correctAnswer }</td>
				<th>${resultList.isCorrect }</th>
			</tr>
		</c:forEach>
		<tr>
			<th colspan="2">점수</th>
			<th colspan="2">${score }점</th>
		</tr>
	</table>
	
	<table border="1">
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
</main>
</body>
</html>