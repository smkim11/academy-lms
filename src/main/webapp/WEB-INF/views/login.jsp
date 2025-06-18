<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
  $(function(){
    $('#login').click(function(e){
      const id = $('#id').val().trim();
      const password = $('#password').val().trim();

      if(id === "" || password === ""){
        alert('아이디와 비밀번호를 모두 입력해주세요.');
        return false;
      }

      $('#loginForm').submit();
    });
  });
</script>
<meta charset="UTF-8">
<title>로그인 | 구디아카데미</title>
<style>
/* 🔹 전체 페이지 배경 & 중앙 정렬 */
body {
  margin: 0;
  padding: 0;
  font-family: 'Noto Sans KR', sans-serif;
  background: linear-gradient(180deg, #f8f9fb 0%, #eef1f6 100%);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding-top: 80px;
}

/* 🔹 로고 스타일 */
.logo-container {
  margin-bottom: 40px;
}
.logo-container img {
  width: 260px;
  max-width: 90%;
  height: auto;
  transition: transform 0.2s ease;
}
.logo-container img:hover {
  transform: scale(1.03);
}

/* 🔹 로그인 박스 */
form {
  background-color: #fff;
  padding: 36px 28px;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  width: 360px;
  max-width: 90%;
  box-sizing: border-box;
  animation: fadeIn 0.6s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(30px); }
  to   { opacity: 1; transform: translateY(0); }
}

form h1 {
  text-align: center;
  margin-bottom: 30px;
  font-size: 1.8rem;
  color: #333;
}

/* 🔹 입력 필드 */
form label {
  font-size: 0.9rem;
  color: #444;
  margin-bottom: 6px;
  display: block;
}

form input[type="text"],
form input[type="password"] {
  width: 100%;
  padding: 11px 14px;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  margin-bottom: 20px;
  box-sizing: border-box;
  transition: border-color 0.2s;
}
form input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.2);
}

/* 🔹 버튼 */
button {
  width: 100%;
  padding: 14px;
  background-color: #007bff;
  color: white;
  font-size: 1.05rem;
  font-weight: bold;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s;
}
button:hover {
  background-color: #0056b3;
}

/* 🔹 하단 링크 */
.forgot {
  text-align: center;
  margin-top: 20px;
}
.forgot a {
  font-size: 0.85rem;
  color: #007bff;
  text-decoration: none;
}
.forgot a:hover {
  text-decoration: underline;
}
</style>
</head>
<body>

  <!-- 🔸 로고 -->
  <div class="logo-container">
    <a href="/mainPage">
      <img src="../images/goodeeLogo.png" alt="학원 로고">
    </a>
  </div>

  <!-- 🔸 로그인 박스 -->
  <form action="/loginForm" id="loginForm" method="post">
    <h1>로그인</h1>
    <label for="id">아이디</label>
    <input type="text" id="id" name="id" placeholder="아이디를 입력하세요">

    <label for="password">비밀번호</label>
    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">

    <button type="button" id="login">로그인하기</button>

    <div class="forgot">
      <a href="/findPassword">비밀번호를 잊으셨나요?</a>
    </div>
  </form>

</body>
</html>
