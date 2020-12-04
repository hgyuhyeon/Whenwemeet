<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="room.ScheduleManager" %>
<%@ page import="room.Schedule" %>

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
    //필터 1: 불러올 데이터의 날짜 범위 지정( sql: 해당 날짜의 데이터만 가져오도록 함 )
    //시작 년.월.일
    String psyear = request.getParameter("year");
		String psmonth = request.getParameter("month");
   	String psday = request.getParameter("day");
    //종료 년.월.일
    String psyear = request.getParameter("year");
		String psmonth = request.getParameter("month");
   	String psday = request.getParameter("day");
    
    //필터 2: Do not Disturb -> 선호하는 시간으로 수정, 해당 시간대 데이터만 가져오면 연산시간이 줄어들음
    /* filter.jsp 에서는 더 건들 것 없이 타이틀만 수정하면 돼 */
    String tstart = request.getParameter("start");
    String tend = request.getParameter("end");
    
    //필터 3: 최소 시간( sql: endTime-startTime 했을 때 만족하지 못하면 List<Schedule>에 insert 못하게 필터링)
    
    //데이터셋 가져오기( 해당 필터를 모두 만족하는 범위 내 데이터만 가져오도록 sql 쓰는 함수 생성 예정 )
    ScheduleManager smanager = new ScheduleManager();
		List<Schedule> sdules = new ArrayList<Schedule>();
		String url = (String)session.getAttribute("roomID");
		String[] res = url.split("/");
		String roomID = res[2];
		sdules = smanager.getEntireSchedule(roomID); //이부분 함수 추후 수정할거임
		if(sdules.size()!=0)
			for(int i=0;i<sdules.size();i++) {
				Schedule sdule = new Schedule();
				sdule = sdules.get(i);
				String year = sdule.getYear();
				String month = sdule.getMonth();
				String day = sdule.getDay();
				String starttime = sdule.getStartTime();
				String endtime = sdule.getEndTime(); 
      } // 이 과정을 반복하면서 모든 일정들 다 불러오면 이걸 그대로 출력하기만 하면 돼
		%>
    </body>
</html>
    
