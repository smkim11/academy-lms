<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>비밀번호 찾기</h1>

  <form id="findPwForm" action="/findPassword" method="post">
    <div>
      <label for="userId">아이디</label><br>
      <input type="text" id="userId" name="id" required>
    </div>
    <div style="margin-top: 10px;">
      <label for="email">이메일</label><br>
      <input type="email" id="email" name="email" required>
    </div>
    <div style="margin-top: 15px;">
      <button type="submit">임시 비밀번호 발급</button>
    </div>
  </form>
</body>

</html>