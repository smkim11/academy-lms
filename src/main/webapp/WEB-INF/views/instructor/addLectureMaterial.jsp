<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의자료 등록</title>
<link rel="stylesheet" href="css/styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 상단바 + 사이드바 -->
<div class="top-bar">
  <div class="logo">MyLMS</div>
  <div class="user-info">
    <div class="user-name">홍길동님</div>
    <a class="edit-profile" href="/mypage">개인정보 수정</a>
  </div>
</div>
<div class="side-bar">
  <ul>
    <li><a href="#">대시보드</a></li>
    <li><a href="#">강의목록</a></li>
    <li><a href="#">수강관리</a></li>
    <li><a href="#">설정</a></li>
  </ul>
</div>

<main style="max-width: 800px; margin: 20px auto; padding: 20px;">
    <h2 style="text-align: center;">📎 강의자료 다중 등록</h2>

    <form action="/addLectureMaterial" method="post" enctype="multipart/form-data">
        <input type="hidden" name="weekId" value="${weekId}" />

        <div id="upload-area">
            <div class="file-group">
                <label>자료명:</label>
                <input type="text" name="titles" required>
                <label>파일:</label>
                <input type="file" name="files" required>
            </div>
        </div>

        <button type="button" onclick="addUploadField()">+ 자료 추가</button>
        <button type="submit">📤 업로드</button>
    </form>

    <script>
    function addUploadField() {
        const group = document.createElement('div');
        group.className = "file-group";
        group.innerHTML = `
            <label>자료명:</label>
            <input type="text" name="titles" required>
            <label>파일:</label>
            <input type="file" name="files" required>
        `;
        document.getElementById("upload-area").appendChild(group);
    }
    </script>
</main>
</body>
</html>