<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
<!-- 질문 작성자 수정/삭제 버튼 노출 (학생 본인만 가능) -->
<div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 10px;">
    <c:if test="${(loginRole == 'student' and loginUserId == qnaStudentId) || loginRole == 'admin'}">
	    <a href="/updateQna?qnaId=${qna.qnaId}&lectureId=${lectureId}">
	        <button type="button">수정하기</button>
	    </a>
	</c:if>
    
    <c:if test="${(loginRole == 'student' and loginUserId == qnaStudentId) || loginRole == 'admin'}">
        <form action="/deleteQna" method="post" onsubmit="return confirm('정말로 삭제하시겠습니까?');" style="display: inline;">
            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
            <input type="hidden" name="lectureId" value="${lectureId}" />
            <button type="submit">삭제하기</button>
        </form>
    </c:if>
</div>
	
	    
<!-- 답변 리스트 -->
<c:forEach var="answer" items="${qnaAnswer}">
    <div style="border: 1px solid #ddd; border-radius: 10px; padding: 10px; margin-top: 10px; background-color: #f9fafb;">
        <div style="display: flex; justify-content: space-between;">
            <p style="margin-bottom: 10px;">
                ${answer.answer}
            </p>
            <c:if test="${answer.studentId == qnaStudentId}">
                <span style="color: #007bff; font-weight: bold;">[작성자]</span>
            </c:if>
        </div>
        <p style="font-size: 12px; color: gray;">${answer.createDate}</p>
    </div>
</c:forEach>

<!-- 답변 입력 폼 (강사 또는 질문 작성자만 보임) -->
<c:if test="${loginRole == 'instructor' || (loginRole == 'student' && loginUserId == qnaStudentId)}">
    <form action="/addAnswer" method="post" style="margin-top: 20px;">
        <input type="hidden" name="qnaId" value="${qna.qnaId}" />
        <input type="hidden" name="lectureId" value="${lectureId}" />
        <textarea name="answer" style="width: 100%; height: 100px; padding: 8px; font-size: 14px;" placeholder="답변 내용을 입력하세요"></textarea>
        <div style="text-align: right; margin-top: 10px;">
            <button type="submit">답변 등록</button>
        </div>
    </form>
</c:if>
	
<!-- 목록으로 버튼 -->
	    <div style="text-align: left; margin-top: 10px;">
	        <a href="/qna?lectureId=${lectureId}">목록으로</a>
	    </div>
	</main>
<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div> 
</body>
</html>