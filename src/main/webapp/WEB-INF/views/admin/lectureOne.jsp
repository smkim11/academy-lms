<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .table-box {
    width: 100%;
    display: flex;
    justify-content: space-between;
    gap: 20px;
  }
  .table-half {
    flex: 1;
  }
  .table-half table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
  }
</style>
</head>
<body>

<div>
<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

	
<main style="padding: 100px 20px 20px 20px;">
  <!-- 좌우 분할을 위한 flex 컨테이너 -->
  <div style="display: flex; gap: 40px; align-items: flex-start;">

    <!-- 🎓 왼쪽: 강의 요약 정보 -->
    <section class="lecture-summary" style="flex: 1;">
      <div style="display: flex; align-items: center;">
        <h2 style="margin-right: 10px;">${lecture.title}</h2>
        <c:if test="${now lt lecture.startedAt }">
          <a href="/admin/updateLecture?lectureId=${lecture.lectureId}" class="edit-button" style="font-size: 14px;">✏️ 수정</a>
          <a href="/admin/lectureDelete?lectureId=${lecture.lectureId}" class="edit-button" style="font-size: 14px; color: red;" onclick="return confirm('정말 삭제하시겠습니까?');">🗑️ 삭제</a>
        </c:if>
      </div>
      <p><strong>강사:</strong> ${lecture.name}</p>
      <p><strong>시간:</strong> ${lecture.day} / ${lecture.time}</p>
      <p><strong>기간:</strong> ${lecture.startedAt} ~ ${lecture.endedAt}</p>

      <div style="margin-top: 25px;">
        <a href="/admin/studentList/${lecture.lectureId}" 
           style="display: inline-block; padding: 8px 16px; background-color: #3498db; color: white; border-radius: 4px; text-decoration: none; font-size: 14px;">
          👥 학생 리스트 보기
        </a>
      </div>
	<br><br>
	
	<a href="/lectureMaterialWeekList?lectureId=${lecture.lectureId}" style="font-size: 14px; text-decoration: none; color: #3498db;">강의자료 더보기</a>
      <!-- 강의자료 테이블 -->
      <div class="table-half" style="margin-top: 20px;"> 
        <h3>📚 강의자료 (1~5주차)</h3> 
        <table border="1">
          <thead>
            <tr>
              <th>주차</th>
              <th>자료 목록</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="week" begin="1" end="5">
              <tr>
                <td>${week}주차</td>
                <td>
                  <c:choose>
                    <c:when test="${not empty weekMaterialMap[week]}">
                      <ul>
                        <c:forEach var="material" items="${weekMaterialMap[week]}">
                          <li><a href="${material.fileUrl}" download>${material.title}</a></li>
                        </c:forEach>
                      </ul>
                    </c:when>
                    <c:otherwise>내용 없음</c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        
    	<a href="/qna?lectureId=${lecture.lectureId}" style="font-size: 14px; text-decoration: none; color: #3498db;">QNA 더보기</a>
	<!-- QNA 테이블 -->
	<div class="table-half" style="margin-top: 20px;"> 
	  <h3>📚 QNA 게시판</h3> 
	  <table border="1">
	    <thead>
	      <tr>
	      	<th>질문번호</th>
	        <th>제목</th>
	        <th>작성일자</th>
	        <th>작성자</th>
	        <th>공개여부</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:choose>
	        <c:when test="${not empty qnaList}">
	          <c:forEach var="qna" items="${qnaList}">
	            <tr>
	              <td><a href="/qnaOne?lectureId=${lecture.lectureId}&id=${qna.qnaId}">${qna.qnaId}</a></td>
	              <td>${qna.title}</td>
	              <td>${qna.createDate}</td>
	              <td>${qna.writerName}</td>
	              <td>
	                <c:choose>
	                  <c:when test="${qna.isPublic == 1}">공개</c:when>
	                  <c:otherwise>비공개</c:otherwise>
	                </c:choose>
	              </td>
	            </tr>
	          </c:forEach>
	        </c:when>
	        <c:otherwise>
	          <tr><td colspan="4">질문 없음</td></tr>
	        </c:otherwise>
	      </c:choose>
	    </tbody>
	  </table>
	</div>
    </section>

    <!-- 📋 오른쪽: 공지사항 + 퀴즈 -->
    <section class="lecture-notice" style="flex: 1; margin-top: 30px;">
      <!-- 공지 상단 영역 (제목 + 더보기 링크) -->
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h3 style="margin: 0;">📢 최근 공지사항</h3>
        <a href="/admin/noticeList/${lecture.lectureId}" style="font-size: 14px; text-decoration: none; color: #3498db;">공지 더보기</a>
      </div>

      <!-- 공지사항 테이블 -->
      <div style="margin-top: 10px;">
        <c:choose>
          <c:when test="${not empty lectureNoticeList}">
            <table class="notice-table" border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
              <thead>
                <tr>
                  <th style="width: 10%;">번호</th>
                  <th style="width: 30%;">공지타입</th>
                  <th style="width: 30%;">제목</th>
                  <th style="width: 30%;">작성일</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="notice" items="${lectureNoticeList}">
                  <tr>
                    <td><a href="/admin/noticeListOne/${lecture.lectureId}/${notice.noticeId}">${notice.noticeId}</a></td>
                    <td>${notice.noticeType}</td>
                    <td>${notice.title}</td>
                    <td>${fn:substring(notice.createDate, 0, 10)}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <p>등록된 공지사항이 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>


      <!-- 퀴즈 테이블 -->
      <div style="margin-top: 230px;">
      <a href="/quizList?lectureId=${lecture.lectureId}" style="font-size: 14px; text-decoration: none; color: #3498db;">퀴즈 더보기</a>
        <h3 style="margin-bottom: 10px;">📝 퀴즈 목록 (1~5주차)</h3>
        <c:choose>
          <c:when test="${not empty quizList}">
            <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
              <thead>
                <tr>
                  <th style="width: 10%;">주차</th>
                  <th style="width: 30%;">시작 시간</th>
                  <th style="width: 30%;">종료 시간</th>
                  <th style="width: 30%;">상태</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="quiz" items="${quizList}">
                  <tr>
                    <td>${quiz.week}주차</td>
                    <td><c:out value="${quiz.startedAt}" default="-"/></td>
                    <td><c:out value="${quiz.endedAt}" default="-"/></td>
                    <td>
                      <c:choose>
                        <c:when test="${not empty quiz.startedAt}">퀴즈 있음</c:when>
                        <c:otherwise>퀴즈 없음</c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <p>등록된 퀴즈가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
      
                  <!-- 스터디 그룹 게시판 -->
      <div style="margin-top: 80px;">
      <a href="/admin/studyPost/${lecture.lectureId}" style="font-size: 14px; text-decoration: none; color: #3498db;">스터디일지  더보기</a>
        <h3 style="margin-bottom: 10px;">📝 스터리 일지목록 </h3>
        <c:choose>
          <c:when test="${not empty postList}">
            <table border="1" style="width: 100%; border-collapse: collapse; text-align: left;">
              <thead>
                <tr>
                  <th style="width: 10%;">게시글 번호</th>
                  <th style="width: 30%;">제목</th>
                  <th style="width: 30%;">작성자</th>
                  <th style="width: 30%;">작성일</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="list" items="${postList}">
                  <tr>
                    <td>${list.postId}</td>
                    <td>${list.title}</td>
                    <td>${list.id}</td>
                    <td>${list.createDate}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <p>등록된 스터디일지가 없습니다.</p>
          </c:otherwise>
        </c:choose>
      </div>
      
      
    </section>
  </div> <!-- flex 끝 -->
</main>

<div>
   <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
