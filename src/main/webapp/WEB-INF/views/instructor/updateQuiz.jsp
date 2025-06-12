<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
<link rel="stylesheet" href="css/styles.css">
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
<div class="top-bar">
  <div class="logo">MyLMS</div>
  <div class="user-info">
    <div class="user-name">${loginUserId }님</div>
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
	<h1>퀴즈 수정</h1>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
	<form method="post" action="/updateQuiz" id="updateQuizForm">
	<input type="hidden" name="lectureId" value="${lectureId}">
	<input type="hidden" name="weekId" value="${weekId }">
	<input type="hidden" name="currentPage" value="${p.currentPage}">
		<!-- 문제 -->
		<c:forEach var="list" items="${list}">
		    <table border="1">
				<tr>
					<th>주차</th>
					<td><input type="text" name="week" id="week" value="${list.week}" readonly></td>
				</tr>
				<tr>
					<th>기간</th>
					<td>
						<input type="datetime-local" name="startedAt" id="startedAt" value="${list.startedAt}"> 
						~ <input type="datetime-local" name="endedAt" id="endedAt" value="${list.endedAt}">
					</td>
				</tr>
				<tr>
					<th>유형</th>
					<c:if test="${list.type eq '객관식'}">
						<td>
							<input type="radio" name="type" value="객관식" checked readonly>객관식
							<input type="radio" name="type" value="주관식" readonly>주관식
						</td>
					</c:if>
					<c:if test="${list.type eq '주관식'}">
						<td>
							<input type="radio" name="type" value="객관식" readonly>객관식
							<input type="radio" name="type" value="주관식" checked readonly>주관식
						</td>
					</c:if>
				</tr>
			</table>
			번호 <input type="text" name="quizNo" id="quizNo" value="${list.quizNo }"/><br>
	        문제 <input type="text" name="question" id="question" value="${list.question }" /><br>
			<!-- 보기 (정답을 입력하고 저장하면 제출한 정답체크) -->
			<c:if test="${not empty options}">
				    <c:forEach var="opt" items="${options}" varStatus="status">
				        <div>
				            <label>
				            	보기${status.count}<input type="text" name="option${status.count}" 
				            						id="option${status.count}" value="${opt.option}">
				            </label>
				        </div>
				    </c:forEach>
			</c:if>
			정답<input type="text" name="correctAnswer" id="correctAnswer" value="${list.correctAnswer}"><br>
			해설<textarea cols="50" rows="5" name="explanation" id="explanation">${list.explanation}</textarea><br>
		</c:forEach>
		<button type="button" id="btn">수정</button>
	</form>
	<!-- 페이징 -->
	<c:if test="${p.currentPage>1 }">
        <a href="/updateQuiz?weekId=${weekId }&currentPage=${p.currentPage-1 }">이전</a>
    </c:if>
    <span>${p.currentPage } / ${p.lastPage }</span>
    <c:if test="${p.currentPage<p.lastPage }">
        <a href="/updateQuiz?weekId=${weekId }&currentPage=${p.currentPage+1 }">다음</a>
    </c:if>
</main>
<script>
	$('#btn').click(function(){
		if($('#startedAt').val() != '' && $('#endedAt').val() != '' && $('#quizNo').val() != '' &&
		   $('#question').val() != '' && $('#correctAnswer').val() != '' && $('#explanation').val() != ''){
			$('#updateQuizForm').submit();
		}else{
			alert('입력하지 않은 값이 있습니다.');
		}
	
	});
</script>
</body>
</html>