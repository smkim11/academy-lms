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
	    <li><a href="/mainPage">메인페이지</a></li>
	    <li><a href="/lectureMainPage">강의목록</a></li>
	  </ul>
	</div>
	
<main>
	<hr>
		<table>
		  <thead>
		    <tr>
		      <th></th>
		      <c:forEach var="day" items="${dayList}">
		        <th>${day}</th>
		      </c:forEach>
		    </tr>
		  </thead>
		  <tbody>
		    <c:forEach var="time" items="${timeList}">
		      <tr>
		        <td>${time}</td>
		        <c:forEach var="day" items="${dayList}">
		          <c:set var="lecture" value="${timetable[day][time]}" />
		          <c:choose>
		            <c:when test="${not empty lecture}">
		              <c:set var="color" value="${lectureColorMap[lecture.lecture_id]}" />
		              <td style="background-color: ${color};">
		                <c:out value="${lecture.title}" />
		              </td>
		            </c:when>
		            <c:otherwise>
		              <td></td>
		            </c:otherwise>
		          </c:choose>
		        </c:forEach>
		      </tr>
		    </c:forEach>
		  </tbody>
		</table>
	<hr>
		<p>*morning : 08~12 / afternoon : 13~17 / evening : 18~22</p>
	<hr>
</body>
</html>