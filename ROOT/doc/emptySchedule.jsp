<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="room.ScheduleManager" %>
<%@ page import="room.Schedule" %>
<%@ page import="room.EmptyScheduleList" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>Weekly Schedule</title>
	</head>
  	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<body>
    <%
    ScheduleManager smanager = new ScheduleManager(); //일정 관리 클래스

    //필터 1: 불러올 데이터의 날짜 범위 지정
    if(request.getParameter("syear") == null || request.getParameter("smonth") == null || request.getParameter("sday") == null || request.getParameter("eyear") == null || request.getParameter("emonth") == null || request.getParameter("eday") == null) {
        PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('날짜 범위는 필수로 지정해야 합니다.')");
	script.println("history.back()");
	script.println("</script>");
    }
    //시작 년.월.일
    String[] dstartend = new String[2]; //0은 시작년월일, 1은 종료년월일
    dstartend[0] = request.getParameter("syear");
    String smtemp = request.getParameter("smonth"); //월 얻어오고
    dstartend[0] += smanager.convertPm(smtemp); //파라미터 값 두자릿수로 변환해서 합침
    String sdtemp = request.getParameter("sday");
    dstartend[0] += smanager.convertPm(sdtemp);
    //종료 년.월.일
    dstartend[1] = request.getParameter("eyear");
    String emtemp = request.getParameter("emonth");
    dstartend[1] += smanager.convertPm(emtemp);
    String edtemp = request.getParameter("eday");
    dstartend[1] += smanager.convertPm(edtemp);
    
    //필터 2: 최소 시간
    String ltime = request.getParameter("time");
    
    //데이터셋 가져오기
		List<EmptyScheduleList> sdules = new ArrayList<EmptyScheduleList>(); //현재 스케줄을 리턴받을 리스트
		String url = (String)session.getAttribute("roomID");
		String[] res = url.split("/");
		String roomID = res[2];
		sdules = smanager.getEmptySchedule(roomID, dstartend, ltime); 
		if(sdules.size()!=0) {
		%>빈 시간 목록 <br><%
			for(int i=0;i<sdules.size();i++) {
				//빈 시간 출력 부분
				//start
				%><%=sdules.get(i).getStartYear()%>년<%
                                %><%=sdules.get(i).getStartMonth()%>월<%
				%><%=sdules.get(i).getStartDay()%>일<%
                                %><%=sdules.get(i).getStartTime()%>시 부터<%
				//end
                                %><%=sdules.get(i).getEndYear()%>년<%
                                %><%=sdules.get(i).getEndMonth()%>월<%
                                %><%=sdules.get(i).getEndDay()%>일<%
				%><%=sdules.get(i).getEndTime()%>시 까지<br><%
      			}
		}
		%>
    </body>
</html>
    
