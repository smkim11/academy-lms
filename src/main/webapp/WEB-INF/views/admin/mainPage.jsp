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
	
<main style="display: flex; justify-content: space-between;">
    <!-- 왼쪽 강의관리 -->
    <div style="width: 50%;">
      <h2>강의관리</h2>
      <!-- 진행중인 강의 -->
      <h4 class="toggle-header" onclick="toggleSection('ongoing')">▸진행중인 강의</h4>
      <div id="ongoing" class="lecture-section">
        <c:if test="${empty ongoingLectures}">
          <p>진행중인 강의가 없습니다.</p>
        </c:if>
        <ul>
          <c:forEach var="lecture" items="${ongoingLectures}">
            <li>
              <a href="/admin/lectureOne?lectureId=${lecture.lecture_id}">
                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- 진행예정 강의 -->
      <h4 class="toggle-header" onclick="toggleSection('upcoming')">▸진행예정 강의</h4>
      <div id="upcoming" class="lecture-section">
        <c:if test="${empty upcomingLectures}">
          <p>진행예정 강의가 없습니다.</p>
        </c:if>
        <ul>
          <c:forEach var="lecture" items="${upcomingLectures}">
            <li>
              <a href="/admin/lectureOne?lectureId=${lecture.lecture_id}">
                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- 종료된 강의 -->
      <h4 class="toggle-header" onclick="toggleSection('ended')">▸종료된 강의</h4>
      <div id="ended" class="lecture-section">
        <c:if test="${empty endedLectures}">
          <p>종료된 강의가 없습니다.</p>
        </c:if>
        <ul>
          <c:forEach var="lecture" items="${endedLectures}">
            <li>
              <a href="/admin/surveyResult?lectureId=${lecture.lecture_id}">
                ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>
	
	    <!-- 오른쪽 수강생관리 + 통계 영역 -->
	    <div style="width: 50%;"> 
	        <h2>관리자 전용</h2>
	        <ul>
	            <li><a href="/admin/studentList">수강생 관리 페이지로 이동</a></li>
	        </ul>
	        <ul>
	            <li><a href="/admin/statistics">통계 페이지로 이동</a></li>
	        </ul>

	        <h2>마이페이지</h2>
	        <ul>
		        <li><a class="edit-profile" href="/admin/mypage">개인정보 수정</a></li>
	        </ul>
	    </div>
</main>
	
<script>
function toggleSection(id) {
    const section = document.getElementById(id);
    if (section.style.display === "none") {
      section.style.display = "block";
    } else {
      section.style.display = "none";
    }
  }
  // 페이지 로드시 기본은 모두 접기 (선택 사항)
  window.onload = function() {
    document.getElementById('ongoing').style.display = 'none';
    document.getElementById('upcoming').style.display = 'none';
    document.getElementById('ended').style.display = 'none';
  };
</script>
</body>
</html>