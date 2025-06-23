<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강생 정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main class="main-container">
    <h1>수강생 정보 수정</h1>

    <form id="updateForm" action="/admin/updateStudent" method="post">
        <input type="hidden" name="studentId" value="${student.studentId}" />
        <input type="hidden" name="lectureId" value="${lectureId}" />
        <table border="1">
            <tr>
                <th>이름</th>
                <td><input type="text" name="name" value="${student.name}" required /></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="email" id="email" name="email" value="${student.email}" required /></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" id="phone" name="phone" value="${student.phone}" required /></td>
            </tr>
        </table>
        <br />
        <button type="submit">수정 완료</button>
        <a href="/admin/studentList/${lectureId}">← 목록으로</a>
    </form>
    
    <script>
        $('#updateForm').on('submit', function(e) {
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
    </main>
    <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
