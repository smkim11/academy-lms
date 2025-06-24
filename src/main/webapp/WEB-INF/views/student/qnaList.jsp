<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/qna.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp">
		<jsp:param name="lectureId" value="${lectureId}" />
	</jsp:include>
	
</div>
<main>
	<span class="page-title">${lectureTitle}</span>
	<span class="page-subtitle">[${lectureDay}/${lectureTime}]</span> &nbsp;
	<span class="qna-list-title">QNA 목록</span>

<!-- 내가 쓴 글 보기(학생용) -->	    
<div style="text-align: right; margin-top: 10px;">
		<c:choose>
		    <c:when test="${param.view == 'my'}">
		        <!-- 내 글만 보는 중 → 전체 글 보기 버튼 출력 -->
		        <a href="/qna?lectureId=${lectureId}">
		            <button type="button">전체 글 보기</button>
		        </a>
		    </c:when>
		    <c:otherwise>
		        <!-- 전체 글 보는 중 → 내 글 보기 버튼 출력 -->
		        <a href="/myQna?lectureId=${lectureId}&view=my">
		            <button type="button">내가 쓴 글만 보기</button>
		        </a>
		    </c:otherwise>
		</c:choose>
</div>
<!-- QnA 게시판 테이블 -->
	    <table class="qna-table">
	        <tr style="background-color: #f0f0f0;">
	            <th>번호</th>
	            <th>제목</th>
	            <th>공개 여부</th>
	            <th>작성일</th>
	            <th>작성자 아이디</th>
	        </tr>
	        <c:forEach var="qna" items="${qnaList}">
	            <tr>
	                <td>${qna.qnaId}</td>
	                <td style="text-align: left;">
	                    <a href="/qnaOne?id=${qna.qnaId}&lectureId=${lectureId}">
	                        ${qna.title}
	                    </a>
	                </td>
	                <td>
	                    <c:choose>
	                        <c:when test="${qna.isPublic == true}">공개</c:when>
	                        <c:otherwise>비공개</c:otherwise>
	                    </c:choose>
	                </td>
	                <td>${qna.createDate}</td>
	                <td>${qna.writerName}</td>
	            </tr>
	        </c:forEach>
	    </span>
	    </table>
	    
	    <div>
			<a href="/admin/lectureOne?lectureId=${lectureId }">돌아가기</a>
		</div>
	    
	<!-- 게시글 리스트 출력 아래쪽에 페이지 버튼 -->
	<div style="text-align: center; margin-top: 20px;">
	    <c:forEach var="i" begin="1" end="${totalPages}">
	        <c:choose>
	            <c:when test="${i == currentPage}">
	                <span style="font-weight: bold;">[${i}]</span>
	            </c:when>
	            <c:otherwise>
	                <a href="/qna?lectureId=${lectureId}&page=${i}">[${i}]</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	</div>
		
	
<!-- 비공개글 접근 에러 메세지 -->
	<c:if test="${not empty param.errorMsg}">
	    <script>
	        <c:if test="${param.errorMsg == 'privateAccessDenied'}">
	            alert('비공개글에 접근할 수 없습니다.');
	        </c:if>
	    </script>
	</c:if>
	
<!-- 글쓰기 버튼 (학생용) -->
	    <div style="text-align: right; margin-bottom: 10px;">
	        <a href="/addQna?lectureId=${lectureId}" class="btn">글쓰기</a>
	    </div>
			<a href="/student/lectureOne?lectureId=${lectureId}">
			    강의정보로 돌아가기
			</a>
	</main>
</body>
</html>