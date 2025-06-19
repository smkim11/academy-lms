<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의자료 등록</title>
<link rel="stylesheet" href="css/styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 상단바 + 사이드바(네비게이션) -->
<jsp:include page="../nav/sideNav.jsp">
  <jsp:param name="lectureId" value="${lectureId}" />
</jsp:include>
	<div class="top-bar">
	  <div class="logo">MyLMS</div>
	  <div class="user-info">
	    <div class="user-name">홍길동님</div>
	    <a class="edit-profile" href="/mypage">개인정보 수정</a>
	  </div>
	</div>
	
	<main>
    <h2 style="text-align: center;">📎 강의자료 다중 등록</h2>

    <form action="/addLectureMaterial" method="post" enctype="multipart/form-data">
        <input type="hidden" name="weekId" value="${weekId}" />

        <div id="upload-area">
            <div class="file-group">
                <label>자료명:</label>
                <input type="text" name="titles" required>
                <label>파일:</label>
                <input type="file" name="files" required>
                <button type="button" class="remove-btn">삭제</button>
            </div>
        </div>

        <button type="button" id="addRowBtn">+ 자료 추가</button>
        <button type="submit">📤 업로드</button>
    </form>
    	    <a href="/lectureMaterialList?weekId=${weekId}">
			    리스트로 돌아가기
			</a>

    <script>
    $(document).ready(function () {
        // 추가 버튼
        $('#addRowBtn').on('click', function () {
            const newField = `
                <div class="file-group">
                    <label>자료명:</label>
                    <input type="text" name="titles" required>
                    <label>파일:</label>
                    <input type="file" name="files" required>
                    <button type="button" class="remove-btn">삭제</button>
                </div>
            `;
            $('#upload-area').append(newField);
        });

        // 삭제 버튼 (이벤트 위임으로 처리)
        $('#upload-area').on('click', '.remove-btn', function () {
            $(this).closest('.file-group').remove();
        });
    });
    </script>
</main>
</body>
</html>