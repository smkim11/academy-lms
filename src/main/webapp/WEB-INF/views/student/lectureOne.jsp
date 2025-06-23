<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="stylesheet" href="/css/lectureDetailStudent.css">
</head>
<body>

<div>
  <jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>

<main class="main-container">
  <div class="flex-container">

    <!-- 왼쪽 영역 -->
    <section class="lecture-summary flex-1">
      <div class="flex-container">
        <h2 class="mr-10">${lecture.title}</h2>
      </div>
      <p><strong>강사:</strong> ${lecture.name}</p>
      <p><strong>시간:</strong> ${lecture.day} / ${lecture.time}</p>
      <p><strong>기간:</strong> ${lecture.startedAt} ~ ${lecture.endedAt}</p>

      <br><br>

      <div class="section-header2">
        <div class="section-header">      
          <h3 class="quiz-list-title">강의자료 (1~5주차)</h3>
          <a href="/lectureMaterialWeekList?lectureId=${lecture.lectureId}" class="fs-14 no-underline blue-text">더보기</a>
        </div>
        <div class="table-half mt-20">
          <table class ="styled-table">
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
        </div>
      </div>

      <div class="section-header mt-20">
        <h3 class="quiz-list-title">QNA 게시판</h3>
        <a href="/qna?lectureId=${lecture.lectureId}" class="fs-14 no-underline blue-text">더보기</a>
      </div>
      <div class="table-half mt-10">
        <table class="styled-table">
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
                <tr><td colspan="5">질문 없음</td></tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </section>

    <!-- 오른쪽 영역 -->
    <section class="lecture-notice flex-1">
      <div class="notice-header">
        <h3>📢 최근 공지사항</h3>
        <a href="/student/noticeList/${lecture.lectureId}" class="fs-14 no-underline blue-text">더보기</a>
      </div>

      <div class="table-half mt-10">
        <c:choose>
          <c:when test="${not empty lectureNoticeList}">
            <table class= "styled-table">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>공지타입</th>
                  <th>제목</th>
                  <th>작성일</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="notice" items="${lectureNoticeList}">
                  <tr>
                    <td><a href="/student/noticeListOne/${lecture.lectureId}/${notice.noticeId}">${notice.noticeId}</a></td>
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

      <!-- 퀴즈 목록 위로 끌어올림 -->
     <div class="section-header mt-quiz-align quiz-header">
        <h3 class="quiz-list-title">퀴즈 목록 (1~5주차)</h3>
        <a href="/quizList?lectureId=${lecture.lectureId}" class="fs-15 no-underline blue-text">더보기</a>
      </div>
      <div class="table-half mt-10">
        <c:choose>
          <c:when test="${not empty quizList}">
            <table class ="styled-table">
              <thead>
                <tr>
                  <th>주차</th>
                  <th>시작 시간</th>
                  <th>종료 시간</th>
                  <th>상태</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="quiz" items="${quizList}">
                  <tr>
                    <td>${quiz.week}주차</td>
                    <td><c:out value="${quiz.startedAt}" default="-" /></td>
                    <td><c:out value="${quiz.endedAt}" default="-" /></td>
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

      <div class="section-header mt-30 ">
        <h3 class="quiz-list-title">스터디 일지목록</h3>
        <a href="/student/studyPost/${lecture.lectureId}" class="fs-14 no-underline blue-text"> 더보기</a>
      </div>
      <div class="table-half mt-10">
        <c:choose>
          <c:when test="${not empty postList}">
            <table class = "styled-table">
              <thead>
                <tr>
                  <th>게시글 번호</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
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
  </div>
</main>

<div>
  <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
</body>
</html>
