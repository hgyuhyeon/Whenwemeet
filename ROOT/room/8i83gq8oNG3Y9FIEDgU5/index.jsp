<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<jsp:useBean id="room" class="room.Room" scope="page" />
<jsp:setProperty name="room" property="roomID" />
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR"> 
<title>When we will meet?</title> 
</head> 
<body> 
<script> 
      <%
      String roomID = request.getServletPath();
      session.setAttribute("roomID", roomID); 
      %>
      location.href = 'calender.jsp'; 
</script> 
</body> 
</html>

