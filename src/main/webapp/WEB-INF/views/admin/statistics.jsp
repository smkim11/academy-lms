<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
</head>
<body>
<div>
	<jsp:include page ="../nav/sideNav.jsp"></jsp:include>
</div>
<main>
	<h1>통계</h1>
	<div>
		<canvas id="chart1" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart2" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart3" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart4" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart5" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart6" style="width:100%;max-width:400px"></canvas>
	</div>
	<div>
		<canvas id="chart7" style="width:100%;max-width:400px"></canvas>
	</div>
</main>
<script>
//chart1 (bar chart)
$.ajax({
	url: '/statistics/CountStudentByInstructorTotal',
	type: 'post',
	success : function(data){
		console.log(data);
		
		const xValues = []; // 강사
		const yValues = []; // 누적 수강인원 수
		const barColors = ["red", "green","blue","orange"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.cnt);
		});
		
		new Chart("chart1", {
		  type: "bar",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{
		        ticks: {
		          beginAtZero: true
		        }
		      }]
		    },
		
		    title: {
		      display: true,
		      text: "강사별 누적 수강인원 수"
		    }
		  }
		});
	}
});

//chart2 (bar chart)
$.ajax({
	url: '/statistics/CountStudentByInstructorCurrent',
	type: 'post',
	success : function(data){
		console.log(data);
		
		const xValues = []; // 강사
		const yValues = []; // 현재 수강인원 수
		const barColors = ["red", "green","blue","orange"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.cnt);
		});
		
		new Chart("chart2", {
		  type: "bar",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{
		        ticks: {
		          beginAtZero: true
		        }
		      }]
		    },
		
		    title: {
		      display: true,
		      text: "강사별 현재 수강인원 수"
		    }
		  }
		});
	}
});

//chart3 (pie chart)
$.ajax({
	url:'/statistics/LectureDo',
	type:'post',
	success: function(data){
		console.log(data);
		
		const xValues = []; // 강사
		const yValues = []; // 강의 수
		const barColors = [
		  "#00aba9",
		  "#b91d47"
		];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.cnt);
		});
		
		new Chart("chart3", {
		  type: "pie",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    title: {
		      display: true,
		      text: "강사별 진행중, 예정 총 강의 수"
		    }
		  }
		});
	}

});

//chart4 (bar chart)
$.ajax({
	url: '/statistics/SurveyAvg',
	type: 'post',
	success : function(data){
		console.log(data);
		
		const xValues = []; // 강사
		const yValues = []; // 별점 평균
		const barColors = ["red", "green","blue","orange"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.rating);
		});
		
		new Chart("chart4", {
		  type: "bar",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{
		        ticks: {
		          beginAtZero: true
		        }
		      }]
		    },
		
		    title: {
		      display: true,
		      text: "강사별 별점 평균"
		    }
		  }
		});
	}
});

//chart5 (line chart)
$.ajax({
	url:'/statistics/CountStudentByYear',
	type:'post',
	success: function(data){
		// chart4 line chart 출력
		console.log(data);
		const xValues = []; // 년도
		const yValues = []; // 누적 학생 수
		
		$(data).each(function(i,e){
			xValues.push(e.year);
			yValues.push(e.cnt);
		});
		new Chart("chart5", {
		  type: "line",
		  data: {
		    labels: xValues,
		    datasets: [{
		      fill: false,
		      lineTension: 0,
		      backgroundColor: "rgba(0,0,255,1.0)",
		      borderColor: "rgba(0,0,255,0.1)",
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{ticks: {min: 0, max:50}}],
		    },
		    title: {
		      display: true,
		      text: "연도별 누적 학생 수"
		    }
		  }
		});
	}
});

//chart6 (doughnut chart)
$.ajax({
	url:'/statistics/StudentAgeDistribution',
	type:'post',
	success: function(data){
		console.log(data);
		
		const xValues = []; // 나이
		const yValues = []; // 수강생 분포
		const barColors = [
		  "#00aba9",
		  "#b91d47"
		];
		
		$(data).each(function(i,e){
			xValues.push(e.age);
			yValues.push(e.cnt);
		});
		
		new Chart("chart6", {
		  type: "doughnut",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    title: {
		      display: true,
		      text: "수강생들 나이 분포"
		    }
		  }
		});
	}

});

//chart7 (line chart)
$.ajax({
	url:'/statistics/CountByLectureThePastYear',
	type:'post',
	success: function(data){

		console.log(data);
		const xValues = []; // 강의명
		const yValues = []; // 학생 수
		
		$(data).each(function(i,e){
			xValues.push(e.title);
			yValues.push(e.cnt);
		});
		new Chart("chart7", {
		  type: "line",
		  data: {
		    labels: xValues,
		    datasets: [{
		      fill: false,
		      lineTension: 0,
		      backgroundColor: "rgba(0,0,255,1.0)",
		      borderColor: "rgba(0,0,255,0.1)",
		      data: yValues
		    }]
		  },
		  options: {
		    legend: {display: false},
		    scales: {
		      yAxes: [{ticks: {min: 0, max:15}}],
		    },
		    title: {
		      display: true,
		      text: "최근 1년간 강의별 인원 수"
		    }
		  }
		});
	}
});
</script>
</body>
</html>