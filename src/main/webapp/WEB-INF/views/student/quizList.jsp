<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lmsStyle.css">
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
	<div>
		<a href="/student/lectureOne?lectureId=${lectureId }">돌아가기</a>
	</div>
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
						
						<!-- 퀴즈 응시는 1회만 가능 -->
						<c:if test="${now >= quizList.startedAt && now <= quizList.endedAt}">
							<c:if test="${quizList.joinId == null }">
								<td><a id="joinQuiz" href="/quizOne?weekId=${quizList.weekId }">응시하기</a></td>
							</c:if>
							<c:if test="${quizList.joinId != null }">
								<td><a href="/student/quizResult?weekId=${quizList.weekId}&joinId=${quizList.joinId}">결과보기</a></td>
							</c:if>
						</c:if>
						
						<!-- 응시기록이 없으면 결과보기 X -->
						<c:if test="${now > quizList.endedAt}">
							<c:if test="${quizList.joinId != null }">
								<td><a href="/student/quizResult?weekId=${quizList.weekId}&joinId=${quizList.joinId}">결과보기</a></td>
							</c:if>
							<c:if test="${quizList.joinId == null }">
								<td>미응시</td>
							</c:if>
						</c:if>
						
						<c:if test="${now < quizList.startedAt}">
							<td>시작전</td>
						</c:if>
					</c:if>
					<c:if test="${quizList.startedAt == null && quizList.endedAt == null}">
						<td colspan="2">등록된 시험이 없습니다.</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
   // 퀴즈 응시하기 클릭시 안내메세지 
	$('#joinQuiz').click(function(){
		const join = confirm("퀴즈응시는 1회만 가능합니다.");
		// 취소누르면 실행 X (알림창에서 확인->true반환 취소->false반환)
		if(!join){
			return false;
		}
	});
</script>
</body>
</html>