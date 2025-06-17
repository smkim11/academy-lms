<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
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
				<th>삭제</th>
			</tr>
			<c:forEach var="quizList" items="${quizList}">
				<tr>
					<th>${quizList.week}</th>
					<c:if test="${quizList.startedAt != null && quizList.endedAt != null}">
						<td>${quizList.startedAt} ~ ${quizList.endedAt}</td>
						
						<c:if test="${now >= quizList.startedAt && now <= quizList.endedAt}">
							<td><a href="/quizResult?lectureId=${lectureId }&weekId=${quizList.weekId}">응시중</td>
							<td>삭제불가</td>
						</c:if>
						
						<c:if test="${now < quizList.startedAt}">
							<td><a href="/updateQuiz?weekId=${quizList.weekId }">수정하기</a></td>
							<td><a href="/deleteQuiz?weekId=${quizList.weekId }&lectureId=${lectureId}">삭제하기</td>
						</c:if>
						
						<!-- 강사는 응시기간이 지나면 결과보기 가능 -->
						<c:if test="${now > quizList.endedAt}">
							<td><a href="/quizResult?lectureId=${lectureId }&weekId=${quizList.weekId}&status=end">결과보기</a></td>
							<td>삭제불가</td>
						</c:if>
					</c:if>
					<c:if test="${quizList.startedAt == null && quizList.endedAt == null}">
						<td><a href="/addQuiz?lectureId=${lectureId}&week=${quizList.week}">퀴즈 추가</a></td>
						<td>-</td>
						<td>-</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
</main>
</body>
</html>