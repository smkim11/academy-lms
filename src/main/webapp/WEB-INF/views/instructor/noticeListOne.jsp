<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${notice.title} - 공지 상세</title>
</head>
<body>
    <h2>${lecture.title} - 공지 상세 (강사용)</h2>
    
    <h3>${notice.title}</h3>
    <p><strong>유형:</strong> ${notice.noticeType}</p>
    <p><strong>작성일:</strong> ${notice.createDate}</p>
    <hr>
    <p>${notice.content}</p>

    <br>
    <a href="/instructor/noticeList/${lecture.lectureId}">← 공지 목록으로</a>
</body>
</html>