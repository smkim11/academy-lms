<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>AcademyLMS</title>
<style>
body {
  font-family: 'Segoe UI', sans-serif;
  background-color: #f4f6f9;
  margin: 0;
  padding: 0;
}

.dashboard-title {
  font-size: 28px;
  font-weight: 700;
  color: #2c3e50;
  margin: 40px 50px 20px;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(360px, 1fr));
  gap: 24px;
  padding: 0 50px 50px;
}

.stat-card {
  background: #ffffff;
  border-radius: 16px;
  padding: 24px 20px 30px;
  box-shadow: 0 8px 16px rgba(0,0,0,0.06);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.stat-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 20px rgba(0,0,0,0.1);
}

.stat-card h2 {
  font-size: 16px;
  font-weight: 600;
  color: #34495e;
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.stat-card h2::before {
  content: "📈";
  font-size: 18px;
}

canvas {
  width: 100% !important;
  height: 260px !important;
}
 
body.no-sidebar main {
  margin-left: 0;
}
</style>
</head>
<body class="no-sidebar">
<div>
	<jsp:include page ="../nav/topNav.jsp"></jsp:include>
</div>
<main>
  <h1 class="dashboard-title">📊 통계</h1>
  <div class="dashboard-grid">
    <section class="stat-card">
      <h2>강사별 누적 수강생</h2>
      <canvas id="chart1"></canvas>
    </section>
    <section class="stat-card">
      <h2>강사별 현재 수강생</h2>
      <canvas id="chart2"></canvas>
    </section>
    <section class="stat-card">
      <h2>강의 진행상태</h2>
      <canvas id="chart3"></canvas>
    </section>
    <section class="stat-card">
      <h2>강사 평점 평균</h2>
      <canvas id="chart4"></canvas>
    </section>
    <section class="stat-card">
      <h2>연도별 누적 학생 수</h2>
      <canvas id="chart5"></canvas>
    </section>
    <section class="stat-card">
      <h2>나이 분포</h2>
      <canvas id="chart6"></canvas>
    </section>
    <section class="stat-card">
      <h2>최근 1년 강의별 인원</h2>
      <canvas id="chart7"></canvas>
    </section>
  </div>
</main>


<div>
	<jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>
<script>
//chart1 (bar chart)
$.ajax({
	url: '/statistics/CountStudentByInstructorTotal',
	type: 'post',
	success : function(data){
		console.log(data);
		
		const xValues = []; // 강사
		const yValues = []; // 누적 수강인원 수
		const barColors = [];
		const colorPool = ["#2c7be5", "#00d97e","#f6c343","#e63757","#6e00ff","#39afd1","#ff6b6b"];

		$(data).each(function(i, e) {
		  xValues.push(e.name);
		  yValues.push(e.cnt);
		  barColors.push(colorPool[i % colorPool.length]);  // 색 반복
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
	    	          	beginAtZero: true,
	   	         	 	fontSize: 10
	    	        }
	   	      	}],
				xAxes: [{
				  ticks: {
				    fontSize: 10
				  }
				}]
		    },
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
		const barColors = [];
		const colorPool = ["#2c7be5", "#00d97e","#f6c343","#e63757","#6e00ff","#39afd1","#ff6b6b"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.cnt);
			barColors.push(colorPool[i % colorPool.length]);  // 색 반복
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
	    	          	beginAtZero: true,
	   	         	 	fontSize: 10
	    	        }
	   	      	}],
				xAxes: [{
				  ticks: {
				    fontSize: 10
				  }
				}]
		    },
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
		const barColors = [];
		const colorPool = ["#2c7be5", "#00d97e","#f6c343","#e63757","#6e00ff","#39afd1","#ff6b6b"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.cnt);
			barColors.push(colorPool[i % colorPool.length]);  // 색 반복
		});
		
		new Chart("chart3", {
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
		    	          	beginAtZero: true,
		   	         	 	fontSize: 10
		    	        }
					}],
					xAxes: [{
					  ticks: {
					    fontSize: 10
					  }
					}]
			  },
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
		const barColors = [];
		const colorPool = ["#2c7be5", "#00d97e","#f6c343","#e63757","#6e00ff","#39afd1","#ff6b6b"];
		
		$(data).each(function(i,e){
			xValues.push(e.name);
			yValues.push(e.rating);
			barColors.push(colorPool[i % colorPool.length]);  // 색 반복
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
    	          	beginAtZero: true,
   	         	 	fontSize: 10
    	        }
   	      	}],
			xAxes: [{
			  ticks: {
			    fontSize: 10
			  }
			}]
		    },
		  }
		});
	}
});

//chart5 (line chart)
$.ajax({
	url:'/statistics/CountStudentByYear',
	type:'post',
	success: function(data){

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
		    	 yAxes: [{
		    	        ticks: {
	    	        		min: 0, max:500,
		    	          	beginAtZero: true,
	    	         	 	fontSize: 10
		    	        }
		    	      }],
				xAxes: [{
				  ticks: {
				    fontSize: 10
				  }
				}]
		    },
		  }
		});
	}
});

//chart6 (pie chart)
$.ajax({
	url:'/statistics/StudentAgeDistribution',
	type:'post',
	success: function(data){
		console.log(data);
		
		const xValues = []; // 나이
		const yValues = []; // 수강생 분포
		const barColors = [];
		const colorPool = ["#2c7be5", "#00d97e","#f6c343","#e63757","#6e00ff","#39afd1","#ff6b6b"];
		
		$(data).each(function(i,e){
			xValues.push(e.age + "대");
			yValues.push(e.cnt);
			barColors.push(colorPool[i % colorPool.length]);  // 색 반복
		});
		
		new Chart("chart6", {
		  type: "pie",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
			  legend: {
			      display: true,
			      labels: {
			        fontSize: 10 
			      }
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
		      yAxes: [{
					ticks: {
						min: 0, max:15,
						beginAtZero: true,fontSize: 10
					}
		      }],
	          xAxes: [{
	              ticks: {
	                fontSize: 10 
	              }
			}]
		    },
		  }
		});
	}
});
</script>
</body>
</html>