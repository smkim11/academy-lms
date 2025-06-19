<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의자료 상세 보기</title>
<link rel="stylesheet" href="/css/styles.css">
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
  <h2 style="text-align: center;">📄 강의자료 상세</h2>

  <c:if test="${not empty material}">
    <p><strong>자료명:</strong> ${material.title}</p>
    <p><strong>등록일:</strong> ${material.createDate}</p>
    <p><strong>파일:</strong>
      <c:if test="${not empty material.fileUrl}">
        <a href="${material.fileUrl}" download>📥 다운로드</a>
      </c:if>
      <c:if test="${empty material.fileUrl}">
        없음
      </c:if>
    </p>
  </c:if>

  <div style="text-align: right; margin-top: 20px;">
    <a href="/updateLectureMaterial?materialId=${material.materialId}" style="margin-right: 10px; font-weight: bold;">✏ 수정</a>
    <a href="/deleteLectureMaterial?materialId=${material.materialId}" 
       onclick="return confirm('정말 삭제하시겠습니까?');"
       style="margin-right: 10px; font-weight: bold; color: red;">🗑 삭제</a>
    <a href="/lectureMaterialList?weekId=${material.weekId}" style="font-weight: bold;">📚 목록으로</a>
  </div>
</main>
</body>
</html>