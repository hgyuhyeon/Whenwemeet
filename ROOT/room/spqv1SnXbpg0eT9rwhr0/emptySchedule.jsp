<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="room.ScheduleManager" %>
<%@ page import="room.Schedule" %>
<%@ page import="room.EmptyScheduleList" %>

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

    //필터 1: 불러올 데이터의 날짜 범위 지정( sql: 해당 날짜의 데이터만 가져오도록 함 )
    //시작 년.월.일
    String[] dstartend; //0은 시작년월일, 1은 종료년월일
    dstartend[0] = request.getParameter("syear");
    String smtemp = request.getParameter("smonth"); //월 얻어오고
    dstartend[0] += smanager.convertPm(smtemp); //파라미터 값 두자릿수로 변환해서 합침
    String sdtemp = request.getParameter("sday");
    dstartend[0] += smanager.convertPm(sdtemp);
    //종료 년.월.일
    dstartend[1] += request.getParameter("eyear");
    String emtemp = request.getParameter("emonth");
    dstartend[1] += smanager.convertPm(emtemp);
    String edtemp = request.getParameter("eday");
    dstartend[1] += smanager.convertPm(edtemp);
    
    //필터 2: Do not Disturb -> 선호하는 시간으로 수정, 해당 시간대 데이터만 가져오면 연산시간이 줄어들음
    /* filter.jsp 에서는 더 건들 것 없이 타이틀만 수정하면 돼 */
    String[] tstartend; //0은 시작시간, 1은 종료시간
    String tstartend[0] = request.getParameter("start");
    String tstartend[1] = request.getParameter("end");
    
    //필터 3: 최소 시간( sql: endTime-startTime 했을 때 만족하지 못하면 List<Schedule>에 insert 못하게 필터링)
    String ltime = request.getParameter("time");
    
    //데이터셋 가져오기( 해당 필터를 모두 만족하는 범위 내 데이터만 가져오도록 sql 쓰는 함수 생성 예정 )
		List<EmptyScheduleList> sdules = new ArrayList<EmptySchedule>List(); //현재 스케줄을 리턴받을 리스트
		String url = (String)session.getAttribute("roomID");
		String[] res = url.split("/");
		String roomID = res[2];
		sdules = smanager.getEmptySchedule(roomID, dstartend, tstartend, ltime); //이부분 함수 추후 수정할거임
		if(sdules.size()!=0) {
			for(int i=0;i<sdules.size();i++) {
				//빈 시간 출력 부분
				EmptyScheduleList sdule = new EmptyScheduleList(); //리턴한 스케줄 값 얻어옴
				sdule.get(i);
				//startyear, endyear
				//startmonth, endmonth
				//startday, endday
				//starttime, endtime
				//총 8개 원소 sdule.getStartYear(); 같은 방식으로 불러오면 String 리턴함.
				//표현식으로 출력하면 끝
      			}
		}
		%>
    </body>
</html>
    
