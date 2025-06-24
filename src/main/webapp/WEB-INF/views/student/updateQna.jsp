<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/qna.css">
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
    <span class="qna-list-title">QnA 수정</span>

    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMsg}">
        <div style="color: red; margin-bottom: 15px; text-align: center; font-weight: bold;">
            ${errorMsg}
        </div>
    </c:if>

    <form action="/updateQna" method="post" enctype="multipart/form-data">
        <input type="hidden" name="qnaId" value="${qna.qnaId}">
        <input type="hidden" name="lectureId" value="${lectureId}">

        <table class="qna-table">
            <tr>
                <th style="width: 120px;">제목</th>
                <td><input type="text" name="title" value="${qna.title}" style="width: 100%; padding: 8px;" required></td>
            </tr>
            <tr>
                <th>공개여부</th>
                <td>
                    <label><input type="radio" name="isPublic" value="1" <c:if test="${qna.isPublic == 1}">checked</c:if>> 공개</label>
                    <label style="margin-left: 10px;"><input type="radio" name="isPublic" value="0" <c:if test="${qna.isPublic == 0}">checked</c:if>> 비공개</label>
                </td>
            </tr>
            <tr>
                <th>질문 내용</th>
                <td><textarea name="question" rows="6" style="width: 100%; padding: 8px;" required>${qna.question}</textarea></td>
            </tr>
            <tr>
                <th>파일 변경</th>
                <td><input type="file" name="file"></td>
            </tr>
        </table>

        <!-- 버튼 -->
        <div style="text-align: right; margin-top: 16px;">
            <button type="submit">
                수정 완료
            </button>
        </div>

        <div style="text-align: right; margin-top: 12px;">
            <a href="/qna?lectureId=${lectureId}">목록으로</a>
        </div>
    </form>
</main>
</body>
</html>