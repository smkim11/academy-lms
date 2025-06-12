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
	
	<form id="studentForm" action="/admin/addStudent" method="post">
	<input type="hidden" name="lectureId" value="${lectureId}">
		<table border="1">
			<tr>
				<th>아이디</th>
    			<td><input type="text" name="userLoginId" required></td>
			</tr>
		</table>
		<br>
        <button type="submit">등록</button>
        <a href="/admin/studentList/${lectureId}">← 목록으로</a>
        <c:if test="${not empty error}">
	        <p style="color:red;">${error}</p>
	    </c:if>
	</form>

</body>
</html>
