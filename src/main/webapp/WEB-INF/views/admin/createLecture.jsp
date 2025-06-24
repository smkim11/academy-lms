<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>관리자 강의개설</title>
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f6f8;
      display: flex;
      flex-direction: column;
    }

    .page-wrapper {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    main {
      flex: 1;
      display: flex;
      justify-content: flex-start;
      padding: 50px 20px;
      box-sizing: border-box;
    }

    .main-content {
      background: #ffffff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      padding: 40px;
      width: 100%;
      max-width: 720px;
      box-sizing: border-box;
      margin-left: 170px;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 24px;
      color: #333;
    }

    form label {
      font-weight: bold;
      color: #333;
      display: block;
      margin-top: 18px;
      margin-bottom: 6px;
    }

    form select,
    form input[type="date"],
    form textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    form textarea {
      resize: vertical;
      min-height: 70px;
    }

    .day {
      display: inline-block;
      margin-right: 10px;
      margin-top: 4px;
    }

    .button-group {
      margin-top: 30px;
      display: flex;
      justify-content: flex-end;
    }

    button {
      padding: 10px 18px;
      font-size: 14px;
      font-weight: 600;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    button[type="button"] {
      background-color: #ddd;
      color: #333;
      margin-right: 10px;
    }

    button#createlecture {
      background-color: #4caf50;
      color: white;
    }
  </style>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script type="text/javascript">
    const subjectMap = {
      "중국어": ["중국어 초급", "중국어 중급", "중국어 고급"],
      "영어": ["영어 초급", "영어 중급", "영어 고급"],
      "일본어": ["일본어 초급", "일본어 중급", "일본어 고급"]
    };

    $(function () {
      $('#createlecture').click(function () {
        const startval = $('#startdate').val();
        const lastval = $('#enddate').val();
        const instructor = $('#instructor').val();
        const days = $("input[name='dayTemp']:checked").map(function () {
          return $(this).val();
        }).get().join(',');
        const time = $('#time').val();
        const title = $('#title').val();

        $('#dayHidden').val(days);

        if (!instructor) {
          alert("강사를 선택해주세요.");
          return;
        }
        if (days.length === 0) {
          alert("요일을 선택해주세요.");
          return;
        }
        if (!time) {
          alert("시간대를 입력해주세요.");
          return;
        }
        if (!title) {
          alert("과목을 선택해주세요.");
          return;
        }
        if (!startval || !lastval) {
          alert("날짜를 모두 입력해주세요.");
          return;
        }

        const start = new Date(startval);
        const end = new Date(lastval);
        if (start > end) {
          alert('시작일은 종료일보다 더 클 수 없습니다.');
          return;
        }

        const diffDays = (end - start) / (1000 * 60 * 60 * 24);
        let week = diffDays / 7;
        if (diffDays % 7 != 0) {
          week += 1;
        }

        week = Math.floor(week);
        $('#week').val(week);

        if (diffDays < 27) {
          alert('종료일은 시작일로부터 최소 27일 이후여야 합니다.');
          return;
        }

        $('#form').submit();
      });

      $('#instructor').change(function () {
        const instructorId = $(this).val();

        $.ajax({
          url: '/admin/getMajor',
          type: 'GET',
          data: { instructorId: instructorId },
          dataType: 'text',
          success: function (major) {
            const $title = $('#title');
            $title.empty();
            $title.append('<option value="" disabled selected>과목을 선택하세요</option>');
            const subjects = subjectMap[major.trim()];
            if (subjects) {
              subjects.forEach(subject => {
                $title.append('<option value="' + subject + '">' + subject + '</option>');
              });
            } else {
              $title.append('<option disabled>해당 전공 과목 없음</option>');
            }
          },
          error: function () {
            alert("전공 정보를 불러오지 못했습니다.");
          }
        });
      });
    });
  </script>
</head>

<body>
  <div class="page-wrapper">
    <jsp:include page="../nav/topNav.jsp" />

    <main>
    
    	<c:if test="${not empty errors}">
    		<ul style="color: red; margin-bottom: 16px; padding-left: 1rem;">
    		<c:forEach var="error" items="${errors.allErrors}">
    			<li>${error.defaultMessage}</li>
    		
    		</c:forEach> 
    		</ul>
    	</c:if>
    
      <div class="main-content">
        <h2>강의 개설</h2>
        <form action="/admin/createLecture" method="post" id="form">
          <input type="hidden" name="adminId" value="${adminId}">
          <input type="hidden" name="week" id="week">
          <input type="hidden" name="day" id="dayHidden">

          <label for="instructor">강사 선택</label>
          <select name="instructorId" id="instructor">
            <option value="" disabled selected>강사를 선택하세요</option>
            <c:forEach var="instructor" items="${instructorList}">
              <option value="${instructor.instructorId}">${instructor.name} (${instructor.major})</option>
            </c:forEach>
          </select>

          <label>요일 선택</label>
          <div>
            <label class="day"><input type="checkbox" name="dayTemp" value="MON">월</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="TUE">화</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="WED">수</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="THU">목</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="FRI">금</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="SAT">토</label>
            <label class="day"><input type="checkbox" name="dayTemp" value="SUN">일</label>
          </div>

          <label for="time">시간대 선택</label>
          <select name="time" id="time">
            <option value="" disabled selected>시간대를 선택하세요</option>
            <option value="MORNING">오전반</option>
            <option value="AFTERNOON">오후반</option>
            <option value="EVENING">야간반</option>
          </select>

          <label for="title">과목 선택</label>
          <select name="title" id="title" required>
            <option value="" disabled selected>과목을 선택하세요</option>
          </select>

          <label for="description">과목 설명</label>
          <textarea name="description" id="description"></textarea>

          <label for="startdate">시작 날짜</label>
          <input type="date" name="startedAt" id="startdate" required>

          <label for="enddate">종료 날짜</label>
          <input type="date" name="endedAt" id="enddate" required>

          <div class="button-group">
            <button type="button" onclick="history.back()">뒤로가기</button>
            <button type="button" id="createlecture">강의 개설</button>
          </div>
        </form>
      </div>
    </main>

    <jsp:include page="../nav/footer.jsp" />
  </div>
</body>
</html>
