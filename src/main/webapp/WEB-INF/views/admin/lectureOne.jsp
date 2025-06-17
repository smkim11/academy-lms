<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/styles.css">
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
	
<main style="padding: 20px;">
  <section class="lecture-summary" style="max-width: 800px; margin-left: 10px;">
    <div style="display: flex; align-items: center;">
      <h2 style="margin-right: 10px;">${lecture.title}</h2>
      <c:if test="${now lt lecture.startedAt }">
        <a href="/admin/updateLecture?lectureId=${lecture.lectureId}" class="edit-button" style="font-size: 14px;">✏️ 수정</a>
        <a href="/admin/lectureDelete?lectureId=${lecture.lectureId}" class="edit-button" style="font-size: 14px; color: red;" onclick="return confirm('정말 삭제하시겠습니까?');">🗑️ 삭제</a>
      </c:if>
    </div>
    <p><strong>강사:</strong> ${lecture.name}</p>
    <p><strong>시간:</strong> ${lecture.day} / ${lecture.time}</p>
    <p><strong>기간:</strong> ${lecture.startedAt} ~ ${lecture.endedAt}</p>
    
        <!-- ✅ 액션 버튼 영역 -->
    <div style="margin-top: 25px;">
      <a href="/admin/studentList/${lecture.lectureId}" 
         style="display: inline-block; padding: 8px 16px; background-color: #3498db; color: white; border-radius: 4px; text-decoration: none; font-size: 14px;">
        👥 학생 리스트 보기
      </a>
    </div>
  </section>
  
  
  
  
</main>

</body>
</html>