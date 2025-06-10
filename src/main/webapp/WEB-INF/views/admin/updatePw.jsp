<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/styles.css">
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
  <h2>비밀번호 변경</h2>

  <form action="/admin/updatePw" method="post">
    <table>
      <tr>
        <td><label for="currentPw">현재 비밀번호</label></td>
        <td><input type="password" id="currentPw" name="currentPw" required></td>
      </tr>
      <tr>
        <td><label for="newPw">새 비밀번호</label></td>
        <td><input type="password" id="newPw" name="newPw" required></td>
      </tr>
      <tr>
        <td><label for="newPwCheck">새 비밀번호 확인</label></td>
        <td><input type="password" id="newPwCheck" name="newPwCheck" required></td>
      </tr>
      <tr>
        <td colspan="2">
          <button type="submit">비밀번호 변경</button>
        </td>
      </tr>
    </table>
  </form>

  <c:if test="${not empty error}">
    <p style="color:red;">${error}</p>
  </c:if>
</main>
    
    
</body>
</html>