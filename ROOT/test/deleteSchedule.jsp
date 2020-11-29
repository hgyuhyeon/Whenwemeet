<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD//HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>일정 삭제</title>
	</head>
	<%
  	request.setCharacterEncoding("UTF-8");
  	%>
	<body>
		<p>일정 목록</p>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost/testdb";
		Connection conn = DriverManager.getConnection(url, "user", "1234");
		Statement state = conn.createStatement();
		String sql = "SELECT * FROM testtable WHERE name = 'testname'";
		ResultSet rs = state.executeQuery(sql);
		%>
		<form action="updatedeleteSchedule.jsp" method="get">
			<%
			while(rs.next()){
				String weekday = rs.getString("weekday");
				int starttime = Integer.parseInt(rs.getString("starttime"));
				int endtime = Integer.parseInt(rs.getString("endtime"));
				out.print(weekday+", "+starttime+"시~"+endtime+"시 ");
				%><br><%
				}
			%>
			<hr/>
			<label>요일: </label><input name="day" type="text" />
			<br>
			<label>시간: </label><input name="start" type="text" />시 부터 <input name="end" type=text" />시 까지
			<input type="submit" value="적용">
		</form>
	</body>
</html>
