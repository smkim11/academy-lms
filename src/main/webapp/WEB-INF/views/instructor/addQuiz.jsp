<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/quizStyles.css">
<meta charset="UTF-8">
<style>
	.quiz-table {
		max-width: 800px
	}
</style>
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main>
	<h1 class="page-title">${week}주차 퀴즈 추가</h1>
	<c:if test="${not empty msg}">
		<div style="color:red">${msg }</div>
	</c:if>
	<form method="post" action="/addQuiz" id="addQuizForm">
	<input type="hidden" name="lectureId" value="${lectureId}">
	<input type="hidden" name="source" value="${source}">
	<input type="hidden" name="currentPage" value="${currentPage}">
		<table class="quiz-table form-table">
			<tr>
				<th>주차</th>
				<td>
					<input type="text" name="week" id="week" value="${week}" readonly class="form-input">
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<c:if test="${startedAt != null && endedAt != null }">
					<td>
						<input type="datetime-local" name="startedAt" id="startedAt" value="${startedAt}" readonly class="form-input-sm"> 
						<span class="date-separator">~</span>
						<input type="datetime-local" name="endedAt" id="endedAt" value="${endedAt}" readonly class="form-input-sm">
					</td>
				</c:if>
				<c:if test="${startedAt == null || endedAt == null }">
					<td>
						<input type="datetime-local" name="startedAt" id="startedAt" value="${startedAt}" class="form-input-sm"> 
						<span class="date-separator">~</span>
						<input type="datetime-local" name="endedAt" id="endedAt" value="${endedAt}" class="form-input-sm">
					</td>
				</c:if>
			</tr>
			<tr>
				<th>번호</th>
				<td>
					<input type="text" name="quizNo" id="quizNo" value="${quizNo}" readonly class="form-input">
				</td>
			</tr>
			<tr>
				<th>유형</th>
				<td class="form-radio-group">
					<label><input type="radio" name="type" value="객관식"> 객관식</label>
					<label><input type="radio" name="type" value="주관식"> 주관식</label>
				</td> 
			</tr>
		</table>

		<!-- 유형선택시 입력칸 출력 -->
		<div id="inputQuiz" class="quiz-dynamic-input">
		
		</div>
	</form>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
	// 문제유형에 따라 다른 입력칸 출력
	$('input[name="type"]').click(function(){
		let selectedType = $('input[name="type"]:checked').val();
		$.ajax({
			type:'get',
			url:'/questionType/'+selectedType,
			success:function(data){
				$('.inputList').remove();
				if(data == 'gek'){
					$('#inputQuiz').append(`
						<div class="inputList form-wrapper">
							<div class="form-group">  
								<label for="question">문제</label>
								<input type="text" name="question" id="question" placeholder="문제를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="option1">1번</label>
								<input type="text" name="option1" id="option1" placeholder="1번 보기를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="option2">2번</label>
								<input type="text" name="option2" id="option2" placeholder="2번 보기를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="option3">3번</label>
								<input type="text" name="option3" id="option3" placeholder="3번 보기를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="option4">4번</label>
								<input type="text" name="option4" id="option4" placeholder="4번 보기를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="correctAnswer">정답</label>
								<input type="text" name="correctAnswer" id="correctAnswer" placeholder="정답을 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="explanation">해설</label>
								<textarea name="explanation" id="explanation" placeholder="해설을 입력해주세요." class="form-textarea"></textarea>
							</div>
							<div class="btn-group">
								<button type="button" id="btn" class="form-btn">추가</button>
							</div>
						</div>
			        `);
				}else{
					$('#inputQuiz').append(`
						<div class="inputList form-wrapper">
							<div class="form-group">
								<label for="question">문제</label>
								<input type="text" name="question" id="question" placeholder="문제를 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="correctAnswer">정답</label>
								<input type="text" name="correctAnswer" id="correctAnswer" placeholder="정답을 입력해주세요." class="form-control" />
							</div>
							<div class="form-group">
								<label for="explanation">해설</label>
								<textarea name="explanation" id="explanation" placeholder="해설을 입력해주세요." class="form-textarea"></textarea>
							</div>
							<div class="btn-group">
								<button type="button" id="btn" class="form-btn">추가</button>
							</div>
						</div>
			        `);
				}
			}
		});
	});
	
	$('#inputQuiz').on('click', '#btn', function(){
		const type = $('input[name="type"]:checked').val();
	    
	    if ($('#week').val() == ''  || $('#startedAt').val() == '' || $('#endedAt').val() == '' || 
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
		$('#addQuizForm').submit();
	});
</script>
</body>
</html>