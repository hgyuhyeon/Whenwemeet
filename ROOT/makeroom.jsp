<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
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
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body style="background-color: rgb(255, 244, 247);">
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


		<h1 class="display-4">방 추가</h1>
		<p p style="color:gray; font-size:15px;">
			원하는 방 이름을 입력하세요
		</p>
		<div class="container">
			<span style="font-size:1.5em;">방 이름</span>
			<br />
			<form action="updateMakeRoom.jsp" method="get">
				<div class="row">
					<div class="col">
						<input name="roomname" type="text" class="form-control"/>
					</div>
				</div>
				<br /><button type="submit" class="btn btn-primary">적용</button>
			</form>
		</div>
	</body>
</html>

