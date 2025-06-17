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
	
	<div class="ad-section" style="display: flex; justify-content: space-around; margin: 30px 0;">
  <div class="ad-card" style="width: 30%; background-color: #f9f9f9; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <img src="${pageContext.request.contextPath}/images/ad_english.jpg" alt="영어 완성 패키지" style="width: 100%; border-radius: 10px;">
    <h3>왕초보 영어 완성 패키지</h3>
    <p>회화부터 토익까지, 30일 완성! 무료체험 수강 가능</p>
    <button onclick="alert('02-1234-5678로 연락주시면 상담 도와드리겠습니다.');">30일완성 방법은?</button>
  </div>
  <div class="ad-card" style="width: 30%; background-color: #f9f9f9; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <img src="${pageContext.request.contextPath}/images/ad_japanese.jpg" alt="일본어 속성 특강" style="width: 100%; border-radius: 10px;">
    <h3>JLPT N3 속성 특강</h3>
    <p>하루 20분, 자투리 시간으로 자격증 합격!</p>
    <button onclick="alert('02-1234-5678로 연락주시면 상담 도와드리겠습니다.');">합격하고 싶다면!?</button>
  </div>
  <div class="ad-card" style="width: 30%; background-color: #f9f9f9; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
    <img src="${pageContext.request.contextPath}/images/ad_toeic.jpg" alt="토익 단기 완성반" style="width: 100%; border-radius: 10px;">
    <h3>토익 700+ 단기 완성반</h3>
    <p>직장인을 위한 주말 집중반 오픈!</p>
    <button onclick="alert('02-1234-5678로 연락주시면 상담 도와드리겠습니다.');">더 알아보고 싶다면?</button>
  </div>
</div>
</body>
</html>