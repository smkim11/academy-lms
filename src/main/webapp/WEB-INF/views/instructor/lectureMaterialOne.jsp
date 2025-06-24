<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/lectureMaterial.css">
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp">
		<jsp:param name="lectureId" value="${lectureId}" />
	</jsp:include>
	
</div>
<main>
	<span class="page-title">${lectureTitle}</span>
	<span class="page-subtitle">[${lectureDay}/${lectureTime}]</span> &nbsp;
	
  <span class="lectureMaterial-title">강의자료 상세</span>


    <c:if test="${not empty material}">
        <div style="margin-top: 20px; line-height: 1.8; font-size: 15px;">
            <p><strong>자료명:</strong> ${material.title}</p>
            <p><strong>등록일:</strong> ${material.createDate}</p>
            <p><strong>파일:</strong>
                <c:choose>
                    <c:when test="${not empty material.fileUrl}">
                        <a href="${material.fileUrl}" download style="color: var(--primary); font-weight: bold;">📥다운로드</a>
                    </c:when>
                    <c:otherwise>없음</c:otherwise>
                </c:choose>
            </p>
        </div>
    </c:if>

    <!-- 버튼 영역 -->
    <div style="text-align: right; margin-top: 10px;">
        <a href="/updateLectureMaterial?materialId=${material.materialId}" class="btn">수정</a>
        <a href="/deleteLectureMaterial?materialId=${material.materialId}" class="btn"
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
    </div>
    <div style="text-align: left; margin-top: 10px;">
        <a href="/lectureMaterialList?weekId=${material.weekId}">목록으로</a>
    </div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div> 
</body>
</html>