<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>공지사항 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">
</head>
<body>

<!-- ✅ 내비게이션 -->
<jsp:include page ="../nav/sideNav.jsp" />

<!-- ✅ 본문 영역 -->
<main class="content">
    <h1>📌 공지사항 등록 - ${lecture.title}</h1>

    <form action="${pageContext.request.contextPath}/instructor/addNotice" method="post" class="notice-form">
        <input type="hidden" name="lectureId" value="${lecture.lectureId}" />

        <table class="post-table">
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" required style="width: 100%;"></td>
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
                <td><textarea name="content" rows="8" cols="60" required style="width: 100%;"></textarea></td>
            </tr>
        </table>

        <div class="form-actions">
            <button type="submit" class="btn-primary">등록</button>
            <a href="${pageContext.request.contextPath}/instructor/noticeList/${lecture.lectureId}" class="back-link">← 목록으로</a>
        </div>
    </form>
</main>

<!-- ✅ 푸터 -->
<jsp:include page ="../nav/footer.jsp" />

</body>
</html>
