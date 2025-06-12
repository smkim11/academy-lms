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
		<table border="1">
			<tr>
				<th>주차</th>
				<td>
				<c:if test="${week == null }">
					<select name="week" id="week">
						<c:forEach var="list" items="${weekList }">
							<option value="${list.week}">${list.week}</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${week != null }">
					<select name="week" id="week">
						<c:forEach var="list" items="${weekList }">
							<option value="${week}">${week}</option>
						</c:forEach>
					</select>
				</c:if>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<input type="datetime-local" name="startedAt" value="${startedAt}"> 
					~ <input type="datetime-local" name="endedAt" value="${endedAt}">
				</td>
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
			                번호 <input type="text" name="quizNo" placeholder="번호를 입력해주세요." /><br>
			                문제 <input type="text" name="question" placeholder="문제를 입력해주세요." /><br>
		                	보기1 <input type="text" name="option1" placeholder="보기1을 입력해주세요." /><br>
	                		보기2 <input type="text" name="option2" placeholder="보기2를 입력해주세요." /><br>
               				보기3 <input type="text" name="option3" placeholder="보기3을 입력해주세요." /><br>
               				보기4 <input type="text" name="option4" placeholder="보기4를 입력해주세요." /><br>
	                		정답 <input type="text" name="correctAnswer" placeholder="정답을 입력해주세요." /><br>
	                		해설 <textarea cols="50" rows="5" name="explanation" placeholder="해설을 입력해주세요."></textarea><br>
	                		<button type="button" id="btn">추가</button>
			        `);
				}else{
					$('#inputQuiz').append(`
			            <div class="inputList">
			                번호 <input type="text" name="quizNo" placeholder="번호를 입력해주세요." /><br>
			                문제 <input type="text" name="question" placeholder="문제를 입력해주세요." /><br>
	                		정답 <input type="text" name="correctAnswer" placeholder="정답을 입력해주세요." /><br>
	                		해설 <textarea cols="50" rows="5" name="explanation" placeholder="해설을 입력해주세요."></textarea><br>
	                		<button type="button" id="btn">추가</button>
			        `);
				}
			}
		});
	});
	
	$('#inputQuiz').on('click', '#btn', function(){
		$('#addQuizForm').submit();
	});
</script>
</body>
</html>