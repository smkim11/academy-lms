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
	    <li><a href="/mainPage">메인페이지</a></li>
	    <li><a href="/lectureMainPage">강의목록</a></li>
	  </ul>
	</div>
<main>
	    <div style="width: 50%;"> 
	        <h2>관리자 전용</h2>
	        <ul>
	            <li><a href="/admin/studentList">수강생 관리 페이지로 이동</a></li>
	        </ul>
	        <ul>
	            <li><a href="/admin/statistics">통계 페이지로 이동</a></li>
	        </ul>

	        <h2>마이페이지</h2>
	        <ul>
		        <li><a class="edit-profile" href="/admin/mypage">개인정보 수정</a></li>
	        </ul>
	    </div>
</main>
</body>
</html>