<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
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
	
	<main>
    <h2>강의자료 수정</h2>

    <form action="/updateLectureMaterial" method="post" enctype="multipart/form-data">
        <!-- 수정 시 materialId 전달 필요 -->
        <input type="hidden" name="materialId" value="${material.materialId}"/>

        <table>
            <tr>
                <td>제목</td>
                <td><input type="text" name="title" value="${material.title}" required/></td>
            </tr>
            <tr>
                <td>기존 파일</td>
                <td>
                    <a href="${material.fileUrl}" target="_blank">${material.fileUrl}</a>
                </td>
            </tr>
            <tr>
                <td>새 파일 업로드</td>
                <td><input type="file" name="file"/></td>
            </tr>
        </table>

        <br/>
        <button type="submit">수정 완료</button>
    </form>

    <br/>
    <a href="/lectureMaterialOne?materialId=${material.materialId}">← 강의자료 상세로 돌아가기</a>
	</main>
</body>
</html>