<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/styles.css">
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
    <h2 style="text-align: center;">강의자료 상세</h2>

    <p><strong>자료명:</strong> ${material.title}</p>
    <p><strong>등록일:</strong> ${material.createDate}</p>
    <p><strong>파일:</strong> 
        <c:if test="${not empty material.fileUrl}">
            <a href="${material.fileUrl}" download>파일 다운로드</a>
        </c:if>
        <c:if test="${empty material.fileUrl}">
            없음
        </c:if>
    </p>

    <!-- 강사버전 → 수정/삭제/목록 버튼 우측 정렬 -->
    <div style="text-align: right; margin-top: 20px;">
        <a href="/updateLectureMaterial?materialId=${material.materialId}" 
           style="margin-right: 10px; font-weight: bold; color: #333;">수정하기</a>
        <a href="/deleteLectureMaterial?materialId=${material.materialId}" 
           onclick="return confirm('정말 삭제하시겠습니까?');"
           style="margin-right: 10px; font-weight: bold; color: red;">삭제하기</a>
        <a href="/lectureMaterialList?weekId=${material.weekId}" 
           style="font-weight: bold; color: #333;">목록으로</a>
    </div>
</main>
</body>
</html>