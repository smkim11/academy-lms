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
	<h2>강의자료 등록 / 수정</h2>
	<form action="<c:choose>
	                <c:when test='${not empty material}'>/updateLectureMaterial</c:when>
	                <c:otherwise>/addLectureMaterial</c:otherwise>
	             </c:choose>" method="post" enctype="multipart/form-data">
	
	    <c:if test="${not empty material}">
	        <input type="hidden" name="materialId" value="${material.materialId}" />
	    </c:if>
	
	    <c:if test="${empty material}">
	        <input type="hidden" name="weekId" value="${weekId}" />
	    </c:if>
	
	    <label>자료명:</label>
	    <input type="text" name="title" value="${material.title}" required /><br/>
	
	    <label>파일 업로드:</label>
	    <input type="file" name="file" required /><br/>
	
	    <button type="submit">저장</button>
	</form>
	</main>
</body>
</html>