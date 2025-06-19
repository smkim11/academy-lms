<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>강사용 공지사항 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<!-- ✅ 내비게이션 -->
<jsp:include page ="../nav/sideNav.jsp" />
<main class="content">
	<h1>공지사항 수정 (강사)</h1>

	<form action="/instructor/updateNotice" method="post">
	<input type="hidden" name="noticeId" value="${notice.noticeId}">
	<input type="hidden" name="lectureId" value="${notice.lectureId}">
		<table class="post-table">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required style="width: 400px;" value="${notice.title}"></td>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<select name="noticeType" required>
						<option value="">-- 선택 --</option>
						<option value="general" <c:if test="${notice.noticeType == 'general'}">selected</c:if>>일반</option>
                        <option value="schedule" <c:if test="${notice.noticeType == 'schedule'}">selected</c:if>>일정</option>
                        <option value="exam" <c:if test="${notice.noticeType == 'exam'}">selected</c:if>>시험</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="8" cols="60" required>${notice.content}</textarea>
				</td>
			</tr>
		</table>
		<br>
		<button type="submit">공지 수정</button>
		<a href="/instructor/noticeList/${lecture.lectureId}" class="back-link">← 목록으로</a>
	</form>
</main>
<!-- ✅ 푸터 -->
<jsp:include page ="../nav/footer.jsp" />
</body>
</html>
