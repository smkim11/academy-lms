<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/styles.css">
<nav>
	<div class="top-bar">
		<div class="logo">MyLMS</div>
		<div class="user-info">
		    <div class="user-name">${loginUserId }님</div>
		    <a class="edit-profile" href="/mypage">개인정보 수정</a>
		</div>
	</div>
	<div class="side-bar">
		 <ul>
			<li><a href="/mainPage">메인페이지</a></li>
			<li><a href="/lectureMainPage">강의목록</a></li>
		 </ul>
	</div>
</nav>