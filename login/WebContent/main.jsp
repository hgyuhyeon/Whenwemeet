<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="room.RoomManager" %>
<%@ page import="room.Room" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR&display=swap" rel="stylesheet">
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
	<center>
	<h1><span style="font-size:2.5em;color:pink;font-family: Georgia;">When we meet!</span></h1>
	</center>
	<HR>
	<div class="col-lg-2"> </div> 
	<div class="col-lg-8"> </div> 
	<div class="col-lg-2">
	<% 
		//로그인한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null; //로그인한 유저 정보
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		//로그인안된경우
		if (userID != null) {
	%>
	<!--로그인/아웃 버튼--> 
		<div class="btn-group" role="group" aria-label="...">
 		<button type="button" class="btn btn-default" onclick = "location.href = 'logoutAction.jsp' ">로그아웃</button>
 		<button type="button" class="btn btn-default" onclick = "location.href = 'delId.jsp' ">회원 탈퇴</button>	
		</div>
	<%
	} 
	%>
	</div>
</head>

<body>

<div class="col-lg-2"></div> 
	<div class="col-lg-8"> 
	<%
		//로그인안된경우
		if (userID == null) {
	%>
	<!--처음의 main페이지--> 
	<center>
	<br><br><br><br><br><br>
		<p style="font-size:4.0em;color:black;font-family: 'Gothic A1', sans-serif;  font-weight:bold;"> 환영합니다!</p>
		<p style="font-size:2.0em;color:gray;font-family: 'Gothic A1', sans-serif;"> 처음이시면 회원가입을, 아이디가 있다면 로그인을 눌러주세요.</p>
		<br>
		<div class="btn-group" role="group" aria-label="...">
		<button type="button" class="btn btn-default" onclick = "location.href = 'login.jsp' ">로그인</button>
	 	<button type="button" class="btn btn-default" onclick = "location.href = 'join.jsp' ">회원가입</button>
		</div>	
	</center>
	<%
		} else {//로그인 중인 경우
	%>
<!-- 이곳에 roomlist에서 모든 방 로드 -->
		<% //사용자가 만든 모든 방 목록 불러오기
		RoomManager rmanager = new RoomManager();
		List<Room> rooms = new ArrayList<Room>();
		rooms = rmanager.getRoomList(userID);
		if(rooms.size()!=0) { //사용자가 생성한 방이 있으면
		%>
		<!-- 방목록 테이블 -->
		<br>
		<p class = "text-left" style="font-size:2.6em;color:black;font-family: 'Do Hyeon', sans-serif; "> 방 목록
		</p>
		<table class = "table">
		<thead>
			<tr>
			<th class = "text-center" style="width:60%; font-size:1.4em; "> 방이름</th>
			<th class = "text-center" style="width:20%; font-size: 1.4em;"> 접속 </th>
			<th class = "text-center" style="width:20%; font-size: 1.4em;"> 삭제 </th>
			</tr>
		</thead>
		<tbody>
		
			<%
			for(int i=0;i<rooms.size();i++) {
				Room room = new Room();
				room = rooms.get(i);
				String roomID = room.getRoomID();
				//Stirng roomURL = "118.67.132.180:8080/room/"+roomID; //방의 절대주소는 이런식으로 되어있음! a=href 쓸때 이런식으로 링크 표시
				String roomName = room.getRoomName();
			%>
		<tr>
		 <td class = "text-center" style="font-size: large; font-family: 'Do Hyeon', sans-serif; font-size:1.3em;"><%=roomName%></td>
		 <td class = "text-center" >		
		 	<div class="btn-group" role="group" aria-label="...">
 			<button type="button" class="btn btn-default" onclick = "location.href = 'wwmeet.tk/room/<%=roomID%>' ">접속</button>	
			</div>
		</td>
		 <td class = "text-center" >	
		 	<div class="btn-group" role="group" aria-label="...">
 			<button type="button" class="btn btn-default" onclick = "location.href = 'updateDeleteRoom.jsp' ">삭제</button>	
			</div>
		</td>
		</tr>
		<%
			}
		%>
		</tbody>
		</table>
		<!-- 방생성 버튼 -->
		<div class="btn-group" role="group" aria-label="...">	
		<button type="button" class="btn btn-default" onclick = "location.href = 'makeroom.jsp' ">방 생성</button>
		</div>
		<%
		} else {
		%>
				<br><br>			
				<center>
                        	<p style="font-size:50px; margin-bottom: 0em">방이 없습니다!!</p>
                        	<p style="color:gray; font-size:20px;">첫번째 방을 생성해 주세요</p>
                        	<br>
                        	<button type="button" class="btn btn-default" onclick = "location.href = 'makeroom.jsp' ">방 만들기</button>	
				</center>
	<%
			}
	}
	%>
	</div> 
	<div class="col-lg-2">
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>

</html>
