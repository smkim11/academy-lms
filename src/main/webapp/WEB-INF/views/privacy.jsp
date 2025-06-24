<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="../css/mainPage.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="no-sidebar">
<div>
	<jsp:include page="/WEB-INF/views/nav/topNav.jsp" />
</div>

  <main>
    <h2>📄 개인정보처리방침</h2>
    <p>본 사이트는 개인정보 보호법에 따라 이용자의 개인정보를 보호하고 관련 법규를 준수합니다.</p>

    <h3>1. 수집 항목</h3>
    <ul>
      <li>필수: 이름, 아이디, 이메일, 전화번호 등</li>
      <li>선택: 프로필 이미지, 추가 연락처 등</li>
    </ul>

    <h3>2. 수집 목적</h3>
    <p>회원 관리, 강의 신청·관리, 민원 처리 등을 위해 사용됩니다.</p>

    <h3>3. 보유 및 파기</h3>
    <p>관련 법령에 따른 보관 기간 후 즉시 안전하게 파기됩니다.</p>

    <h3>4. 동의 철회</h3>
    <p>회원은 언제든지 개인정보 수집 및 이용 동의를 철회할 수 있습니다.</p>
  </main>

  <div>
    <jsp:include page="/WEB-INF/views/nav/footer.jsp" />
  </div>
</body>
</html>
