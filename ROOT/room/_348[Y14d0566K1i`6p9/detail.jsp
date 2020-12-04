<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="room.ScheduleManager" %>
<!-- jinseo:open source bootstrap 사용 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 화면비율 -->
		<title>Weekly Schedule</title>
		
		<!-- jinseo start -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		<!-- open font Noto Sans -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">		
		
		<style type="text/css"> 
		/* css */
			body{ /* 전체 폰트 적용 */
				font-family: 'Noto Sans KR', sans-serif;
				font-weight: 300;
			}
			h1{  /* h1스타일 적용 */
				font-weight: 300;
				text-align: center;
			}
			div.top{
				text-align:center;
				background-color:rgb(255, 255, 255);
			}
			p{
				font-size: 19px;
				font-weight:300;
				text-align: center;
			}
			p.margin{  /* p단락의 간격을 조정하기 위함 */
				margin-top:5px;
				margin-bottom:5px;
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
				width:40em;
				margin:auto;
				padding:70px 0;
			}
		</style>
		<!-- jinseo end -->
		
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body style="background-color: rgb(255, 244, 247);"> <!-- 배경색 -->
		<!-- 상단 내비게이션 바 -->
		<nav class="navbar navbar-expand-lg bg-light navbar-light">
		    <ul class="navbar-nav">
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
		
		<!-- 홈페이지 설명 부분 -->
		<div class="top">
			<h2><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet! </span></h2>
			<p style="color:gray; font-size:15px;">다함께 일정을 추가하고, 삭제해보고, 그리고 빈 시간을 조회해 보세요!</p>
			<hr/>
		</div>
		<h1 class="display-4">상세 일정</h1><br /> 
		<p style="color: gray;">입력된 일정 정보</p>  <!-- jinseo:회색으로 -->
		<%
		int [] tb = new int[24]; //table 대신 사용
		ScheduleManager smanager = new ScheduleManager();
                String url = (String)session.getAttribute("roomID");
                String[] res = url.split("/");
                String roomID = res[2];
		String syear = request.getParameter("year");
		String smonth = request.getParameter("month");
		String sday = request.getParameter("day");
		ResultSet rs = smanager.getSchedule(roomID, syear, smonth, sday);
		
		//각 일정별로 미리 칸 채워서 출력
		while(rs.next()){
	                int starttime = Integer.parseInt(rs.getString("startTime"));
			int endtime = Integer.parseInt(rs.getString("endTime"));
			for (int i = starttime; i < endtime; i++){
				tb[i] = 1;
	 		} /* db채우기 */
	 	%>
	 		<p class="margin"><font size="4"><%=starttime %>시부터 <%=endtime %>시까지</font></p>
	    <%
	      }
	      rs.close();
	    %>
		
	    <!-- calender.jsp의 버튼으로부터 전송된 연,월,일 값 전달받은 부분-->
		<div class="container">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col" style="width: 50%; font-weight: 300">시간/일</th>
						<th scope="col">일</th>
						<!-- 그냥 일 말고 3일, 15일 처럼 특정 날짜 일수 나타내고 싶은데 위와 같은 이유로 제대로 구현 못했어 수정부탁!! -->
					</tr>
				<thead>
				<tbody>
					<% for (int i=0;i<24;i++) { %>
					<tr style="width: 20em;">
						<th scope="row"><%=i%>시</th>
						<%if(tb[i]==1){%>
							<td style="background-color: rgb(255, 119, 142)"> </td>
							<!-- jinseo:그런데 사실특정 월, 일의 특정 시간에 일정이 있으면 찐분홍색으로 칠할려고 했는데 이부분 역시 위와 같은 이유로...ㅎㅎ 수정부탁해!! -->
						<%} else{ %>
							<td></td>
						<%} %>
					</tr>
					<%}%>
				</tbody>
			</table>
				<center>
					<button type="button" class="btn btn-primary" onclick="location.href = 'addSchedule.jsp'">일정 추가</button>
					<button type="button" class="btn btn-primary" onclick="location.href = 'deleteSchedule.jsp'">일정 삭제</button>
					<button type="button" class="btn btn-primary" onclick="location.href = 'filter.jsp'">빈 시간 조회</button>
				</center>
		</div>
				
		<!-- jinseo:애니메이션 부분. 파일 참조 -->
		<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	</body>
</html>

