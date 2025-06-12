<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<link rel="stylesheet" href="css/styles.css">
<title>QnA 글쓰기</title>
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
	<div class="top-bar">
	  <div class="logo">MyLMS</div>
	  <div class="user-info">
	    <div class="user-name">홍길동님</div>
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
   <h2>QnA 글쓰기</h2>

	<form action="/addQna" method="post" enctype="multipart/form-data">
	<!-- 임시로 value 1로 설정 나중에수정해야함 -->
	    <input type="hidden" name="lectureId" value="1">
	    <table>
	        <tr>
	            <td><label for="title">제목</label></td>
	            <td><input type="text" id="title" name="title" required placeholder="제목을 입력하세요"></td>
	        </tr>
	        <tr>
	            <td><label for="file">첨부파일</label></td>
	            <td><input type="file" id="file" name="file"></td>
	        </tr>
	        <tr>
	            <td><label for="question">질문 내용</label></td>
	            <td><textarea id="question" name="question" rows="5" cols="50" required placeholder="질문 내용을 입력하세요"></textarea></td>
	        </tr>
	        <tr>
	            <td><label>공개 여부</label></td>
	            <td>
	                <label><input type="radio" name="isPublic" value="1" checked> 공개</label>
	                <label><input type="radio" name="isPublic" value="0"> 비공개</label>
	            </td>
	        </tr>
	        <tr>
	            <td colspan="2" style="text-align: right;">
	                <input type="submit" value="등록">
	            </td>
	        </tr>
	    </table>
	</form>
	</main>
</body>
</html>