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
    <span class="lectureMaterial-title">강의자료 수정</span>

 
    <form action="/updateLectureMaterial" method="post" enctype="multipart/form-data" style="margin-top: 20px;">
        <input type="hidden" name="materialId" value="${material.materialId}" />

        <table style="width: 100%; border-collapse: collapse; margin-top: 10px;">
            <tr>
                <td style="padding: 10px; font-weight: bold; width: 150px;">자료명</td>
                <td style="padding: 10px;">
                    <input type="text" name="title" value="${material.title}" required
                           style="width: 100%; padding: 8px; font-size: 14px; border: 1px solid #ccc;">
                </td>
            </tr>
            <tr>
                <td style="padding: 10px; font-weight: bold;">새 파일 업로드</td>
                <td style="padding: 10px;">
                    <input type="file" name="file" style="padding: 8px; font-size: 14px;">
                </td>
            </tr>
        </table>

        <!-- 수정 버튼 -->
        <div style="text-align: right; margin-top: 10px;">
            <button type="submit">
                수정 완료
            </button>
        </div>
    </form>

    <!-- 돌아가기 링크 -->
    <div style="text-align: left; margin-top: 10px;">
        <a href="/lectureMaterialOne?materialId=${material.materialId}">
            강의자료 상세로 돌아가기
        </a>
    </div>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>