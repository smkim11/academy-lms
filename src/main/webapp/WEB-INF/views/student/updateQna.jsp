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
	<form action="/updateQna" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="qnaId" value="${qna.qnaId}">
	    <input type="hidden" name="lectureId" value="${lectureId}">
	    
	    제목: <input type="text" name="title" value="${qna.title}"><br>
	    공개여부: 
	    <input type="radio" name="isPublic" value="1" ${qna.isPublic == 1 ? "checked" : ""}>공개
	    <input type="radio" name="isPublic" value="0" ${qna.isPublic == 0 ? "checked" : ""}>비공개<br>
	    
	    질문 내용:<br>
	    <textarea name="question">${qna.question}</textarea><br>
	    
	    파일 변경: <input type="file" name="file"><br>
	    
	    <button type="submit">수정 완료</button>
	</form>
</main>
</body>
</html>