<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/quizStyles.css">
<style>
/* 문제 전체 영역 여백 및 정리 */
.form-wrapper {
  margin: 24px 0;
  padding: 16px 20px;
  background-color: var(--bg-light);
  border-radius: 8px;
  border: 1px solid var(--border);
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
}

/* 문제 텍스트 정리 */
.form-wrapper p {
  font-size: 16px;
  color: var(--text-dark);
  line-height: 1.6;
}

/* 객관식 보기 정렬 */
.form-radio-group {
  margin: 8px 20px;
  display: flex;
  align-items: center;
  font-size: 15px;
  color: var(--text-dark);
}

/* 주관식 정답 입력란 여백 */
.form-group {
  margin: 16px 20px;
}

/* 입력 필드 스타일 조정 */
.form-control {
  width: 80%;
  max-width: 400px;
  padding: 10px 12px;
  font-size: 14px;
  border: 1px solid var(--border);
  border-radius: 6px;
  background-color: #fff;
  box-sizing: border-box;
}
/* 답: input 수평 정렬 */
.form-group-horizontal {
  display: flex;
  align-items: center;
  margin: 16px 20px;
}

.form-group-horizontal label {
  margin-right: 8px;
  font-size: 16px;
  color: var(--text-dark);
  white-space: nowrap;
}

.form-group-horizontal .form-control {
  flex: 1; /* 남은 공간 다 사용하게 */
  max-width: 200px;
}
.shift-right {
  margin-left: 340px; 
}
</style>
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
	<form method="post" action="/quizOne" id="quizOneForm">
		<c:forEach var="quiz" items="${list}">
			<h1 class="page-title">${quiz.week }주차 퀴즈</h1>
			<input type="hidden" name="weekId" value="${weekId }">
			<input type="hidden" name="joinId" value="${joinId }">
			<input type="hidden" name="currentPage" value="${p.currentPage}">
				
				<!-- 문제 -->
			    <div class="form-wrapper form-group shift-right">
			    	<input type="hidden" name="quizNo" value="${quiz.quizNo}">
			        <p><label for="No">${quiz.quizNo}번</label> ${quiz.question}</p>
			    </div>
		</c:forEach>
			<!-- 보기 (정답을 입력하고 저장하면 제출한 정답체크) -->
			<c:if test="${not empty options}">
				<c:if test="${answer != null}">
				    <c:forEach var="opt" items="${options}">
				        <div class="form-radio-group shift-right">
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
				        <div class="form-radio-group shift-right">
				            <label>
				            	<input type="radio" name="answer" value="${opt.optionNo.toString()}"> ${opt.option}
				            </label>
				        </div>
				    </c:forEach>
				</c:if>
			</c:if>
			<c:if test="${empty options}">
				<c:if test="${answer != null}">
					<div class="form-group-horizontal shift-right">
						<label for="answer">답:</label>
						<input type="text" name="answer" id="answer" class="form-control" value="${answer}">
					</div>
				</c:if>
				<c:if test="${answer == null}">
					<div class="form-group-horizontal shift-right">
						<label for="answer">답:</label>
						<input type="text" name="answer" id="answer" class="form-control">
					</div>
				</c:if>
			</c:if>
			
			<!-- 마지막페이지면 제출버튼 아니면 저장버튼 -->
			<input type="hidden" name="btn" id="btn">
			<c:if test="${p.currentPage!=p.lastPage }">
				<div class="btn-group">
					<button type="button" id="saveBtn" class="form-btn">저장</button>
				</div>
			</c:if>
			<c:if test="${p.currentPage==p.lastPage }">
				<div class="btn-group">
					<button type="button" id="submitBtn" class="form-btn">제출</button>
				</div>
			</c:if>
		</form>
	<!-- 페이징 -->
	<div class="pagination">
	    <c:if test="${p.currentPage>1}">
	      <a href="/quizOne?weekId=${weekId}&currentPage=${p.currentPage-1}" class="page-link">이전</a>
	    </c:if>
	    <span class="page-current">${p.currentPage} / ${p.lastPage}</span>
	    <c:if test="${p.currentPage<p.lastPage}">
	      <a href="/quizOne?weekId=${weekId}&currentPage=${p.currentPage+1}" class="page-link">다음</a>
	    </c:if>
  	</div>
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