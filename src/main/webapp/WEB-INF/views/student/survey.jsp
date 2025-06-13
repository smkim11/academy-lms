<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
			
		
	
		
		$('.star_rating>.star').click(function(){
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
		
		
		// value 속성에서 점수 가져와서 hidden input에 저장
		let rating = $(this).attr('value');
		$('#ratingValue').val(rating);
	});
});



</script>
<style type="text/css">

.star_rating {
  width: 100%; 
  box-sizing: border-box; 
  display: inline-flex; 
  float: left;
  flex-direction: row; 
  justify-content: flex-start;
}
.star_rating .star {
  width: 25px; 
  height: 25px; 
  margin-right: 10px;
  display: inline-block; 
  background: url('/images/emptyStar.png') no-repeat; 
  background-size: 100%; 
  box-sizing: border-box; 
}
.star_rating .star.on {
  width: 25px; 
  height: 25px;
  margin-right: 10px;
  display: inline-block; 
  background: url('/images/fullStar.png') no-repeat;
  background-size: 100%; 
  box-sizing: border-box; 
}

.star_box {
  width: 400px;
  box-sizing: border-box;
  display: inline-block;
  margin: 15px 0;
  background: #F3F4F8;
  border: 0;
  border-radius: 10px;
  height: 100px;
  resize: none;
  padding: 15px;
  font-size: 13px;
  font-family: sans-serif;
}
.btn02 {
  display:block;
  width: 400px;
  font-weight: bold;
  border: 0;
  border-radius: 10px;
  max-height: 50px;
  padding: 15px 0;
  font-size: 1.1em;
  text-align: center;
  background:bisque;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	
  <div class="top-bar">
    <div class="logo">MyLMS</div>
    <div class="user-name">홍길동님</div>
  </div>



<div class="layout">
  <div class="side-bar">
    <ul>
      <li><a href="#">메인페이지</a></li>
      <li><a href="/admin/myPage">내 개인정보</a></li>
      <li><a href="/admin/updateInfo">개인정보 수정</a></li>
      <li><a href="/admin/updatePw">비밀번호 변경</a></li>
      <li><a href="/logOut">로그아웃</a></li>
    </ul>
  </div>
	
   <main>
   		<h2>과정 만족도 조사</h2>
	<form action="/student/survey" method="post">
	<div class="star_rating">
		<span class="star on" value="1"></span>
		<span class="star" value="2"></span>
		<span class="star" value="3"></span>
		<span class="star" value="4"></span>
		<span class="star" value="5"></span>
	</div>
	
	<input type="hidden" name="rating" id="ratingValue" value="1">
	<input type="hidden" name="enrollmentId" value="${enrollmentId}">
	
	<textarea class="star_box" name="comment" placeholder="기타 의견을 작성해주세요."></textarea>
	
	<input type="submit" class="btn02" value="만족도조사 등록"/>	
	
	</form>
	</main>
</body>
</html>