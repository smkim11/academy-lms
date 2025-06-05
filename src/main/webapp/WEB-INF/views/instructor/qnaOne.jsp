<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet" href="css/styles.css">	
	<title>Q&A 상세보기</title>
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
	<h2>질문 상세 보기</h2>
	<p><strong>번호:</strong> ${qna.qnaId}</p>
	<p><strong>질문:</strong> ${qna.title}</p>
	<p><strong>질문:</strong> ${qna.question}</p>
	<p><strong>공개 여부:</strong> 
	  <c:choose>
	    <c:when test="${qna.isPublic == 1}">공개</c:when>
	    <c:otherwise>비공개</c:otherwise>
	  </c:choose>
	</p>
	<p><strong>작성일:</strong> ${qna.lastUpdate}</p>
	</main>
</body>
</html>