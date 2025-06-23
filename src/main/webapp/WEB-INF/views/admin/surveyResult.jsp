<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>강의 만족도 조사 결과</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    :root {
      --primary: #2c7be5;
      --bg-light: #f9fafb;
      --text-dark: #1f2937;
      --text-muted: #6b7280;
      --border: #d1d5db;
      --highlight: #eff6ff;
    }

    body {
      font-family: "맑은 고딕", sans-serif;
      margin: 0;
      background-color: #ffffff;
      color: var(--text-dark);
    }

    /* ✅ 중앙 정렬 및 폭 제한 */
    .main-wrapper {
      width: 100%;
      max-width: 1100px;
      margin: 0 auto;
       padding: 120px 32px 40px 32px; 
      box-sizing: border-box;
    }

    .title {
      font-size: 20px;
      font-weight: 500;
      margin-bottom: 24px;
      line-height: 1.6;
      color: var(--text-dark);
    }

    .avg-score {
      font-size: 22px;
      font-weight: 700;
      margin-bottom: 32px;
      color: var(--primary);
      background-color: var(--highlight);
      padding: 12px 18px;
      border-left: 5px solid var(--primary);
      border-radius: 6px;
    }

    .survey-box {
      border: 1px solid var(--border);
      padding: 18px 20px;
      margin-bottom: 16px;
      border-radius: 10px;
      background-color: var(--bg-light);
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .survey-rating {
      font-weight: 600;
      font-size: 15px;
      margin-bottom: 6px;
      color: #f59e0b;
    }

    .survey-comment {
      font-size: 14px;
      margin-bottom: 8px;
    }

    .survey-date {
      font-size: 13px;
      color: var(--text-muted);
    }

    .pagination {
      margin-top: 30px;
      text-align: center;
    }

    .pagination a {
      margin: 0 6px;
      padding: 8px 14px;
      border-radius: 6px;
      font-size: 14px;
      font-weight: 500;
      color: var(--primary);
      border: 1px solid var(--primary);
      background-color: white;
      text-decoration: none;
      transition: 0.3s ease;
    }

    .pagination a:hover {
      background-color: var(--highlight);
    }

    .pagination a.current {
      background-color: var(--primary);
      color: white;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <!-- ✅ 상단 네비게이션 -->
  <jsp:include page ="../nav/topNav.jsp"></jsp:include>

  <!-- ✅ 메인 컨테이너 -->
  <main class="main-wrapper">

    <!-- ✅ 상단 안내 문구 -->
    <div class="title">
      <p>
        <span style="color: var(--text-muted);">${startDate} ~ ${endDate}</span> 기간 동안<br>
        <strong>${lecture.name}</strong> 강사의 <strong>${lecture.title}</strong> 강의에 대한 만족도 조사 결과입니다.
      </p>
    </div>

    <!-- ✅ 평균 평점 -->
    <div class="avg-score">
      ⭐ 평균 평점: ${surveyAvg} / 5
    </div>

    <!-- ✅ 설문 결과 리스트 -->
    <c:if test="${not empty surveyList}">
      <c:forEach var="survey" items="${surveyList}">
        <div class="survey-box">
          <div class="survey-rating">🌟 평점: ${survey.rating} / 5</div>
          <div class="survey-comment">💬 의견: ${survey.comment}</div>
          <div class="survey-date">📅 작성일: ${survey.createDate}</div>
        </div>
      </c:forEach>
    </c:if>

    <c:if test="${empty surveyList}">
      <p style="color: var(--text-muted); font-style: italic;">등록된 설문 결과가 없습니다.</p>
    </c:if>

    <!-- ✅ 페이징 -->
   <div class="pagination">
	  <c:if test="${currentPage > 1}">
	    <a href="?lectureId=${lecture.lectureId}&currentPage=${currentPage - 1}&size=8">« 이전</a>
	  </c:if>
	
	  <c:forEach var="i" begin="1" end="${totalPages}">
	    <a href="?lectureId=${lecture.lectureId}&currentPage=${i}&size=8"
	       class="${i == currentPage ? 'current' : ''}">${i}</a>
	  </c:forEach>
	
	  <c:if test="${currentPage < totalPages}">
	    <a href="?lectureId=${lecture.lectureId}&currentPage=${currentPage + 1}&size=8">다음 »</a>
	  </c:if>
	  
	  <!-- 🔙 돌아가기 버튼 (하단) -->
<div style="margin-top: 40px; text-align: center;">
  <button onclick="location.href='/mainPage'" style="
    padding: 10px 24px;
    background-color: var(--primary);
    color: white;
    font-size: 15px;
    font-weight: 500;
    border: none;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: background-color 0.3s ease;
  " onmouseover="this.style.backgroundColor='#1a5fd4'" onmouseout="this.style.backgroundColor='var(--primary)'">
    ← 돌아가기
  </button>
	  
	</div>

  </main>

  <!-- ✅ 푸터 -->
  <jsp:include page ="../nav/footer.jsp"></jsp:include>

</body>
</html>
