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
    <span class="lectureMaterial-title">강의자료 다중 등록</span>

    <form action="/addLectureMaterial" method="post" enctype="multipart/form-data" style="margin-top: 20px;">
        <input type="hidden" name="weekId" value="${weekId}" />

        <div id="upload-area">
            <div class="file-group" style="border: 1px solid var(--border); padding: 12px; border-radius: 8px; margin-bottom: 12px;">
                <label style="display: block; margin-bottom: 6px;">자료명:</label>
                <input type="text" name="titles" required style="width: 100%; padding: 8px; margin-bottom: 10px;">

                <label style="display: block; margin-bottom: 6px;">파일:</label>
                <input type="file" name="files" required>

                <div style="text-align: right; margin-top: 8px;">
                    <button type="button" class="remove-btn">
                        삭제
                    </button>
                </div>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div style="margin-top: 20px; text-align: right;">
            <button type="button" id="addRowBtn">
                + 자료 추가
            </button>
            <button type="submit">
                업로드
            </button>
        </div>

        <!-- 리스트로 돌아가기 -->
        <div style="margin-top: 16px; text-align: left;">
            <a href="/lectureMaterialList?weekId=${weekId}">리스트로 돌아가기</a>
        </div>
    </form>
</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
$(document).ready(function () {
    // 추가 버튼
    $('#addRowBtn').on('click', function () {
        const newField = `
            <div class="file-group" style="border: 1px solid #ccc; padding: 12px; border-radius: 8px; margin-top: 12px;">
                <label style="display: block; margin-bottom: 6px;">자료명:</label>
                <input type="text" name="titles" required style="width: 100%; padding: 8px; margin-bottom: 10px;">

                <label style="display: block; margin-bottom: 6px;">파일:</label>
                <input type="file" name="files" required>

                <div style="text-align: right; margin-top: 8px;">
                    <button type="button" class="remove-btn">
                            
                        삭제
                    </button>
                </div>
            </div>
        `;
        $('#upload-area').append(newField);
    });

    // 삭제 버튼
    $('#upload-area').on('click', '.remove-btn', function () {
        $(this).closest('.file-group').remove();
    });
});
</script>
</body>
</html>