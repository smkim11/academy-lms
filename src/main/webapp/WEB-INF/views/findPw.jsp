<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>비밀번호 찾기 | 구디아카데미</title>
<style>
body {
  margin: 0;
  padding: 0;
  font-family: 'Segoe UI', sans-serif;
  background: linear-gradient(180deg, #f8f9fb 0%, #eef1f6 100%);
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

/* 폼 */
form {
  background-color: #fff;
  padding: 36px 30px;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  width: 380px;
  box-sizing: border-box;
}

form h1 {
  text-align: center;
  font-size: 1.6rem;
  margin-bottom: 28px;
  color: #222;
}

label {
  display: block;
  font-size: 0.95rem;
  color: #333;
  margin-bottom: 6px;
}

input[type="text"],
input[type="email"] {
  width: 100%;
  padding: 11px 14px;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-size: 1rem;
  box-sizing: border-box;
  margin-bottom: 20px;
  transition: border-color 0.2s ease;
}

input:focus {
  border-color: #007bff;
  outline: none;
  box-shadow: 0 0 0 2px rgba(0,123,255,0.2);
}

button {
  width: 100%;
  padding: 13px;
  background-color: #007bff;
  color: white;
  font-size: 1rem;
  font-weight: bold;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}
button:hover {
  background-color: #0056b3;
}

/* 성공 메시지 */
#successMessage {
  display: none;
  margin-top: 20px;
  padding: 12px;
  background-color: #e0f7e9;
  border: 1px solid #00b894;
  color: #02735E;
  border-radius: 6px;
  text-align: center;
  font-size: 0.95rem;
}

/* 로그인 링크 */
.login-link {
  margin-top: 18px;
  text-align: center;
}
.login-link a {
  font-size: 0.9rem;
  color: #007bff;
  text-decoration: none;
}
.login-link a:hover {
  text-decoration: underline;
}
</style>

<script>
$(function() {
  $('#findPwForm').submit(function(e) {
    const email = $('#email').val().trim();
    const userId = $('#userId').val().trim();
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailPattern.test(email)) {
      alert('유효한 이메일 주소를 입력해주세요.');
      e.preventDefault();
      return;
    }

    if (userId === '') {
      alert('아이디를 입력해주세요.');
      e.preventDefault();
      return;
    }

    $('#successMessage').fadeIn();
	 // 1.5초 뒤에 로그인 페이지로 자동 이동
    setTimeout(() => {
      window.location.href = '/login';
    }, 1500);
    
  });
});
</script>
</head>
<body>

  <form id="findPwForm" action="/findPassword" method="post">
    <h1>비밀번호 찾기</h1>

    <label for="userId">아이디</label>
    <input type="text" id="userId" name="id" placeholder="아이디를 입력하세요" required>

    <label for="email">이메일</label>
    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>

    <button type="submit">임시 비밀번호 발급</button>

    <div id="successMessage">✅ 임시 비밀번호가 이메일로 발송되었습니다.</div>

    <div class="login-link">
      <a href="/login">← 로그인으로 돌아가기</a>
    </div>
  </form>

</body>
</html>
