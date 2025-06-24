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
	<span class="lectureMaterial-title">${week}주차 강의자료</span>
	
<table class="lectureMaterial-table">
    <tr>
        <th>자료명</th>
        <th>등록일</th>
    </tr>
    <c:forEach var="material" items="${materialList}">
        <tr>
            <td style="text-align: left;">
                <a href="/lectureMaterialOne?materialId=${material.materialId}">
                    ${material.title}
                </a>
            </td>
            <td>${material.createDate}</td>
        </tr>
    </c:forEach>
</table>

<div style="text-align: right; margin-bottom: 10px;">
    <a href="/addLectureMaterial?weekId=${weekId}" class="btn">강의자료 등록</a>
</div>
<!-- 돌아가기 버튼 -->
<div style="text-align: left; margin-top: 10px;">

    <a href="/lectureMaterialWeekList?lectureId=${lectureId}">
        주차별 리스트로 돌아가기
    </a>
</div>
	</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div> 
</body>
</html>