<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="../css/mainPage.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="logo">
    <img src="${pageContext.request.contextPath}/images/goodeeLogo.png" alt="로고" style="height: 50px;" />
</div>
	<div class="top-bar">
	<div class="user-info">
  	<div class="user-name">${loginUserId}님</div>
  	<div class="user-links">
   	   <a class="edit-profile" href="/mypage">마이페이지</a>
  	    <a class="edit-profile" href="/logOut">로그아웃</a>
    </div>
 	</div>
	</div>
	</div>
<main>
<div class="admin-columns">
  <div class="admin-section">
    <h2>관리자 전용</h2>
    <div class="admin-box">
      <ul>
        <li><a href="/admin/studentList">수강생 관리 페이지로 이동</a></li>
      </ul>
      <ul>
        <li><a href="/admin/statistics">통계 페이지로 이동</a></li>
      </ul>
      <ul>
        <li><a href="/admin/createLecture">강의등록</a></li>
      </ul>
    </div>
  </div>

  <div class="admin-section">
    <h2>마이페이지</h2>
    <div class="admin-box">
      <ul>
        <li><a class="edit-profile" href="/admin/mypage">개인정보 수정</a></li>
      </ul>
    </div>
  </div>
</div>
	    
<h2>강의관리</h2>
<div class="lecture-columns">
  <!-- 진행중인 강의 -->
  <div class="lecture-box">
    <h4 onclick="toggleSection('ongoing')">▸ 진행중인 강의</h4>
    <div id="ongoing">
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
  </div>

  <!-- 진행예정 강의 -->
  <div class="lecture-box">
    <h4 onclick="toggleSection('upcoming')">▸ 진행예정 강의</h4>
    <div id="upcoming">
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
  </div>

  <!-- 종료된 강의 -->
  <div class="lecture-box">
    <h4 onclick="toggleSection('ended')">▸ 종료된 강의</h4>
    <div id="ended">
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
</div>

<script>
function toggleSection(id) {
    const section = document.getElementById(id);
    if (section.style.display === "none") {
      section.style.display = "block";
    } else {
      section.style.display = "none";
    }
  }
  // 페이지 로드시 기본은 모두 접기
  window.onload = function() {
    document.getElementById('ongoing').style.display = 'none';
    document.getElementById('upcoming').style.display = 'none';
    document.getElementById('ended').style.display = 'none';
  };
</script>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>