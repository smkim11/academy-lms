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
	
		<main>
	    <h2 style="text-align: center;">${week}주차 강의자료</h2>
	
	    <div style="text-align: right; margin-bottom: 10px;">
	        <a href="/addLectureMaterial?weekId=${weekId}" style="font-weight: bold; color: #333;">강의자료 등록</a>
	    </div>
	
	    <table border="1" style="width: 100%; border-collapse: collapse; text-align: center;">
	        <tr style="background-color: #f0f0f0;">
	            <th>자료명</th>
	            <th>등록일</th>
	        </tr>
	        <c:forEach var="material" items="${materialList}">
	            <tr>
	                <td>
	                    <a href="/lectureMaterialOne?materialId=${material.materialId}">
	                        ${material.title}
	                    </a>
	                </td>
	                <td>${material.createDate}</td>
	            </tr>
	        </c:forEach>
	    </table>
	    
	    	<a href="/lectureMaterialWeekList?lectureId=${lectureId}">
			    주차별 리스트로 돌아가기
			</a>
	</main>
</body>
</html>