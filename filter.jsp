<%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 화면비율 -->
		<title>Filter</title>
		
		<!-- jinseo start -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		<!-- open font Noto Sans -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">		
		
				<style type="text/css">
		body{
			text-align: center;
			font-family: 'Noto Sans KR', sans-serif;
			font-weight: 300;
		}
		/* 버튼 꾸미기 */
		.btn-primary {  
		    color: rgb(255, 119, 142);
		    background-color: white;
			border-color: rgb(255, 119, 142);
		}
		.btn-primary:hover{
			color: white;
			background-color: rgb(255, 119, 142);
			border-color: white;
		}
		.btn-primary:focus {
			box-shadow: 0px 0px 30px pink;
			background-color: rgb(255, 119, 142);
			border-color: pink;
		}
		.container{
			width:500px;
			height:500px;
			margin:auto;
			padding:70px 0;
		}
		</style>		
		
	</head>
  	<%request.setCharacterEncoding("UTF-8");%>
	<body style="background-color: rgb(255, 244, 247);"> <!-- 배경색 -->
		<nav class="navbar navbar-expand-lg bg-light navbar-light">
			<ul class="navbar-nav" style="text-align: left;">
		      <li class="nav-item">
		        <a class="nav-link" href="#">When we meet</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="main.jsp">메인</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="calender.jsp">캘린더</a>
		      </li>
		    </ul>
		</nav>		
	
		<h1 class="display-4">필터</h1>
		<p p style="color:gray; font-size:15px;">
			필터 기능을 이용하여 꼼꼼하게 일정 관리 해보세요!
		</p>
		<div class="container">
			<span style="font-size:1.5em;">1. Do not disturb</span>
			<br />
			<form action="emptySchedule.jsp" method="get">
				<div class="row">
					<div class="col">
						<input name="year" type="text" class="form-control"/>년
						</div>
						<div class="col">
						<input name="month" type="text" class="form-control"/>월
						</div>
						<div class="col">
						<input name="day" type="text" class="form-control"/>일
						<br />
					</div>
				</div>
				
				<input name="start" type="text" class="form-control" />시부터
				<input name="end" type="text" class="form-control" />시 까지<br>
			<br><br>
			<span style="font-size:1.5em;">2. 필요한 최소 시간</span><br>
			<br />
			<form action="emptySchedule.jsp" method="get">
				최소 <input name="time" type="text" class="form-control"/>시간<br>
	            <br /><button type="submit" class="btn btn-primary">적용</button>
			</form>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
     </body>
</html>