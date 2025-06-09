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
	<h1>강사 퀴즈 목록</h1>
	<a href="/addQuiz?lectureId=${lectureId}">퀴즈 추가</a>
		<table border="1">
		<c:forEach var="quizList" items="${quizList}">
			<tr>
				<th>${quizList.week}주차</th>
				<td>${quizList.startedAt} ~ ${quizList.endedAt}</td>
				<c:if test="${now >= quizList.startedAt && now <= quizList.endedAt}">
					<td><a href="">수정하기</a></td>
				</c:if>
				<c:if test="${now < quizList.startedAt || now > quizList.endedAt}">
					<td><a href="">결과보기</a></td>
				</c:if>
			</tr>
		</c:forEach>
		</table>
</main>
</body>
</html>