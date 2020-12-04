<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>방 삭제(test용, 실제 코드에는 다르게 쓰임)</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body><!-- 실제로는 방 ID를 세션으로 불러와서 삭제 버튼 누르면 폼 없이 바로 삭제되도록 함-->
		<form action="updateDelRoom.jsp" method="get">
			<label>방 ID: </label><input name="roomid" type="text" />
			<br>
			<input type="submit" value="적용" />
		</form>
	</body>
</html>


