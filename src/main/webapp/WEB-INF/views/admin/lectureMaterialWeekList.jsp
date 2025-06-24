<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  	<span class="lectureMaterial-title">강의자료 주차별 리스트</span>
   <ul style="list-style-type: none; padding-left: 0; margin-top: 20px;">
        <c:forEach var="week" items="${weekList}">
            <li style="margin-bottom: 10px;">
                <a href="/lectureMaterialList?weekId=${week.weekId}">
                    📘 ${week.week}주차 강의자료
                </a>
            </li>
        </c:forEach>
    </ul>

    <!-- 뒤로가기 링크 -->
    <div style="margin-top: 10px;">
        <a href="/admin/lectureOne?lectureId=${lectureId}">
            ← 강의정보로 돌아가기
        </a>
    </div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div> 
</body>
</html>