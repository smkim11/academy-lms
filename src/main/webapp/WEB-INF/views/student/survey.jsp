<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>과정 만족도 조사</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f9f9f9;
    }
		
	main {
	  display: flex;
	  justify-content: center;
	  align-items: flex-start; /* 세로 기준 상단 정렬 */
	  padding: 40px 20px;
	  box-sizing: border-box;
	  width: 100%;
	}

		
.survey-container {
  position: relative;
  left: 0%;
  transform: translateX(-50%);
  max-width: 520px;
  width: 100%;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  padding: 40px 30px;
  text-align: center;
  box-sizing: border-box;
}




    .survey-container h2 {
      margin-bottom: 10px;
      font-size: 24px;
      color: #333;
    }

    .guide-text {
      font-size: 15px;
      color: #666;
      margin-bottom: 24px;
    }

    .star_rating {
      display: flex;
      justify-content: center;
      margin-bottom: 16px;
    }

    .star_rating .star {
      width: 36px;
      height: 36px;
      margin: 0 5px;
      background: url('/images/emptyStar.png') no-repeat center;
      background-size: contain;
      cursor: pointer;
    }

    .star_rating .star.on {
      background: url('/images/fullStar.png') no-repeat center;
      background-size: contain;
    }

    #ratingDisplay {
      font-size: 14px;
      color: #444;
      margin-bottom: 20px;
    }

    .star_box {
      width: 100%;
      min-height: 100px;
      padding: 12px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 8px;
      resize: vertical;
      margin-bottom: 20px;
      font-family: inherit;
      box-sizing: border-box;
    }

    .btn-back,
    .btn-submit {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      font-weight: bold;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      margin-bottom: 12px;
      transition: background-color 0.3s ease;
    }

    .btn-back {
      background-color: #e0e0e0;
      color: #333;
    }

    .btn-back:hover {
      background-color: #ccc;
    }

    .btn-submit {
      background-color: #ffbb66;
      color: white;
    }

    .btn-submit:hover {
      background-color: #ffaa44;
    }

    @media (max-width: 480px) {
      .survey-container {
        padding: 30px 20px;
      }

      .star_rating .star {
        width: 30px;
        height: 30px;
        margin: 0 4px;
      }
    }
  </style>

  <script>
  $(function () {
	  $('.star_rating>.star').click(function () {
	    $(this).parent().children('span').removeClass('on');
	    $(this).addClass('on').prevAll('span').addClass('on');

	    // 선택한 별점 저장 및 표시
	    let rating = $(this).attr('value');
	    $('#ratingValue').val(rating);
	    $('#ratingText').text(rating); // 여기서만 숫자만 바꿔줌
	  });
	});

  </script>
</head>
<body>

  <div>
    <jsp:include page ="../nav/topNav.jsp"></jsp:include>
  </div>


  <main>
    <div class="survey-container">
      <h2>과정 만족도 조사</h2>
      <p class="guide-text">별점을 클릭하고 의견을 작성해주세요.</p>

      <form action="/student/survey" method="post">
        <div class="star_rating">
          <span class="star on" value="1"></span>
          <span class="star" value="2"></span>
          <span class="star" value="3"></span>
          <span class="star" value="4"></span>
          <span class="star" value="5"></span>
        </div>

        <p id="ratingDisplay">선택한 별점: <span id="ratingText">1</span>점</p>


        <input type="hidden" name="rating" id="ratingValue" value="1">
        <input type="hidden" name="enrollmentId" value="${enrollmentId}"> <!-- 실제 서버에서는 동적으로 처리 -->

        <textarea class="star_box" name="comment" placeholder="기타 의견을 작성해주세요."></textarea>

        <button type="button" class="btn-back" onclick="history.back()">뒤로 가기</button>
        <input type="submit" class="btn-submit" value="만족도조사 등록" />
      </form>
    </div>
  </main>


  <div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
  </div>

</body>
</html>
