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
	<h1>퀴즈 추가</h1>
	<c:if test="${not empty msg}">
		<div style="color:red">${msg }</div>
	</c:if>
	<a href="/quizList?lectureId=${lectureId }">퀴즈목록</a>
	<form method="post" action="/addQuiz" id="addQuizForm">
	<input type="hidden" name="lectureId" value="${lectureId}">
	<input type="hidden" name="source" value="${source}">
	<input type="hidden" name="currentPage" value="${currentPage}">
		<table border="1">
			<tr>
				<th>주차</th>
				<td>
					<input type="text" name="week" id="week" value="${week}" readonly>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<c:if test="${startedAt != null && endedAt != null }">
					<td>
						<input type="datetime-local" name="startedAt" id="startedAt" value="${startedAt}" readonly> 
						~ <input type="datetime-local" name="endedAt" id="endedAt" value="${endedAt}" readonly>
					</td>
				</c:if>
				<c:if test="${startedAt == null || endedAt == null }">
					<td>
						<input type="datetime-local" name="startedAt" id="startedAt" value="${startedAt}" > 
						~ <input type="datetime-local" name="endedAt" id="endedAt" value="${endedAt}" >
					</td>
				</c:if>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<input type="radio" name="type" value="객관식">객관식
					<input type="radio" name="type" value="주관식">주관식
				</td> 
			</tr>
		</table>
		<!-- 유형선택시 입력칸 출력 -->
		<div id="inputQuiz">
		
		</div>
	</form>
</main>

<script>
	// 문제유형에 따라 다른 입력칸 출력
	$('input[name="type"]').click(function(){
		let selectedType = $('input[name="type"]:checked').val();
		$.ajax({
			type:'get',
			url:'/questionType/'+selectedType,
			success:function(data){
				$('.inputList').empty();
				if(data == 'gek'){
					$('#inputQuiz').append(`
			            <div class="inputList">
			                번호 <input type="text" name="quizNo" id="quizNo" placeholder="번호를 입력해주세요." /><br>
			                문제 <input type="text" name="question" id="question" placeholder="문제를 입력해주세요." /><br>
		                	보기1 <input type="text" name="option1" id="option1" placeholder="보기1을 입력해주세요." /><br>
	                		보기2 <input type="text" name="option2" id="option2" placeholder="보기2를 입력해주세요." /><br>
               				보기3 <input type="text" name="option3" id="option3" placeholder="보기3을 입력해주세요." /><br>
               				보기4 <input type="text" name="option4" id="option4" placeholder="보기4를 입력해주세요." /><br>
	                		정답 <input type="text" name="correctAnswer" id="correctAnswer" placeholder="정답을 입력해주세요." /><br>
	                		해설 <textarea cols="50" rows="5" name="explanation" id="explanation" placeholder="해설을 입력해주세요."></textarea><br>
	                		<button type="button" id="btn">추가</button>
			        `);
				}else{
					$('#inputQuiz').append(`
			            <div class="inputList">
			                번호 <input type="text" name="quizNo" id="quizNo" placeholder="번호를 입력해주세요." /><br>
			                문제 <input type="text" name="question" id="question" placeholder="문제를 입력해주세요." /><br>
	                		정답 <input type="text" name="correctAnswer" id="correctAnswer" placeholder="정답을 입력해주세요." /><br>
	                		해설 <textarea cols="50" rows="5" name="explanation" id="explanation" placeholder="해설을 입력해주세요."></textarea><br>
	                		<button type="button" id="btn">추가</button>
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