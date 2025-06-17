<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
<link rel="stylesheet" href="/css/styles.css">
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