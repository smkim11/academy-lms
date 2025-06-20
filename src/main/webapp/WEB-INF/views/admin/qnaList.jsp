<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lmsStyle.css">
<meta charset="UTF-8">
<title>AcademyLMS</title>
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
	
	<span class="quiz-list-title">QNA 목록</span>
	
<!-- QnA 게시판 테이블 -->
	    <table class="quiz-table">
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
	    	<a href="/admin/lectureOne?lectureId=${lectureId}">
			    강의정보로 돌아가기
			</a>
	</main>
</body>
</html>