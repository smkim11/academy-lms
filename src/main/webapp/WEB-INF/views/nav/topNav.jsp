<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/styles.css">
<nav>
	<div class="logo">
		<a href="/mainPage">
			<img src="../images/goodeeLogo.png" alt="학원 로고" style="width:150px; cursor:pointer;">
        </a>
	</div>
	<div class="top-bar">
		<div class="user-info">
		    <div class="user-name">${name }님</div>
		    <div class="user-links">
		      <a class="edit-profile" href="/${userRole}/mypage">마이페이지</a>
		      <a class="edit-profile" href="/logOut">로그아웃</a>
		    </div>
		</div>
	</div>
</nav>