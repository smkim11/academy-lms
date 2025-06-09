<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>강사용 공지사항</title>
</head>
<body>
    <h1>공지사항 목록 (강사)</h1>
    <a href="/instructor/addNotice">새 공지 등록</a>
    <table border="1">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>유형</th>
                <th>작성일</th>
                <th>관리</th>
            </tr>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td>${notice.noticeId}</td>
                    <td>${notice.title}</td>
                    <td>${notice.noticeType}</td>
                    <td>${notice.lastUpdate}</td>
                    <td class="action-btns">
                        <a href="/instructor/noticeList/${notice.noticeId}">상세보기</a>
                        <a href="/instructor/updateNotice/${notice.noticeId}">수정</a>
                        <a href="/instructor/noticeList/${notice.noticeId}/delete" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
