<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="room.RoomManager" %>
<%@ page import="room.Room" %>
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
		String userID = null; //로그인한 유저 정보
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
			<button type="button" class="btn btn-default" onclick = "location.href = 'makeroom.jsp' ">방 생성</button>

		</div>
		<!-- 이곳에 roomlist에서 모든 방 로드 -->
		<% //사용자가 만든 모든 방 목록 불러오기
		RoomManager rmanager = new RoomManager();
		List<Room> rooms = new ArrayList<Room>();
		rooms = rmanager.getRoomList(userID);
		if(rooms.size()!=0) //사용자가 생성한 방이 있으면
			for(int i=0;i<rooms.size();i++) {
				Room room = new Room();
				room = rooms.get(i);
				String roomID = room.getRoomID();
				//Stirng roomURL = "118.67.132.180:8080/room/"+roomID; //방의 절대주소는 이런식으로 되어있음! a=href 쓸때 이런식으로 링크 표시
				String roomName = room.getRoomName();
				%>
			<br><%=roomName%>: <%=roomID%>
			<!-- 이곳에 방 이름, 링크 출력, 방 접속버튼과 방 삭제 버튼도 출력할 수 있다면 방마다 출력하기
	   방 접속은 action = room/roomURL , 방 삭제는 action = updateDeleteRoom.jsp 로 부탁해 -->
			<%
			}
		%>
	<%
	}
	%>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	</nav>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>
</body>
</html>

