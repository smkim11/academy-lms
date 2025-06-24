<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 변경</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
  <link rel="stylesheet" href="/css/updatePw.css">  <%-- 외부 CSS 연결 --%>
  <script type="text/javascript">
  $(function(){ 
	  const password = $('#newPw').val().trim();
	  
	  if(password.length < 3){
		  alert("비밀번호는 4자이상이여야 합니다.");
	  }
	  
  })
  </script>
</head>
<body>

  <div>
    <jsp:include page ="../nav/topNav.jsp"></jsp:include>
  </div>

  <main>
    <div class="wrapper">
      <h2>비밀번호 변경</h2>

      <form action="/admin/updatePw" method="post">
        <div class="form-group">
          <label for="currentPw">현재 비밀번호</label>
          <input type="password" id="currentPw" name="currentPw" required>
        </div>

        <div class="form-group">
          <label for="newPw">새 비밀번호</label>
          <input type="password" id="newPw" name="newPw" required>
        </div>

        <div class="form-group">
          <label for="newPwCheck">새 비밀번호 확인</label>
          <input type="password" id="newPwCheck" name="newPwCheck" required>
        </div>

        <div class="button-group">
          <button type="button" class="btn btn-back" onclick="history.back()">뒤로 가기</button>
          <button type="submit" class="btn btn-submit">비밀번호 변경</button>
        </div>
      </form>

      <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
      </c:if>
    </div>
  </main>

  <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
  </div>

</body>
</html>
