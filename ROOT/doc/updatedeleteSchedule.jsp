<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="room.ScheduleManager" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
	    	content="text/html; charset=UTF-8">
	    	<title>conrirming...</title>
	</head>
	<body>
   	 	<%
   	 	ScheduleManager smanager = new ScheduleManager();
		String url = (String)session.getAttribute("roomID");
                String[] res = url.split("/");
		String id = res[2];
		String year = request.getParameter("year");
		String month = request.getParameter("month");
   	 	String day = request.getParameter("day");
   	 	String start = request.getParameter("start");
   	 	String end = request.getParameter("end");
		int result = -2;
		if (id != null && year != null && month != null && day != null && start != null & end != null) {
			out.println(id);
			result = smanager.deleteSchedule(id, year, month, day, start, end);
		} else {
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("alert('빈 항목이  있습니다.')"); 
			script.println("history.back()"); 
			script.println("</script>"); 
		}
		if (result == 1) {
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("location.href = 'index.jsp'"); 
			script.println("</script>"); 
		} else if( result==-1){
			PrintWriter script = response.getWriter(); 
			script.println("<script>"); 
			script.println("alert('DB오류')"); 
			script.println("history.back()"); 
			script.println("</script>"); 
		}
    		%>
	</body>
</html>



