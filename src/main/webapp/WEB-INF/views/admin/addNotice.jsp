<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>공지사항 등록(관리자)</title>
</head>
<body>
    <h1>📌 공지사항 등록 - ${lecture.title}</h1>

    <form action="/admin/addNotice" method="post">
        <input type="hidden" name="lectureId" value="${lecture.lectureId}" />

        <table border="1">
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" required style="width: 400px;"></td>
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
                <td><textarea name="content" rows="8" cols="60" required></textarea></td>
            </tr>
        </table>

        <br>
        <button type="submit">등록</button>
        <a href="/admin/noticeList/${lecture.lectureId}">← 목록으로</a>
    </form>
</body>
</html>
