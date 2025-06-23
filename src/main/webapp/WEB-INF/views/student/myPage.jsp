<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - 개인정보</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
  <link rel="stylesheet" href="/css/myPage.css"> <!-- 스타일 분리 -->
</head>
<body>
  <div>
    <jsp:include page ="../nav/topNav.jsp"></jsp:include>
  </div>

  <div class="wrapper">
    <div class="info-table">
      <div class="profile-header">
        <div>내 개인정보</div>
      </div>

      <div class="info-row">
        <label><i class="fas fa-user"></i>이름</label>
        <span>${myPage.name}</span>
      </div>
      <div class="info-row">
        <label><i class="fas fa-envelope"></i>이메일</label>
        <span>${myPage.email}</span>
      </div>
      <div class="info-row">
        <label><i class="fas fa-phone"></i>휴대폰 번호</label>
        <span>${myPage.phone}</span>
      </div>
      <div class="info-row">
        <label><i class="fas fa-cake-candles"></i>생년월일</label>
        <span>${myPage.birth}</span>
      </div>

      <div class="button-group">
        <button type="button" class="info-button btn-password" onclick="location.href='/student/updatePw'">비밀번호 변경</button>
        <button type="button" class="info-button btn-edit" onclick="location.href='/student/updateInfo'">개인정보 수정</button> 
      </div>
    </div>
  </div>

  <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
  </div>
</body>
</html>
