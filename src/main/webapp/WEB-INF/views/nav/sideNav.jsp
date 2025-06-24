<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="../css/styles.css">
<nav>
	<div class="logo">
		<a href="/mainPage">
			<img src="${pageContext.request.contextPath}/images/goodeeLogo.png" alt="학원 로고" style="width:150px; cursor:pointer;">
        </a>
	</div>
	<div class="top-bar">
		<div class="user-info">
		    <div class="user-name">${name}님</div>
		    <div class="user-links">
		      <a class="edit-profile" href="/${userRole}/mypage">마이페이지</a>
		      <a class="edit-profile" href="/logOut">로그아웃</a>
		    </div>
		</div>
	</div>
	<div class="side-bar">
		 <ul>
		 	<li><a href="/${userRole}/lectureOne?lectureId=${lectureId}">강의정보</a></li>
		 	<c:if test="${userRole eq 'admin' || userRole eq 'instructor'}">
		 		<li><a href="/${userRole}/studentList/${lectureId}">학생리스트</a></li>
		 	</c:if>
			<li><a href="/lectureMaterialWeekList?lectureId=${lectureId }">강의자료</a></li>
			<li><a href="/qna?lectureId=${lectureId }">QnA</a></li>
			<li><a href="/${userRole}/noticeList/${lectureId}">공지사항</a></li>
			<li><a href="/quizList?lectureId=${lectureId }">퀴즈</a></li>
			<li><a href="/${userRole}/studyPost/${lectureId}">스터디일지</a></li>
		 </ul>
	</div>
</nav>