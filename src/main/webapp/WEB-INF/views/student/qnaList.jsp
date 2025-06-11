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
		<h2>Q&A 게시판</h2>
		<table border="1" width="100%">
		    <tr>
		        <th>번호</th>
		        <th>제목</th>
		        <th>공개 여부</th>
		        <th>작성일</th>
		    </tr>
		<c:forEach var="qna" items="${qnaList}">
		    <tr>
		        <td>${qna.qnaId}</td>
		        <td><a href="/qnaOne?id=${qna.qnaId}">${qna.title}</a></td>
		        <td>
		            <c:choose>
		                <c:when test="${qna.isPublic == true}">공개</c:when>
		                <c:otherwise>비공개</c:otherwise>
		            </c:choose>
		        </td>
		        <td>${qna.createDate}</td>
		        <td>${qna.writerName}</td> <!-- 여기서 작성자 이름 출력 -->
		    </tr>
		</c:forEach>
		</table>
		
		<!-- 학생용 글쓰기 버튼 -->
  		<div style="text-align:right; margin-bottom:10px;">
 		   <a href="/addQna" class="btn">글쓰기</a>
	    </div>
		
	</main>

</body>
</html>