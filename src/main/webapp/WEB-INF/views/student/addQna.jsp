<%@ page contentType="text/html; charset=UTF-8" %>
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
	
<!-- 에러 메시지 출력 영역(유효성 조작 사용자 대비 보안차원) -->
    <c:if test="${not empty errorMsg}">
        <div style="color: red; margin-bottom: 15px; text-align: center; font-weight: bold;">
            ${errorMsg}
        </div>
    </c:if>
	
    <span class="qna-list-title">QnA 글쓰기</span>
	    <form action="/addQna" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="lectureId" value="${lectureId}">
	
	        <table style="width: 100%; border-collapse: collapse;">
	            <tr>
	                <td style="padding: 8px;"><label for="title">제목</label></td>
	                <td style="padding: 8px;">
	                    <input type="text" id="title" name="title" required placeholder="제목을 입력하세요" style="width: 100%; padding: 8px;">
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px;"><label for="file">첨부파일</label></td>
	                <td style="padding: 8px;">
	                    <input type="file" id="file" name="file">
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px; vertical-align: top;"><label for="question">질문 내용</label></td>
	                <td style="padding: 8px;">
	                    <textarea id="question" name="question" rows="5" style="width: 100%; padding: 8px;" required placeholder="질문 내용을 입력하세요"></textarea>
	                </td>
	            </tr>
	            <tr>
	                <td style="padding: 8px;"><label>공개 여부</label></td>
	                <td style="padding: 8px;">
	                    <label><input type="radio" name="isPublic" value="1" checked> 공개</label>
	                    <label style="margin-left: 10px;"><input type="radio" name="isPublic" value="0"> 비공개</label>
	                </td>
	            </tr>
	            <tr>
	                <td colspan="2" style="text-align: right; padding: 8px;">
	                    <input type="submit" value="등록" class="btn">
	                </td>
	            </tr>
	        </table>
<!-- 목록으로 버튼 -->
		    <div style="text-align: left; margin-top: 10px;">
		        <a href="/qna?lectureId=${lectureId}">목록으로</a>
		    </div>
	    </form>
	</main>
</body>
</html>