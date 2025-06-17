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
	<h1>${week }주차 퀴즈 수정</h1>
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
					<th>번호</th>
					<td><input type="text" name="quizNo" id="quizNo" value="${list.quizNo }" readonly></td>
				</tr>
				<tr>
					<!-- onclick을 사용하여 유형은 변경할 수 없게 설정 -->
					<th>유형</th>
					<c:if test="${list.type eq '객관식'}">
						<td>
							<input type="radio" name="type" value="객관식" checked onclick="return false;">객관식
							<input type="radio" name="type" value="주관식" onclick="return false;">주관식
						</td>
					</c:if>
					<c:if test="${list.type eq '주관식'}">
						<td>
							<input type="radio" name="type" value="객관식" onclick="return false;">객관식
							<input type="radio" name="type" value="주관식" checked onclick="return false;">주관식
						</td>
					</c:if>
				</tr>
			</table>
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
			<button type="button" id="btn">수정</button>
			<!-- 수정페이지에서 문항을 추가하는경우 addQuiz로 이동할 때 source=modify를 추가 -->
			<a href="/addQuiz?lectureId=${lectureId}&week=${list.week}&startedAt=${list.startedAt}&endedAt=${list.endedAt}&quizNo=${p.lastPage}&source=update&currentPage=${p.lastPage}">추가</a>
			<a href="/deleteQuizOne?weekId=${weekId }&currentPage=${p.currentPage}&quizId=${list.quizId}">삭제</a>
		</c:forEach>
		
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
$('#btn').click(function() {
    const type = $('input[name="type"]:checked').val();
    
    if ($('#startedAt').val() == '' || $('#endedAt').val() == '' || 
        $('#quizNo').val() == '' || $('#question').val() == '' || 
        $('#correctAnswer').val() == '' || $('#explanation').val() == '') {
        alert('입력하지 않은 값이 있습니다.');
        return;
    }

    // 객관식인 경우 보기 유효성 검사
    if (type === '객관식') {
        let allOptionsFilled = true;

        // 보기 입력란이 몇 개인지 동적으로 확인
        $('[id^="option"]').each(function() {
            if ($(this).val().trim() === '') {
                allOptionsFilled = false;
            }
        });

        if (!allOptionsFilled) {
            alert('객관식 보기 내용을 모두 입력해주세요.');
            return;
        }
    }

    $('#updateQuizForm').submit();
});

</script>
</body>
</html>