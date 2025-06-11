<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - 개인정보</title>
  <link rel="stylesheet" href="/css/styles.css">
  <style>
    body {
      margin: 0;
      font-family: sans-serif;
      background-color: #f8f8f8;
    }
    .top-bar {
      background-color: white;
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #e0e0e0;
    }
    .logo {
      font-size: 20px;
      font-weight: bold;
    }
    .user-name {
      font-weight: bold;
    }
    .layout {
      display: flex;
      height: calc(100vh - 60px);
    }
    .side-bar {
      width: 220px;
      background-color: #2e2e2e;
      color: white;
      padding-top: 30px;
    }
    .side-bar ul {
      list-style: none;
      padding: 0;
    }
    .side-bar li {
      padding: 15px 20px;
    }
    .side-bar a {
      color: white;
      text-decoration: none;
    }
    .side-bar li:hover {
      background-color: #444;
    }
    .main-content {
      flex-grow: 1;
      padding: 50px 80px;
      background: #f8f8f8;
    }
    .main-content h2 {
      font-size: 28px;
      margin-bottom: 30px;
    }
    .info-table {
      width: 100%;
      max-width: 600px;
      background-color: white;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 30px;
    }
    .info-table div {
      margin-bottom: 20px;
    }
    .info-table label {
      display: block;
      font-weight: bold;
      margin-bottom: 5px;
    }
    .info-table span {
      display: block;
      color: #555;
    }
  </style>
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
        <li><a href="/student/myPage">내 개인정보</a></li>
        <li><a href="/student/updateInfo">개인정보 수정</a></li>
        <li><a href="/student/updatePw">비밀번호 변경</a></li>
        <li><a href="/logOut">로그아웃</a></li>
      </ul>
    </div>

    <div class="main-content">
      <h2>내 개인정보</h2>
      <div class="info-table">
        <div>
        
          <label>이름</label>
          <span>${myPage.name}</span>
        </div>
        <div>
          <label>이메일</label>
          <span>${myPage.email}</span>
        </div>
        <div>
          <label>휴대폰 번호</label>
          <span>${myPage.phone}</span>
        </div>
        <div>
          <label>생년월일</label>
          <span>${myPage.birth}</span>
        </div>
      </div>
    </div>
  </div>
</body>
</html>