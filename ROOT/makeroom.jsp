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
		<form action="updateMakeRoom.jsp" method="get">
			<label>방 이름: </label><input name="roomname" type="text" />
			<br>
			<input type="submit" value="적용" />
		</form>
	</body>
</html>

