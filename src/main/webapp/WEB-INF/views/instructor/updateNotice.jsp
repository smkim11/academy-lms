<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>강사용 공지사항 수정</title>
</head>
<body>
	<h1>공지사항 수정 (강사)</h1>

	<form action="/instructor/updateNotice" method="post">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required style="width: 400px;" value=""></td>
			</tr>
			<tr>
				<th>강의번호</th>
				<td>
					<select name="lectureId" required>
						<option value="">--선택--</option>
						<c:forEach var="lecture" items="${lectures}">
            				<option value="${lecture.lectureId}">${lecture.lectureName}</option>
        				</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>유형</th>
				<td>
					<select name="noticeType" required>
						<option value="">-- 선택 --</option>
						<option value="general">일반</option>
						<option value="schedule">일정</option>
						<option value="exam">시험</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="8" cols="60" required value=""></textarea>
				</td>
			</tr>
		</table>
		<br>
		<button type="submit">공지 수정</button>
	</form>
</body>
</html>
