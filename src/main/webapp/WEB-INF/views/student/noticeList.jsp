<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>학생용 공지사항</title>
</head>
<body>
    <h1>공지사항 목록 (학생)</h1>
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>유형</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td>${notice.noticeId}</td>
                    <td>${notice.title}</td>
                    <td>${notice.noticeType}</td>
                    <td>${notice.lastUpdate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
