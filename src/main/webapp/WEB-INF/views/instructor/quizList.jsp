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
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
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
				<th>삭제</th>
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
							<td>삭제불가</td>
						</c:if>
						
						<c:if test="${now < quizList.startedAt}">
							<td><a href="/updateQuiz?weekId=${quizList.weekId }">수정하기</a></td>
							<td><a id="del" href="/deleteQuiz?weekId=${quizList.weekId }&lectureId=${lectureId}">삭제하기</td>
						</c:if>
						
						<!-- 강사는 응시기간이 지나면 결과보기 가능 -->
						<c:if test="${now > quizList.endedAt}">
							<td><a href="/quizResult?lectureId=${lectureId }&weekId=${quizList.weekId}&status=end">결과보기</a></td>
							<td>삭제불가</td>
						</c:if>
					</c:if>
					<c:if test="${quizList.startedAt == null && quizList.endedAt == null}">
						<td colspan="3"><a href="/addQuiz?lectureId=${lectureId}&week=${quizList.week}">퀴즈 추가</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
		<div>
			<a href="/instructor/lectureOne?lectureId=${lectureId }">돌아가기</a>
		</div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
//삭제 재확인
$('#del').click(function(){
	const result = confirm("삭제하시겠습니까?");
	// 취소버튼 누르면 실행 X
	if(!result){
		return false;
	}
});
</script>
</body>
</html>