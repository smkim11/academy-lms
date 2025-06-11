<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>학생 등록</title>
</head>
<body>
	<h1>학생 등록</h1>
	<p>lectureId: ${lectureId}</p>
	
	<form id="studentForm" action="/admin/addStudent" method="post">
	<input type="hidden" name="lectureId" value="${lectureId}">
		<table border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" required></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="userLoginId" required></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" name="email" id="email" required></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone" id="phone" required placeholder="예: 010-1234-5678"></td>
			</tr>
		</table>
		<br>
        <button type="submit">등록</button>
        <a href="/admin/studentList">← 목록으로</a>
	</form>

	<script>
		$('#studentForm').on('submit', function(e) {
			const email = $('#email').val().trim();
			const phone = $('#phone').val().trim();

			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			const phoneRegex = /^010-\d{4}-\d{4}$/;

			if (!emailRegex.test(email)) {
				alert("유효한 이메일 형식을 입력해주세요.");
				e.preventDefault();
				return;
			}

			if (!phoneRegex.test(phone)) {
				alert("전화번호는 010-1234-5678 형식으로 입력해주세요.");
				e.preventDefault();
				return;
			}
		});
	</script>
</body>
</html>
