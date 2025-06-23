<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>개인정보 수정</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
  <link rel="stylesheet" href="/css/updateInfo.css"> <%-- 외부 CSS 연결 --%>
</head>
<body>

  <div>
    <jsp:include page ="../nav/topNav.jsp"></jsp:include>
  </div>

  <main>
    <div class="wrapper">
      <h2>내 개인정보 수정</h2>

      <form action="/instructor/updateInfo" method="post">
        <table>
          <tr>
            <td><label for="name">이름</label></td>
            <td><input type="text" id="name" name="name" value="${myPage.name}" readonly></td>
          </tr>
          <tr>
            <td><label for="email">이메일</label></td>
            <td><input type="email" id="email" name="email" value="${myPage.email}" required></td>
          </tr>
          <tr>
            <td><label for="phone">휴대폰 번호</label></td>
            <td><input type="text" id="phone" name="phone" value="${myPage.phone}" required></td>
          </tr>
          <tr>
            <td><label for="birth">생년월일</label></td>
            <td><input type="date" id="birth" name="birth" value="${myPage.birth}" readonly></td>
          </tr>
        </table>

        <div class="button-group">
          <button type="button" class="btn btn-back" onclick="history.back()">뒤로 가기</button>
          <button type="submit" class="btn btn-submit">수정 완료</button>
        </div>
      </form>
    </div>
  </main>

  <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
  </div>

</body>
</html>
