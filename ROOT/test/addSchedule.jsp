<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>일정 추가</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body>
		<form action="updateaddSchedule.jsp" method="get">
			<label>요일: </label><input name="day" type="text" />
			<br>
			<label>시간: </label><input name="start" type="text"/> 시 부터 <input name="end" type="text"/>시 까지
			<br>
			<input type="submit" value="적용" />
		</form>
	</body>
</html>
