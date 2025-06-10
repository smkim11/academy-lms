<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>${lecture.title} - 공지사항</title></head>
<body>
    <h2>📢 ${lecture.title} - 공지사항</h2>
    <table border="1">
        <thead>
            <tr>
                <th>제목</th>
                <th>유형</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td>
                        <a href="/student/noticeListOne/${lecture.lectureId}/${notice.noticeId}">
                            ${notice.title}
                        </a>
                    </td>
                    <td>${notice.noticeType}</td>
                    <td>${notice.createDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="/">← 강의 목록으로</a>
</body>
</html>
