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
<body class="no-sidebar">
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
<div class="admin-columns">
  <div class="admin-section">
    <h2>수강정보관리</h2>
    <div class="admin-box">
      <ul>
        <li><a href="/admin/createLecture">강의등록</a></li>
      </ul>
    </div>
  </div>

  <div class="admin-section">
    <h2>통계관리</h2>
    <div class="admin-box">
      <ul>
        <li><a href="/admin/statistics">통계 페이지로 이동</a></li>
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
    <h4 onclick="toggleSection('ended')">▸ 종료된 강의(최근 2주만 출력)</h4>
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

<!-- 법적 의무 안내 -->
<div class="admin-section">
  <h3 onclick="toggleSection('legalNotice')" style="cursor: pointer;">▸ 관리자 법적 의무사항</h3>
  <div id="legalNotice" style="display: none; padding: 10px; border: 1px solid #ccc; background: #f9f9f9; border-radius: 6px;">
    <h4>불법 게시물 관리 안내</h4>
    <ul>
      <li>명예훼손·음란물·혐오 표현 등 불법 정보는 인지 즉시 조치합니다.</li>
      <li>삭제 요청이 없더라도 명백한 불법 정보는 선제적으로 제거합니다.</li>
      <li>이를 방치할 경우, 민·형사상 책임이 발생할 수 있습니다.</li>
    </ul>

    <h4>저작권 보호 안내</h4>
    <p>불법 저작물 링크가 포함된 게시물은 운영자 인지 시 즉시 삭제 처리합니다.</p>

    <h4>개인정보처리방침 및 쿠키 정책</h4>
    <p style="cursor: pointer; color: blue;" onclick="toggleSection('privacyPolicy')">
 	 개인정보처리방침
	</p>
		<div id="privacyPolicy" style="display: none; padding: 10px; margin-top: 5px; border: 1px solid #ccc; background: #f9f9f9;">
		  <h4>📄 개인정보처리방침</h4>
		  <p>본 사이트는 개인정보 보호법에 따라 이용자의 개인정보를 보호하고 관련 법규를 준수합니다.</p>
		
		  <h5>1. 수집 항목</h5>
		  <ul>
		    <li>필수: 이름, 아이디, 이메일, 전화번호 등</li>
		    <li>선택: 프로필 이미지, 추가 연락처 등</li>
		  </ul>
		
		  <h5>2. 수집 목적</h5>
		  <p>회원 관리, 강의 신청·관리, 민원 처리 등을 위해 사용됩니다.</p>
		
		  <h5>3. 보유 및 파기</h5>
		  <p>관련 법령에 따른 보관 기간 후 즉시 안전하게 파기됩니다.</p>
		
		  <h5>4. 동의 철회</h5>
		  <p>회원은 언제든지 개인정보 수집 및 이용 동의를 철회할 수 있습니다.</p>
		</div>
	위 내용을 참고하여 수집 항목, 목적, 동의 및 파기 정책을 확인하세요.

    <h4>면책 조항</h4>
    <p>게시된 정보의 정확성은 보장하지 않으며, 고의·중대한 과실이 없는 경우 법적 책임은 없습니다.</p>
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