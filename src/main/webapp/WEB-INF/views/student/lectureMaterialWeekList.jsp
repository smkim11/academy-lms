<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>강의자료 주차별 목록</title>
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
    <h2>강의자료 주차별 보기</h2>
    <ul>
<c:forEach var="week" items="${weekList}">
    <li>
        <a href="/lectureMaterialList?weekId=${week.weekId}">
            ${week.week}주차
        </a>
    </li>
</c:forEach>

			<a href="/student/lectureOne?lectureId=${lectureId}">
			    강의정보로 돌아가기
			</a>
    </ul>
</main>
</body>
</html>