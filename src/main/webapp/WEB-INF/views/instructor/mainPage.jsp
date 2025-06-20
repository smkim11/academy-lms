<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="../css/mainPage.css">
<title>Insert title here</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/topNav.jsp"></jsp:include>
</div>
	<div class="user-info">
  	<div class="user-name">${loginUserId}님</div>
  	<div class="user-links">
   	   <a class="edit-profile" href="/mypage">마이페이지</a>
  	   <a class="edit-profile" href="/logOut">로그아웃</a>
    </div>
 	</div>
	</div>
<main>
	<table>
	  <thead>
	    <tr>
	      <th></th>
	      <c:forEach var="day" items="${dayList}">
	        <th>${day}</th>
	      </c:forEach>
	    </tr>
	  </thead>
	  
	  <tbody>
	    <c:forEach var="time" items="${timeList}">
	      <tr>
	        <td>${time}</td>
	        <c:forEach var="day" items="${dayList}">
	          <c:set var="lecture" value="${timetable[day][time]}" />
	          <c:choose>
	            <c:when test="${not empty lecture}">
	              <c:set var="color" value="${lectureColorMap[lecture.lecture_id]}" />
	              <td style="background-color: ${color};">
	                <c:out value="${lecture.title}" />
	              </td>
	            </c:when>
	            <c:otherwise>
	              <td></td>
	            </c:otherwise>
	          </c:choose>
	        </c:forEach>
	      </tr>
	    </c:forEach>
	  </tbody>
	</table>
<hr>
	<p>*morning : 08~12 / afternoon : 13~17 / evening : 18~22</p>
<hr>


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
            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
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
            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
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
            <a href="/instructor/lectureOne?lectureId=${lecture.lecture_id}">
              ${lecture.title} (${lecture.started_at} ~ ${lecture.ended_at})
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
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
</body>
</html>