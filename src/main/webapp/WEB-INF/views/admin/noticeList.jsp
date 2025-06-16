<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>${lecture.title} - 공지사항</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    function deleteNotice(noticeId, lectureId) {
	        if (confirm('정말 삭제하시겠습니까?')) {
	            $.ajax({
	                url: '/instructor/notices/' + noticeId,
	                type: 'DELETE',
	                success: function(response) {
	                    alert('삭제되었습니다.');
	                    // 현재 페이지를 새로고침하거나, 다시 목록을 불러옵니다
	                    location.href = '/instructor/noticeList/' + lectureId;
	                },
	                error: function(xhr) {
	                    alert('삭제 중 오류가 발생했습니다.');
	                    console.error(xhr.responseText);
	                }
	            });
	        }
	    }
	</script>
</head>

<body>
    <h1>📚 ${lecture.title} - 공지사항 목록</h1>

    <!-- 새 공지 등록 버튼 -->
    <a href="/admin/addNotice?lectureId=${lecture.lectureId}">➕ 새 공지 등록</a>

    <!-- 공지 목록 테이블 -->
    <table border="1">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>유형</th>
                <th>작성일</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
	                <td>${notice.noticeId}</td>
	                <td>
	                    <a href="/admin/noticeListOne/${lecture.lectureId}/${notice.noticeId}">
	                        ${notice.title}
	                    </a>
	                </td>
	                <td>${notice.noticeType}</td>
	                <td>${notice.createDate}</td>
	                <td>
	                    <a href="/admin/updateNotice/${notice.noticeId}">수정</a>
	                    <a href="javascript:void(0);"
	                       onclick="deleteNotice(${notice.noticeId}, ${lecture.lectureId})">삭제</a>
	                </td>
	            </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
