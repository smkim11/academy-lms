<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 강의개설</title>
  <link rel="stylesheet" href="/css/styles.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
  const subjectMap = {
    "중국어": ["중국어 초급", "중국어 중급", "중국어 고급"],
    "영어": ["영어 초급", "영어 중급", "영어 고급"],
    "일본어": ["일본어 초급", "일본어 중급", "일본어 고급"]
  };



  
  $(function() {
	$('#createlecture').click(function(){
		const startval = $('#startdate').val();
		const lastval =  $('#enddate').val();
		const instructor = $('#instructor').val(); 
		const days = $("input[name='dayTemp']:checked").map(function(){
			return $(this).val();
		}).get().join(',');
		const time = $('#time').val();
		const title = $('#title').val();
		
		$('#dayHidden').val(days);
		
		
		if(!instructor){  // 강사값이 비어있는 경우
			alert("강사를 선택해주세요.");
			return;
		}
		
		if(days.length === 0){ // 요일이 비어있는 경우
			alert("요일을 선택해주세요.");
			return;
		}
		
		if(!time){ // 시간대 값이 비어있는 경우
			alert("시간대를 입력해주세요.");
			return;
		}
		
		if(!title){ // 과목 선택이 비어있는 경우 
			alert("과목을 선택해주세요.");
			return;
		}
		
		if(!startval || !lastval){ // 값이 비어있는 경우
			alert("날짜를 모두 입력해주세요.");
			return;
		};
		
		const start = new Date(startval); // 날짜 형태로 변경
		const end = new Date(lastval);  // 날짜 형태로 변경
		
		if(start > end) { // 시작일이 더 큰경우
			alert('시작일은 종료일보다 더 클수 없습니다.');
			return;
		}
		
		const diffDays = (end-start)/(1000*60*60*24);
		
		let week = diffDays/7;  // 몇주차 강의까지 개설하면 되는지 계산
		
		if(diffDays%7 != 0){
			week += 1;
		}
		
		week  = Math.floor(week); 
		const $week = $('#week');
		
		
		$week.val(week); 
		
		if (diffDays < 27){
			alert('종료일은 시작일로부터 최소 27일 이후여야 합니다.');
			return;
		}
		
		$('#form').submit();
		
	}); 
	  
	  
	$('#instructor').change(function () { // id 교수값이 바뀔때에 비동기 동작
      const instructorId = $(this).val();

      $.ajax({
        url: '/admin/getMajor',  // 서버 컨트롤러 주소
        type: 'GET',
        data: { instructorId: instructorId },
        dataType: 'text',
        success: function (major) {
          console.log("서버 응답:", major);
          console.log("trim 적용 후:", major.trim());
          
          const $title = $('#title');
          $title.empty();
          $title.append('<option value="" disabled selected>과목을 선택하세요</option>');
          
         
          const subjects = subjectMap[major];
          
          if (subjects) {
              subjects.forEach(subject => {
            	console.log("추가 중인 과목:", subject);  
            	$title.append('<option value="' + subject + '">' + subject + '</option>');

              });
            } else {
              $title.append('<option disabled>해당 전공 과목 없음</option>');
            }
          },
          error: function () {
            alert("전공 정보를 불러오지 못했습니다.");
          }
      });
    });
  });
</script>


</head>
<body>
  <div class="top-bar">
    <div class="logo">MyLMS</div>
    <div class="user-name">홍길동님</div>
  </div>



<div class="layout">
  <div class="side-bar">
    <ul>
      <li><a href="#">메인페이지</a></li>
      <li><a href="/admin/myPage">내 개인정보</a></li>
      <li><a href="/admin/updateInfo">개인정보 수정</a></li>
      <li><a href="/admin/updatePw">비밀번호 변경</a></li>
      <li><a href="/logOut">로그아웃</a></li>
    </ul>
  </div>

  <div class="main-content">
    <main>
      <h2>강의 개설</h2>
      <form action="/admin/createLecture" method="post" id ="form" >

		<input type="hidden" name="adminId" value="${adminId}">
		<input type="hidden" name="week" id="week" >
		<input type="hidden" name="day" id="dayHidden"> <!-- 요일 hidden -->
		
        <!-- ✅ 1. 강사 선택 -->
        <label for="instructor">강사 선택:</label>
        <select name="instructorId" id="instructor">
          <option value="" disabled selected>강사를 선택하세요</option>
          <c:forEach var="instructor" items="${instructorList}">
            <option value="${instructor.instructorId}">
              ${instructor.name} (${instructor.major})
            </option>
          </c:forEach>
        </select>
        <br><br>

        <!-- ✅ 2. 요일 선택 -->
        <label>요일 선택:</label><br>
        <label><input type="checkbox" name="dayTemp" class="day" value="월요일">월요일</label>
        <label><input type="checkbox" name="dayTemp" class="day" value="화요일">화요일</label>
        <label><input type="checkbox" name="dayTemp" class="day" value="수요일">수요일</label>
        <label><input type="checkbox" name="dayTemp" class="day" value="목요일">목요일</label>
        <label><input type="checkbox" name="dayTemp" class="day" value="금요일">금요일</label>
        <br><br>

        <!-- ✅ 3. 시간 선택 -->
        <label for="time">시간대 선택:</label>
        <select name="time" id="time">
          <option value="" disabled selected>시간대를 선택하세요</option>
          <option value="오전반">오전반</option>
          <option value="오후반">오후반</option>
          <option value="야간반">야간반</option>
        </select>
        <br><br>

        <!-- ✅ 4. 과목 선택 (전공에 따라 분기) -->
        <label for="title">과목 선택:</label>
        <select name="title" id="title" required>
          <option value="" disabled selected>과목을 선택하세요</option>
		</select>
    
    	<br><br>
    	<label for="description">과목 설명:</label>
    	<textarea name="description" id="description"></textarea>
    
    
     	<br>
    	<label for="startdate">시작 날짜: </label>
    	<label><input type="date" name="startedAt" id="startdate" required="required"></label>
    	
    	 <br>
        <label for="enddate">종료 날짜:</label>
        <label><input type="date" name="endedAt" id=enddate required="required"></label>
        
        <br><br>

        <!-- ✅ 제출 -->
        <button type="button" id="createlecture">강의 개설</button>
      </form>
    </main>
  </div>
</div>


   
</body>
</html>