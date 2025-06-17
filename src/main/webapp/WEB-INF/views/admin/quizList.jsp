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
	<span style="font-size: 40px">${lectureInfo.title }</span>
	<span style="font-size: 20px">[${lectureInfo.day }/${lectureInfo.time}]</span> &nbsp;
	<span style="font-size: 40px">퀴즈 목록</span>
		<table style="margin-top: 30px" border="1">
			<tr>
				<th>주차</th>
				<th>기간</th>
				<th>상태</th>
			</tr>
			<c:forEach var="quizList" items="${quizList}">
				<tr>
					<th>${quizList.week}</th>
					<c:if test="${quizList.startedAt != null && quizList.endedAt != null}">
						<td>${quizList.startedAt} ~ ${quizList.endedAt}</td>
						
						<c:if test="${now >= quizList.startedAt && now <= quizList.endedAt}">
							<td><a href="/quizResult?lectureId=${lectureId }&weekId=${quizList.weekId}">응시중</td>
						</c:if>
						
						<c:if test="${now < quizList.startedAt}">
							<td>응시전</td>
						</c:if>
						
						<!-- 강사는 응시기간이 지나면 결과보기 가능 -->
						<c:if test="${now > quizList.endedAt}">
							<td><a href="/quizResult?lectureId=${lectureId }&weekId=${quizList.weekId}&status=end">결과보기</a></td>
						</c:if>
					</c:if>
					<c:if test="${quizList.startedAt == null && quizList.endedAt == null}">
						<td>등록된 시험이 없습니다.</td>
						<td>-</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
</main>
</body>
</html>