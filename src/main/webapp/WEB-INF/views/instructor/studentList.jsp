<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>강의별 수강생 목록(강사)</title>
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
    <form method="get" action="/instructor/studentList/${lectureId}" class="search-form">
        <input type="text" name="searchWord" placeholder="이름 검색" value="${searchWord}" />
        <button type="submit">검색</button>
    </form>

    <br/>
    <a href="/instructor/studyGroupForm?lectureId=${lectureId}" class="back-link">스터디 그룹 생성</a>

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
                            <form method="post" action="/instructor/studyGroup/changeGroup" class="group-form">
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
                    </tr>
                </c:forEach>

                <c:if test="${empty students}">
                    <tr>
                        <td colspan="6">수강생이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <br>
    <a href="/instructor/lectureOne?lectureId=${lectureId}" class="back-link">← 강의페이지로 돌아가기</a>

    <!-- 페이지 네비게이션 -->
    <div class="pagination">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="current-page">[${i}]</span>
                </c:when>
                <c:otherwise>
                    <a href="/instructor/studentList/${lectureId}?page=${i}&searchWord=${searchWord}">[${i}]</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</main>

<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
