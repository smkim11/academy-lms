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
	<jsp:include page ="../nav/sideNav.jsp">
		<jsp:param name="lectureId" value="${lectureId}" />
	</jsp:include>
</div>
<main>
	<c:forEach var="quiz" items="${list}">
		<h1>${quiz.week }주차 퀴즈</h1>
		<form method="post" action="/quizOne" id="quizOneForm">
		<input type="hidden" name="weekId" value="${weekId }">
		<input type="hidden" name="joinId" value="${joinId }">
		<input type="hidden" name="currentPage" value="${p.currentPage}">
			
			<!-- 문제 -->
		    <div>	
		    	<input type="hidden" name="quizNo" value="${quiz.quizNo}">
		        <b>${quiz.quizNo}번 ${quiz.question}</b>
		    </div>
	</c:forEach>
		
		<!-- 보기 (정답을 입력하고 저장하면 제출한 정답체크) -->
		<c:if test="${not empty options}">
			<c:if test="${answer != null}">
			    <c:forEach var="opt" items="${options}">
			        <div>
			            <label>
			            	<!-- 객관식 답을 저장할때 optionNo는 숫자형이므로 문자형으로 형변환 -->
			            	<c:if test="${answer == opt.optionNo.toString()}">
			            		<input type="radio" name="answer" value="${opt.optionNo.toString()}" checked> ${opt.option}
			            	</c:if>
			            	<c:if test="${answer != opt.optionNo.toString()}">
			            		<input type="radio" name="answer" value="${opt.optionNo.toString()}"> ${opt.option}
			            	</c:if>
			            </label>
			        </div>
			    </c:forEach>
			</c:if>
			<c:if test="${answer == null}">
				<c:forEach var="opt" items="${options}">
			        <div>
			            <label>
			            	<input type="radio" name="answer" value="${opt.optionNo.toString()}"> ${opt.option}
			            </label>
			        </div>
			    </c:forEach>
			</c:if>
		</c:if>
		<c:if test="${empty options}">
			<c:if test="${answer != null}">
				<input type="text" name="answer" id="answer" value="${answer}">
			</c:if>
			<c:if test="${answer == null}">
				<input type="text" name="answer" id="answer">
			</c:if>
		</c:if>
		
		<!-- 마지막페이지면 제출버튼 아니면 저장버튼 -->
		<input type="hidden" name="btn" id="btn">
		<c:if test="${p.currentPage!=p.lastPage }">
			<div>
				<button type="button" id="saveBtn">저장</button>
			</div>
		</c:if>
		<c:if test="${p.currentPage==p.lastPage }">
			<div>
				<button type="button" id="submitBtn">제출</button>
			</div>
		</c:if>
	</form>
	
	<!-- 페이징 -->
	<c:if test="${p.currentPage>1 }">
        <a href="/quizOne?weekId=${weekId }&currentPage=${p.currentPage-1 }">이전</a>
    </c:if>
    <span>${p.currentPage } / ${p.lastPage }</span>
    <c:if test="${p.currentPage<p.lastPage }">
        <a href="/quizOne?weekId=${weekId }&currentPage=${p.currentPage+1 }">다음</a>
    </c:if>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
	$('#saveBtn').click(function(){
		// 주관식 답
	    const subjective = $('#answer').val();
		// 객관식 답
	    const objective = $('input[name="answer"]:checked').val();

	    if ((subjective === '' || subjective === undefined) && objective === undefined) {
	        alert('정답을 입력하세요.');
	    } else {
	        $('#btn').val('save');
	        $('#quizOneForm').submit();
	    }
	});

	$('#submitBtn').click(function(){
		// 주관식 답
	    const subjective = $('#answer').val();
	 	// 객관식 답
	    const objective = $('input[name="answer"]:checked').val();

	    if ((subjective === '' || subjective === undefined) && objective === undefined) {
	        alert('정답을 입력하세요.');
	    } else {
	        $('#btn').val('submit');
	        $('#quizOneForm').submit();
	    }
	});
</script>
</body>
</html>