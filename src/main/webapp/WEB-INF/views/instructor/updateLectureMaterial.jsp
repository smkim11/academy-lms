<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    <h2 style="text-align: center;">강의자료 수정</h2>

    <form action="/updateLectureMaterial" method="post" enctype="multipart/form-data"
          style="margin-top: 20px;">
        <!-- 수정 시 materialId 전달 필요 -->
        <input type="hidden" name="materialId" value="${material.materialId}"/>

        <table style="width: 100%; border-collapse: collapse; text-align: left;">
            <tr>
                <td style="padding: 10px; font-weight: bold; width: 150px;">제목</td>
                <td style="padding: 10px;">
                    <input type="text" name="title" value="${material.title}" required
                           style="width: 100%; padding: 8px; font-size: 14px;"/>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px; font-weight: bold;">기존 파일</td>
                <td style="padding: 10px;">
                    <c:if test="${not empty material.fileUrl}">
                        <a href="${material.fileUrl}" target="_blank">${material.fileUrl}</a>
                    </c:if>
                    <c:if test="${empty material.fileUrl}">
                        없음
                    </c:if>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px; font-weight: bold;">새 파일 업로드</td>
                <td style="padding: 10px;">
                    <input type="file" name="file" style="padding: 8px; font-size: 14px;"/>
                </td>
            </tr>
        </table>

        <!-- 버튼 영역 -->
        <div style="text-align: right; margin-top: 20px;">
            <button type="submit"
                    style="padding: 10px 20px; font-size: 16px; font-weight: bold; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                수정 완료
            </button>
        </div>
    </form>

    <!-- 뒤로가기 -->
    <div style="text-align: right; margin-top: 10px;">
        <a href="/lectureMaterialOne?materialId=${material.materialId}" style="font-weight: bold; color: #333;">← 강의자료 상세로 돌아가기</a>
    </div>
</main>
</body>
</html>