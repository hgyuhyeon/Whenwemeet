<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 화면비율 -->
		<title>일정 추가</title>
		
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
		
		<h1 class="display-4">일정 추가</h1>
		<p p style="color:gray; font-size:15px;">
			가능한 일정을 추가해 보세요!
		</p>
		<br /><p style="color:gray;">일정 목록</p>
		<%
 		Class.forName("com.mysql.cj.jdbc.Driver");
		String url="jdbc:mysql://localhost/wwm";
		Connection conn = DriverManager.getConnection(url, "user", "1234");
		Statement state = conn.createStatement();
		String sql = "SELECT * FROM SCHEDULE WHERE roomID = 'test2'";
		ResultSet rs = state.executeQuery(sql);
		%>
		<form action="updateaddSchedule.jsp" method="get">
			<%
			while(rs.next()){
				String weekday = "0";//rs.getString("weekday");
				int starttime = 0;//Integer.parseInt(rs.getString("starttime"));
				int endtime = 0;//Integer.parseInt(rs.getString("endtime"));
			%>
				<p class="margin"><%=weekday%>, <%=starttime%>시~<%=endtime%>시 </p>
			<%
				}
			%>
			<hr/>
		<div class="container">
			<form action="updateaddSchedule.jsp" method="get">
				<div class="row">
						<div class="col">
						<input name="year" type="text" class="form-control"/>년
						</div>
						<div class="col">
						<input name="month" type="text" class="form-control"/>월
						</div>
						<div class="col">
						<input name="day" type="text" class="form-control"/>일
					</div>
				</div>
				<br />
				<div class="row">
					<div class="col">
						<input name="start" type="text" class="form-control"/> 시 부터
					</div>
					<div class="col">
						<input name="end" type="text" class="form-control"/>시 까지
					</div>
				</div>
				<br /><button type="submit" class="btn btn-primary">적용</button>
			</form>
		</div>
		
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	</body>
</html>
