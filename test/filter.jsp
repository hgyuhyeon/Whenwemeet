<%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>Filter</title>
	</head>
  	<%
	request.setCharacterEncoding("UTF-8");
        %>
	<body>
                <p>필터</p>
		1. do not disturb(필요없으면 두 값 전부 0)
		<form action="emptySchedule.jsp" method="get">
			<input name="start" type="text" />시부터
			<input name="end" type="text" />시 까지<br>
		<br><br>
		2. 필요한 최소 시간(필요없으면 0)<br>
		<form action="schedule.jsp" method="get">
			최소 <input name="time" type="text"/>시간<br>
                        <input type="submit" value="적용" />
		</form>
        </body>
</html>
