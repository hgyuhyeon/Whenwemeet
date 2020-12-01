<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>User Infomation</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost/wwm";
	Connection conn = DriverManager.getConnection(url, "user", "1234");
	Statement state = conn.createStatement();
	%>
	<body>
	Whenwewillmeet-for user
	<%
        String sql = "SELECT * FROM user WHERE mainuser = 'testuser'";
        ResultSet rs = state.executeQuery(sql);
	%>
	<p>testuser's rooms</p>
	<hr/>
	<%
	while(rs.next()){
		String roomid = rs.getString("roomid");
		String roomname = rs.getString("roomname");
		%><p><%out.println(roomid);%>: <a href="room/roomid"><%out.println(roomname);%></a></p><%
	}
	%>
	
	<%
	rs.close();
	state.close();
	conn.close();
	%>
	</body>
</html>
