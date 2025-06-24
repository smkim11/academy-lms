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

<!-- 사이드바 -->
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<!-- 메인 콘텐츠 -->
<main class="main-container">
    <h2>수강생 정보 수정</h2>

    <!-- ✅ 폼 박스 -->
    <div class="form-box">
        <form id="updateForm" action="/admin/updateStudent" method="post">
            <input type="hidden" name="studentId" value="${student.studentId}" />
            <input type="hidden" name="lectureId" value="${lectureId}" />

            <!-- 이름 -->
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="${student.name}" required />
            </div>

            <!-- 이메일 -->
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="${student.email}" required />
            </div>

            <!-- 전화번호 -->
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" value="${student.phone}" required />
            </div>

            <!-- 버튼 -->
            <div class="form-group" style="margin-top: 20px;">
                <button type="submit" class="submit-btn">수정 완료</button>
                <a href="/admin/studentList/${lectureId}" class="back-link">← 목록으로</a>
            </div>
        </form>
    </div>

    <!-- ✅ JS 유효성 검사 -->
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

<!-- 푸터 -->
<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
