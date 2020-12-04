<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="room.RoomManager" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="room" class="room.Room" scope="page" />
<jsp:setProperty name="room" property="roomID" />
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type"
	    	content="text/html; charset=UTF-8">
	    	<title>conrirming...</title>
	</head>
	<body>
   	 	<%
    		RoomManager rmanager = new RoomManager();
		//String roomID = (String)session.getAttribute("roomID");
		String roomID = request.getParameter("roomid");
		int result = -2;
		if ( roomID != null ) {
			result = rmanager.delRoom(roomID);
		}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		%>
	</body>
</html>


