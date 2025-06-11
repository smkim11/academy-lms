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
		<h2>제목 : ${qna.title}</h2>
		<p><strong>질문내용:</strong> ${qna.question}</p>
		<p><strong>공개여부:</strong> 
		  <c:choose>
		    <c:when test="${qna.isPublic == 1}">공개</c:when>
		    <c:otherwise>비공개</c:otherwise>
		  </c:choose>
		</p>
		<p><strong>작성일:</strong> ${qna.createDate}</p>
		
		<!-- QnA 내용 표시 -->
	<c:if test="${loginRole == 'student' and loginId == qnaStudentId}">
	    <form action="/deleteQna" method="post">
	        <input type="hidden" name="qnaId" value="${qna.qnaId}" />
	        <button type="submit">삭제하기</button>
	    </form>
	</c:if>
	
	<c:forEach var="answer" items="${qnaAnswer}">
	    <div>
	        <p>${answer.answer}</p>
	        <p>${answer.createDate}</p>
	        
	        <c:if test="${loginRole == 'instructor'}">
	            <form action="/deleteAnswer" method="post" style="display:inline;">
	                <input type="hidden" name="answerId" value="${answer.answerId}" />
	                <input type="hidden" name="qnaId" value="${qna.qnaId}" />
	                <button type="submit">삭제</button>
	            </form>
	        </c:if>
	    </div>
	</c:forEach>
	<a href="/qna">목록으로</a>
</main>
</body>
</html>