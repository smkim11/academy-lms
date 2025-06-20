<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/quizStyles.css">
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp">
		<jsp:param name="lectureId" value="${lectureId}" />
	</jsp:include>
	
</div>
<main>
	<span class="page-title">${lectureInfo.title }</span>
	<span class="page-subtitle">[${lectureInfo.day }/${lectureInfo.time}]</span> &nbsp;
	<span class="quiz-list-title">퀴즈 목록</span>
		<table class="quiz-table">
			<tr>
				<th>주차</th>
				<th>기간</th>
				<th>상태</th>
			</tr>
			<c:forEach var="quizList" items="${quizList}">
				<tr>
					<th>${quizList.week}</th>
					<c:if test="${quizList.startedAt != null && quizList.endedAt != null}">
						<!-- 시간 중간에 T 삭제 -->
						<td>
							<c:set var="formatStarted" value="${fn:replace(quizList.startedAt, 'T', ' ')}" />
								<span>${formatStarted}</span> ~ 
							<c:set var="formatEnded" value="${fn:replace(quizList.endedAt, 'T', ' ')}" />
								<span>${formatEnded}</span>
						</td>
						
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
						<td colspan="2">등록된 시험이 없습니다.</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="/admin/lectureOne?lectureId=${lectureId }">돌아가기</a>
		</div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>