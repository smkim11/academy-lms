<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>강의별 수강생 목록</h2>

<!-- 검색 폼 -->
<form action="/admin/studentList/${lectureId}" method="get">
    <input type="text" name="searchWord" value="${searchWord}" placeholder="이름 검색" />
    <input type="submit" value="검색" />
</form>

<a href="/admin/addStudent?lectureId=${lectureId}">➕ 수강생 등록</a>

<!-- 수강생 테이블 -->
<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>가입일</th>
            <th>관리</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="student" items="${students}">
            <tr>
                <td>${student.name}</td>
                <td>${student.email}</td>
                <td>${student.phone}</td>
                <td>${student.createDate}</td>
                <td>
				    <a href="/admin/updateStudent/${student.studentId}">수정</a>
				    <a href="javascript:void(0);"
				       onclick="deleteStudent(${student.studentId}, ${lectureId})">삭제</a>
				</td>
            </tr>
        </c:forEach>
        <c:if test="${empty students}">
            <tr>
                <td colspan="4">수강생이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- 페이지 네비게이션 -->
<div style="margin-top:10px;">
    <c:forEach begin="1" end="${totalPage}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <b>[${i}]</b>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}&searchWord=${searchWord}">[${i}]</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>

<script>
function deleteStudent(studentId, lectureId) {
    if (confirm('정말 이 수강생을 강의에서 삭제하시겠습니까?')) {
        $.ajax({
            url: '/admin/students/' + studentId + '/lecture/' + lectureId,
            type: 'DELETE',
            success: function(response) {
                alert('삭제되었습니다.');
                location.href = '/admin/studentList/' + lectureId;
            },
            error: function(xhr) {
                alert('삭제 중 오류 발생');
                console.error(xhr.responseText);
            }
        });
    }
}
</script>
</body>
</html>
