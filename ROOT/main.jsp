<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	<!--뷰포트--> 
	<meta name ="viewport" content = "width = device-width", initial-scale="1"> 
	<!-- 스타일시트--> 
	<link rel="stylesheet" href="css/bootstrap.css"> 
	<title>When we meet!</title>
	<style type="text/css">
		.container{
			text-align: center;
			width:500px;
			height:500px;
			position:absolute;
			left:50%;
			top:50%;
			margin-left:-250px;
			margin-top:-250px;
		}
		.btn.btn-default.toCalender{
			width: 8em;
			heigth: 10em;
		}
	</style>
</head>
<body>
<center>
<h2><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet!</span></h2>
</center>
<HR>
	<%
		//로그인한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
<!-- 버튼 -->
	<%
		//로그인안된경우
		if (userID == null) {
	%>
		<div class="btn-group" role="group" aria-label="...">
		<button type="button" class="btn btn-default" onclick = "location.href = 'login.jsp' ">로그인</button>
 		<button type="button" class="btn btn-default" onclick = "location.href = 'join.jsp' ">회원가입</button>
		</div>		
	<%
		} else {
	%>
		<div class="btn-group" role="group" aria-label="...">
 		<button type="button" class="btn btn-default" onclick = "location.href = 'logoutAction.jsp' ">로그아웃</button>
 		<button type="button" class="btn btn-default" onclick = "location.href = 'delId.jsp' ">회원 탈퇴</button>	 
		</div>
		<div class="container">
			<p style="font-size:70px; margin-bottom: 0em">어서오세요!</p>
			<p style="color:gray; font-size:20px;">캘린더를 확인하러 가볼까요?</p>
			<button type="button" class="btn btn-default toCalender" onclick = "location.href = 'calender.jsp' ">캘린더로</button>
		</div>
	<%
	}
	%>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	</nav>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>
</body>
</html>

