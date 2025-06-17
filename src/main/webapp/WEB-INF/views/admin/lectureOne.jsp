<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <!-- 좌우 분할을 위한 flex 컨테이너 -->
  <div style="display: flex; gap: 40px; align-items: flex-start;">

    <!-- 🎓 왼쪽: 강의 요약 정보 -->
    <section class="lecture-summary" style="flex: 1;">
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

      <div style="margin-top: 25px;">
        <a href="/admin/studentList/${lecture.lectureId}" 
           style="display: inline-block; padding: 8px 16px; background-color: #3498db; color: white; border-radius: 4px; text-decoration: none; font-size: 14px;">
          👥 학생 리스트 보기
        </a>
      </div>
	
	<br> <br>

<a href="/lectureMaterialWeekList?lectureId=${lecture.lectureId}"> 강의자료 더보기</a>	
	
<table border="1">
  <thead>
    <tr>
      <th>주차</th>
      <th>자료 목록</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="week" begin="1" end="5">
      <tr>
        <td>${week}주차</td>
        <td>
          <c:choose>
            <c:when test="${not empty weekMaterialMap[week]}">
              <ul>
                <c:forEach var="material" items="${weekMaterialMap[week]}">
                  <li>
                    <a href="${material.fileUrl}" download>${material.title}</a>
                  </li>
                </c:forEach>
              </ul>
            </c:when>
            <c:otherwise>내용 없음</c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>



	
     
    </section>

    <!-- 📋 오른쪽: 공지사항 테이블 -->
<section class="lecture-notice" style="flex: 1;">
  
  <!-- 공지 상단 영역 (제목 + 더보기 링크) -->
  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
    <h3 style="margin: 0;">📢 최근 공지사항</h3>
    <a href="/admin/noticeList/${lecture.lectureId}" 
       style="font-size: 14px; text-decoration: none; color: #3498db;">공지 더보기</a>
  </div>

  <!-- 공지사항 테이블 -->
  <div style="margin-top: 10px;"> <!-- 여기로 여백 부여 -->
    <c:choose>
      <c:when test="${not empty lectureNoticeList}">
        <table class="notice-table" border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
          <thead>
            <tr>
              <th style="width: 10%;">번호</th>
              <th style="width: 30%;">공지타입</th>
              <th style="width: 30%;">제목</th>
              <th style="width: 30%;">작성일</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${lectureNoticeList}">
              <tr>
              	<td><a href="/admin/noticeListOne/${lecture.lectureId}/${notice.noticeId}">${notice.noticeId}</a></td>
                <td>${notice.noticeType}</td>
                <td>${notice.title}</td>
                <td>${fn:substring(notice.createDate, 0, 10)}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <p>등록된 공지사항이 없습니다.</p>
      </c:otherwise>
    </c:choose>
  </div>
</section>


  </div> <!-- flex 끝 -->
</main>


</body>
</html>