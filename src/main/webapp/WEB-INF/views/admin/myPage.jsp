<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - 개인정보</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    main {
      flex: 1;
    }

    .wrapper {
    	
      max-width: 1200px;
      width: 100%;
      margin:  0 auto;
      padding: 80px 24px 120px 24px;
      box-sizing: border-box;
      display: flex;
      justify-content: center;
    }

    .info-table {
      width: 100%;
      max-width: 700px;
      margin-top: 80px;
      background-color: white;
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 50px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
    }

    .info-table h2 {
      font-size: 26px;
      margin-bottom: 35px;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
    }

    .info-row {
      display: flex;
      align-items: center;
      margin-bottom: 28px;
      border-bottom: 1px solid #eee;
      padding-bottom: 12px;
    }

    .info-row label {
      font-weight: 600;
      width: 160px;
      color: #333;
      display: flex;
      align-items: center;
    }

    .info-row label i {
      margin-right: 10px;
      color: #888;
    }

    .info-row span {
      color: #444;
      font-weight: 500;
    }

    .button-group {
      display: flex;
      justify-content: flex-end;
      gap: 12px;
      margin-top: 40px;
    }

    .info-button {
      padding: 10px 20px;
      border-radius: 6px;
      border: none;
      font-size: 0.95rem;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.2s ease;
    }

    .btn-password {
      background-color: #6c757d;
      color: white;
    }
    .btn-password:hover {
      background-color: #5a6268;
    }

    .btn-edit {
      background-color: #007bff;
      color: white;
    }
    .btn-edit:hover {
      background-color: #0056b3;
    }

    .profile-header {
      font-size: 20px;
      font-weight: bold;
      display: flex;
      align-items: center;
      margin-bottom: 25px;
    }

    .profile-icon {
      width: 45px;
      height: 45px;
      background-color: #007bff;
      color: white;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-right: 15px;
      font-weight: bold;
      text-transform: uppercase;
    }

    /* 반응형 */
    @media (max-width: 768px) {
      .info-row {
        flex-direction: column;
        align-items: flex-start;
      }

      .info-row label {
        width: 100%;
        margin-bottom: 5px;
      }

      .button-group {
        flex-direction: column;
        align-items: flex-end;
      }
    }
  </style>
</head>
<body>
  <div>
    <jsp:include page ="../nav/topNav.jsp"></jsp:include>
  </div>

 
    <div class="wrapper">
      <div class="info-table">
        <div class="profile-header">
          
          <div>내 개인정보</div>
        </div>

        <div class="info-row">
          <label><i class="fas fa-user"></i>이름</label>
          <span>${myPage.name}</span>
        </div>
        <div class="info-row">
          <label><i class="fas fa-envelope"></i>이메일</label>
          <span>${myPage.email}</span>
        </div>
        <div class="info-row">
          <label><i class="fas fa-phone"></i>휴대폰 번호</label>
          <span>${myPage.phone}</span>
        </div>
        <div class="info-row">
          <label><i class="fas fa-cake-candles"></i>생년월일</label>
          <span>${myPage.birth}</span>
        </div>

        <div class="button-group">
          <button type="button" class="info-button btn-password" onclick="location.href='/admin/updatePw'">비밀번호 변경</button>
          <button type="button" class="info-button btn-edit" onclick="location.href='/admin/updateInfo'">개인정보 수정</button>
        </div>
      </div>
    </div>


  <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
  </div>
</body>
</html>
