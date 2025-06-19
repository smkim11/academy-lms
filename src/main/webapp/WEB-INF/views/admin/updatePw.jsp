<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 변경</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    main {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 60px 16px;
      margin-right: 250px;
      box-sizing: border-box;
    }

    .wrapper {
      width: 100%;
      max-width: 600px;
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      padding: 40px;
      box-sizing: border-box;
    }

    h2 {
      margin-top: 0;
      margin-bottom: 30px;
      font-size: 24px;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
      color: #222;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      font-weight: bold;
      margin-bottom: 8px;
      color: #333;
    }

    .form-group input {
      width: 100%;
      padding: 12px;
      font-size: 1rem;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
    }

    .button-group {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
      gap: 10px;
      flex-wrap: wrap;
    }

    .btn {
      padding: 10px 20px;
      border-radius: 6px;
      font-size: 0.95rem;
      font-weight: bold;
      cursor: pointer;
      border: none;
      transition: background-color 0.2s ease;
    }

    .btn-back {
      background-color: #e0e0e0;
      color: #333;
    }

    .btn-back:hover {
      background-color: #cfcfcf;
    }

    .btn-submit {
      background-color: #28a745;
      color: white;
    }

    .btn-submit:hover {
      background-color: #28a745;
    }

    .error-msg {
      color: #d9534f;
      margin-top: 20px;
      font-weight: bold;
    }

    @media (max-width: 480px) {
      .button-group {
        flex-direction: column;
        align-items: stretch;
      }

      .btn {
        width: 100%;
      }
    }
  </style>
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
          <button type="button" class="btn btn-back" onclick="history.back()"> 뒤로 가기</button>
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
