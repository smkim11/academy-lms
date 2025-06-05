<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Q&A 목록</h2>
	<table border="1" width="100%">
	    <tr>
	        <th>번호</th>
	        <th>질문</th>
	        <th>공개 여부</th>
	        <th>작성일</th>
	    </tr>
	    <c:forEach var="qna" items="${qnaList}">
	        <tr>
	            <td>${qna.qnaId}</td>
	            <td>${qna.question}</td>
	            <td>
	                <c:choose>
	                    <c:when test="${qna.isPublic == 1}">공개</c:when>
	                    <c:otherwise>비공개</c:otherwise>
	                </c:choose>
	            </td>
	            <td>${qna.lastUpdate}</td>
	        </tr>
	    </c:forEach>
	</table>
</body>
</html>