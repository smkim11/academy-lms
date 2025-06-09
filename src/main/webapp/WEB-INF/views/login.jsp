<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#login').click(function(e){
			const id = $('#id').val().trim();
			const password = $('#password').val().trim();  // 로그인 빈 값 체크
			
			if(id === ""|| password === ""){
				alert('아이디와 비밀번호를 모두 입력해주세요.');
				return false;  // submit 방지
			}
			
			
			$('#loginForm').submit();
		})
	})



</script>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style>
  /* 화면 중앙 정렬 */
  body {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
    background-color: #f9f9f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }

  /* 로그인 폼 컨테이너 */
  form {
    background-color: #ffffff;
    padding: 24px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-sizing: border-box;
    width: 300px;
  }

  /* 제목 */
  h1 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 1.5rem;
    color: #333;
  }

  /* 폼 그룹 */
  div {
    margin-bottom: 15px;
  }

  /* 라벨 */
  label {
    display: block;
    margin-bottom: 5px;
    font-size: 0.9rem;
    color: #555;
  }

  /* 입력 필드 */
  input[type="text"],
  input[type="password"] {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
  }

  /* 버튼 */
  button {
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    font-size: 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color: #0056b3;
  }
</style>

</head>
<body>
  <form action="/loginForm" id="loginForm" method="post">
    <h1>로그인</h1>
    <div>
      <label for="id">아이디</label>
      <input type="text" id="id" name="id">
    </div>
    <div>
      <label for="password">비밀번호</label>
      <input type="password" id="password" name="password">
    </div>
    <button type="button" id="login">로그인하기</button>
    
    	<!-- 비밀번호 찾기 링크 -->
	<div style="text-align: center; margin-top: 10px;">
  	<a href="/findPassword" style="font-size: 0.85rem; color: #007bff; text-decoration: none;">
    비밀번호를 잊으셨나요?
  	</a>
	</div>
  </form>
</body>
</html>
