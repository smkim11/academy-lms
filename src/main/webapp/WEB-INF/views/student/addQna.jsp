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


	<main style="max-width: 800px; margin: 20px auto; padding: 20px;">
	    <h2 style="text-align: center;">QnA 글쓰기</h2>
	    <form action="/addQna" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="lectureId" value="${lectureId}">
	
	        <table style="width: 100%; border-collapse: collapse;">
	            <tr>
	                <td style="padding: 8px;"><label for="title">제목</label></td>
	                <td style="padding: 8px;">
	                    <input type="text" id="title" name="title" required placeholder="제목을 입력하세요" style="width: 100%; padding: 8px;">
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px;"><label for="file">첨부파일</label></td>
	                <td style="padding: 8px;">
	                    <input type="file" id="file" name="file">
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px; vertical-align: top;"><label for="question">질문 내용</label></td>
	                <td style="padding: 8px;">
	                    <textarea id="question" name="question" rows="5" style="width: 100%; padding: 8px;" required placeholder="질문 내용을 입력하세요"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px;"><label>공개 여부</label></td>
	                <td style="padding: 8px;">
	                    <label><input type="radio" name="isPublic" value="1" checked> 공개</label>
	                    <label style="margin-left: 10px;"><input type="radio" name="isPublic" value="0"> 비공개</label>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="2" style="text-align: right; padding: 8px;">
	                    <input type="submit" value="등록"
	                           style="padding: 8px 16px; font-size: 14px; font-weight: bold; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
	                </td>
	            </tr>
	        </table>
<!-- 목록으로 버튼 -->
		    <div style="text-align: right; margin-top: 20px;">
		        <a href="/qna?lectureId=${lectureId}" style="font-weight: bold; color: #333;">목록으로</a>
		    </div>
	    </form>
	</main>
</body>
</html>