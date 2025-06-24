<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/qna.css">
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp">
		<jsp:param name="lectureId" value="${lectureId}" />
	</jsp:include>
	
</div>
<main>
	<span class="page-title">${lectureTitle}</span>
	<span class="page-subtitle">[${lectureDay}/${lectureTime}]</span> &nbsp;
    <span class="qna-list-title">Q&A 상세보기</span>
    <table class="qna-table">
        <tr><th>제목</th><td style="text-align: left;">${qna.title}</td></tr>
        <tr><th>질문내용</th><td style="text-align: left;">${qna.question}</td></tr>
        <tr><th>공개여부</th>
            <td>
                <c:choose>
                    <c:when test="${qna.isPublic == 1}">공개</c:when>
                    <c:otherwise>비공개</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr><th>작성일</th><td>${qna.createDate}</td></tr>
        <tr><th>첨부파일</th>
            <td>
                <c:choose>
                    <c:when test="${not empty qna.fileUrl}">
                        <a href="${qna.fileUrl}" download>파일 다운로드</a>
                    </c:when>
                    <c:otherwise>없음</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <!-- 답변 등록 (강사 전용) -->
    <c:if test="${loginRole == 'instructor'}">
        <form action="/addAnswer" method="post" style="margin-top: 20px;">
            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
            <input type="hidden" name="lectureId" value="${lectureId}" />
            <textarea name="answer" style="width: 100%; height: 100px; padding: 8px; font-size: 14px;"></textarea>
            <div style="text-align: right; margin-top: 10px;">
                <button type="submit">
                    답변 등록
                </button>
            </div>
        </form>
    </c:if>

    <!-- 기존 답변 리스트 -->
    <c:forEach var="answer" items="${qnaAnswer}">
        <div style="border: 1px solid #ddd; border-radius: 8px; padding: 12px; margin-top: 16px; background-color: #f9fafb;">
            <p style="margin-bottom: 8px;">${answer.answer}</p>
            <p style="font-size: 12px; color: gray;">${answer.createDate}</p>

            <c:if test="${loginRole == 'instructor'}">
                <form action="/deleteAnswer" method="post" style="display: inline;">
                    <input type="hidden" name="answerId" value="${answer.answerId}" />
                    <input type="hidden" name="qnaId" value="${qna.qnaId}" />
                    <input type="hidden" name="lectureId" value="${lectureId}" />
                    <button type="submit">
                        삭제
                    </button>
                </form>
            </c:if>
        </div>
    </c:forEach>
	
<!-- 목록으로 버튼 -->
	    <div style="text-align: right; margin-top: 20px;">
	        <a href="/qna?lectureId=${lectureId}">목록으로</a>
	    </div>
	</main>
</main>
</body>
</html>