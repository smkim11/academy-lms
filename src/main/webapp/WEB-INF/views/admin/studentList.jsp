<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>
<div>
    <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
    <h2>강의별 수강생 목록</h2>

    <!-- 검색 폼 -->
    <form action="/admin/studentList/${lectureId}" method="get" class="search-form">
        <input type="text" name="searchWord" value="${searchWord}" placeholder="이름 검색" />
        <button type="submit">검색</button>
    </form>

    <div class="action-buttons">
        <a href="/admin/addStudent?lectureId=${lectureId}" class="back-link">수강생 등록</a>
        <a href="/admin/studyGroupForm?lectureId=${lectureId}" class="back-link">스터디 그룹 생성</a>
    </div>

    <!-- 수강생 테이블 -->
    <div class="post-table">
        <table>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>가입일</th>
                    <th>스터디 그룹</th>
                    <th>스터디 그룹 배정</th>
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
                            <c:choose>
                                <c:when test="${groupMap[student.studentId] != null}">
                                    ${groupNameMap[groupMap[student.studentId]]}
                                </c:when>
                                <c:otherwise>미배정</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="/admin/studyGroup/changeGroup" class="group-form">
                                <input type="hidden" name="lectureId" value="${lectureId}" />
                                <input type="hidden" name="studentId" value="${student.studentId}" />
                                <select name="newGroupId" required>
                                    <option value="">-- 조 선택 --</option>
                                    <c:forEach var="group" items="${groups}">
                                        <option value="${group.groupId}"
                                            <c:if test="${groupMap[student.studentId] == group.groupId}">selected</c:if>>
                                            ${group.groupName}
                                        </option>
                                    </c:forEach>
                                </select>
                                <button type="submit">변경</button>
                            </form>
                        </td>
                        <td>
                            <a href="/admin/updateStudent/${student.studentId}?lectureId=${lectureId}">수정</a>
                            <a href="javascript:void(0);" onclick="deleteStudent(${student.studentId}, ${lectureId})">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty students}">
                    <tr>
                        <td colspan="7">수강생이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 돌아가기 링크 -->
    <a href="/admin/lectureOne?lectureId=${lectureId}" class="back-link">← 강의페이지로 돌아가기</a>

    <!-- 페이지 네비게이션 -->
    <div class="pagination">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="current-page">[${i}]</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}&searchWord=${searchWord}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</main>

<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
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
