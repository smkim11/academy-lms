<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>개인정보 수정</title>
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
      margin-right: 250px;
    }

    h2 {
      margin-top: 0;
      margin-bottom: 30px;
      font-size: 24px;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
      color: #222;
    }

    table {
      width: 100%;
      border-spacing: 0 16px;
    }

    td {
      vertical-align: top;
      padding: 6px 4px;
    }

    label {
      font-weight: bold;
      color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="date"] {
      width: 100%;
      padding: 10px;
      font-size: 1rem;
      border: 1px solid #ccc;
      border-radius: 6px;
      box-sizing: border-box;
    }

    input[readonly] {
      background-color: #f0f0f0;
      color: #777;
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
      background-color: #218838;
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
      <h2>내 개인정보 수정</h2>

      <form action="/admin/updateInfo" method="post">
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
          <button type="button" class="btn btn-back" onclick="history.back()"> 뒤로 가기</button>
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
