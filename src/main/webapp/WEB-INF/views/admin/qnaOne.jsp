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
	
	<main style="max-width: 800px; margin: 20px auto; padding: 20px;">
	    <h2 style="text-align: center;">Q&A 상세보기</h2>
	
	    <p><strong>제목:</strong> ${qna.title}</p>
	    <p><strong>질문내용:</strong> ${qna.question}</p>
	    <p><strong>공개여부:</strong> 
	        <c:choose>
	            <c:when test="${qna.isPublic == 1}">공개</c:when>
	            <c:otherwise>비공개</c:otherwise>
	        </c:choose>
	    </p>
	    <p><strong>작성일:</strong> ${qna.createDate}</p>
	    <p><strong>첨부파일:</strong> 
	        <c:choose>
	            <c:when test="${not empty qna.fileUrl}">
	                <a href="${qna.fileUrl}" download>파일 다운로드</a>
	            </c:when>
	            <c:otherwise>
	                없음
	            </c:otherwise>
	        </c:choose>
	    </p>
<!-- 글삭제 -->
	    <c:if test="${(loginRole == 'student' and loginUserId == qnaStudentId)||loginRole=='admin'}">
	        <form action="/deleteQna" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');">
	            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
	            <input type="hidden" name="lectureId" value="${lectureId}" />
	            <button type="submit"
	                    style="padding: 8px 16px; font-size: 14px; font-weight: bold; background-color: black; color: white; border: none; cursor: pointer;">
	                삭제하기
	            </button>
	        </form>
	    </c:if>
	
<!-- 기존 답변 리스트 -->
	    <c:forEach var="answer" items="${qnaAnswer}">
	        <div style="border: 1px solid #ddd; padding: 10px; margin-top: 15px;">
	            <p>${answer.answer}</p>
	            <p style="font-size: 12px; color: gray;">${answer.createDate}</p>
	            
	            <c:if test="${loginRole == 'instructor'||loginRole == 'admin'}">
	                <form action="/deleteAnswer" method="post" style="display: inline;">
					    <input type="hidden" name="answerId" value="${answer.answerId}" />
					    <input type="hidden" name="qnaId" value="${qna.qnaId}" />
					    <input type="hidden" name="lectureId" value="${lectureId}" /> <!-- 추가 -->
					    <button type="submit"
					            style="padding: 5px 10px; font-size: 12px; font-weight: bold; background-color: #f44336; color: white; border: none; cursor: pointer;">
					        삭제
					    </button>
					</form>
	            </c:if>
	        </div>
	    </c:forEach>
	
<!-- 목록으로 버튼 -->
	    <div style="text-align: right; margin-top: 20px;">
	        <a href="/qna?lectureId=${lectureId}" style="font-weight: bold; color: #333;">목록으로</a>
	    </div>
	</main>
</body>
</html>