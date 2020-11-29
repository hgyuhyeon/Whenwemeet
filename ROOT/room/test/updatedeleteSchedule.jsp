<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="Schedule.ScheduleManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="refresh"
		content="0; url=http://118.67.132.180:8080/room/test">
		<title>confirming...</title>
	</head>
	<body>
		<%
		ScheduleManager smanager = new ScheduleManager();
		String id = "testtable";
		String day = request.getParameter("day");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		smanager.updatedeleteSchedule(id, day, start, end);
		%>
	</body>
</html>
