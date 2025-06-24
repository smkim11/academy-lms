<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${lecture.title} - 공지사항</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notice.css">

    <script>
        function deleteNotice(noticeId, lectureId) {
            if (confirm('정말 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/admin/notices/' + noticeId,
                    type: 'DELETE',
                    success: function(response) {
                        alert('삭제되었습니다.');
                        location.href = '/admin/noticeList/' + lectureId;
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
<!-- 사이드 내비게이션 -->
<div>
    <jsp:include page="../nav/sideNav.jsp" />
</div>

<!-- 메인 컨테이너 -->
<main class="main-container">
    <h2>${lecture.title} - 공지사항 목록</h2>

    <!-- 새 공지 등록 버튼 -->
    <a href="/admin/addNotice?lectureId=${lecture.lectureId}" 
       class="submit-btn" style="margin-top: 10px; display: inline-block;">새 공지 등록</a>

    <!-- 공지 테이블 -->
    <div class="post-table">
        <table>
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
    </div>

    <!-- 돌아가기 링크 -->
    <a href="/admin/lectureOne?lectureId=${lecture.lectureId}" class="back-link">← 강의페이지로 돌아가기</a>
</main>

<!-- 푸터 -->
<div>
    <jsp:include page="../nav/footer.jsp" />
</div>
</body>
</html>
