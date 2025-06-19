<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<link rel="stylesheet" href="css/styles.css">
	<title>Q&A 상세보기</title>
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
<jsp:include page="../nav/sideNav.jsp">
  <jsp:param name="lectureId" value="${lectureId}" />
</jsp:include>
	<div class="top-bar">
	  <div class="logo">MyLMS</div>
	  <div class="user-info">
	    <div class="user-name">홍길동님</div>
	    <a class="edit-profile" href="/mypage">개인정보 수정</a>
	  </div>
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
	
<!-- 질문 작성자 수정/삭제 버튼 노출 (학생 본인만 가능) -->
		<a href="/updateQna?qnaId=${qna.qnaId}&lectureId=${lectureId}">
		    <button type="button"
		            style="padding: 8px 16px; font-size: 14px; font-weight: bold; background-color: black; color: white; border: none; cursor: pointer;">
		        수정하기
		    </button>
		</a>
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
	
<!-- QnA 답변 표시 -->
	    <c:forEach var="answer" items="${qnaAnswer}">
	        <div style="border: 1px solid #ddd; padding: 10px; margin-top: 15px;">
	            <p>${answer.answer}</p>
	            <p style="font-size: 12px; color: gray;">${answer.createDate}</p>
	        </div>
	    </c:forEach>
	
<!-- 목록으로 버튼 -->
	    <div style="text-align: right; margin-top: 20px;">
	        <a href="/qna?lectureId=${lectureId}" style="font-weight: bold; color: #333;">목록으로</a>
	    </div>
	</main>
</body>
</html>