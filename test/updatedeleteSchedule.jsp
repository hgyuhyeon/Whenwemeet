<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
Statement state = conn.createStatement();
%>

<html>
	<head>
		<meta http-equiv="refresh"
		content="0; url=http://118.67.132.180:8080/test/schedule.jsp">
		<title>confirming...</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body>
		<%
		String day = request.getParameter("day");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sql = "DELETE FROM testtable WHERE name='testname' AND weekday='"+day+"' AND starttime='"+start+"' AND endtime='"+end+"';";
		state.executeUpdate(sql);
		state.close();
		conn.close();
		%>
	</body>
</html>
