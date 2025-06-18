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
        body {
            font-family: "맑은 고딕", sans-serif;
            margin: 30px;
            background-color: #fefefe;
        }
        .title {
            font-size: 20px;
            margin-bottom: 20px;
        }
        .avg-score {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #333;
        }
        .survey-box {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .survey-rating {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .survey-comment {
            margin-bottom: 5px;
        }
        .survey-date {
            font-size: 12px;
            color: #777;
        }
        .pagination {
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 4px;
            padding: 5px 10px;
            border: 1px solid #aaa;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
        }
        .pagination a.current {
            font-weight: bold;
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
	
	<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
	</div>
	
<main>
    <!-- ✅ 상단 안내 문구 -->
    <div class="title">
        <p>
            <span style="font-weight: 500;">${startDate} ~ ${endDate}</span> 기간 과정에<br>
            <strong>${lecture.name}</strong> 강사의 <strong>${lecture.title}</strong> 강의에 대한 만족도 조사 결과입니다.
        </p>
    </div>

    <!-- ✅ 평균 평점 -->
    <div class="avg-score">
        ⭐ 평균 평점: <span style="color: #2c3e50;">${surveyAvg}</span> / 5
    </div>

    <!-- ✅ 설문 리스트 -->
    <c:forEach var="survey" items="${surveyList}">
        <div class="survey-box">
            <div class="survey-rating">🌟 평점: ${survey.rating} / 5</div>
            <div class="survey-comment">💬 의견: ${survey.comment}</div>
            <div class="survey-date">📅 작성일: ${survey.createDate}</div>
        </div>
    </c:forEach>

    <!-- ✅ 페이징 처리 -->
    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?lectureId=${lecture.lectureId}&currentPage=${i}&size=8" 
               class="${i == currentPage ? 'current' : ''}">
               ${i}
            </a>
        </c:forEach>
    </div>
</main>

<div>
   <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>

</body>
</html>
