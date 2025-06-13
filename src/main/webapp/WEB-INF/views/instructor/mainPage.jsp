<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
	<div class="top-bar">
	  <div class="logo">MyLMS</div>
	  <div class="user-info">
	    <div class="user-name">홍길동님</div>
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
		<h2>강의관리</h2>
	
		<h3>진행중인 강의</h3>
		<c:if test="${empty ongoingLectures}">
		    <p>수강중인 강의가 없습니다.</p>
		</c:if>
		<ul>
		    <c:forEach var="lecture" items="${ongoingLectures}">
		        <li>
		            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
		                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
		            </a>
		        </li>
		    </c:forEach>
		</ul>
		
		<h3>진행예정 강의</h3>
		<c:if test="${empty upcomingLectures}">
		    <p>수강예정 강의가 없습니다.</p>
		</c:if>
		<ul>
		    <c:forEach var="lecture" items="${upcomingLectures}">
		        <li>
		            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
		                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
		            </a>
		        </li>
		    </c:forEach>
		</ul>
		
		<h3>종료된 강의</h3>
		<c:if test="${empty endedLectures}">
		    <p>종료된 강의가 없습니다.</p>
		</c:if>
		<ul>
		    <c:forEach var="lecture" items="${endedLectures}">
		        <li>
		            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
		                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
		            </a>
		        </li>
		    </c:forEach>
		</ul>
	</main>
</body>
</html>