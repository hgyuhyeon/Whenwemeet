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
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <!-- 화면비율 -->
      <title>Weekly Schedule</title>
      
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
      <!-- open font Noto Sans -->
      <link rel="preconnect" href="https://fonts.gstatic.com">
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">      
      
      <style type="text/css">
         body{
            text-align: center;
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: 300;
         }
         p.margin{  /* p단락의 간격을 조정하기 위함 */
            margin-top:5px;
            margin-bottom:5px;
         } 
        .btn-primary {
		color: rgb(255, 119, 142);
  	        background-color: white;
		border-color: rgb(255, 119, 142);
	}
	.btn-primary:hover{
		color: white;
		background-color: rgb(255, 119, 142);
		border-color: white;
	}
	.btn-primary:focus {
		box-shadow: 0px 0px 30px pink;
		background-color: rgb(255, 119, 142);
		border-color: pink;
	} 

      </style>
      
   </head>
     <%
   request.setCharacterEncoding("UTF-8");
   %>
   <body style="background-color: rgb(255, 244, 247);">
   <nav class="navbar navbar-expand-lg bg-light navbar-light">
         <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="#">When we meet</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="http://wwmeet.tk">메인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">게시판</a>
            </li>
          </ul>
      </nav>      
    <%
    ScheduleManager smanager = new ScheduleManager(); //일정 관리 클래스
    //필터 1: 불러올 데이터의 날짜 범위 지정
    if(request.getParameter("syear") == "" || request.getParameter("smonth") == "" || request.getParameter("sday") == "" || request.getParameter("eyear") == "" || request.getParameter("emonth") == "" || request.getParameter("eday") == "") {
        PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('날짜 범위는 필수로 지정해야 합니다.')");
   script.println("history.back()");
   script.println("</script>");
    } else {
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
    if(ltime == "")
    	ltime = "0";
    //데이터셋 가져오기
      List<EmptyScheduleList> sdules = new ArrayList<EmptyScheduleList>(); //현재 스케줄을 리턴받을 리스트
      String url = (String)session.getAttribute("roomID");
      String[] res = url.split("/");
      String roomID = res[2];
      sdules = smanager.getEmptySchedule(roomID, dstartend, ltime); 
                %><h1 class="display-4">빈 시간 목록 </h1><br><%
      if(sdules.size()!=0) {
         for(int i=0;i<sdules.size();i++) {
            //빈 시간 출력 부분
            //start
            %><P p class="margin"><%=sdules.get(i).getStartYear()%>년 <%
                                %><%=sdules.get(i).getStartMonth()%>월 <%
            %><%=sdules.get(i).getStartDay()%>일 <%
                                %><%=sdules.get(i).getStartTime()%>시부터 ~ <%
            //end
                                %><%=sdules.get(i).getEndYear()%>년 <%
                                %><%=sdules.get(i).getEndMonth()%>월 <%
                                %><%=sdules.get(i).getEndDay()%>일 <%
            %><%=sdules.get(i).getEndTime()%>시까지</P><%
               }
	       %><br><br><button type="button" class="btn btn-primary" onclick = "location.href = 'index.jsp' ">처음으로</button><%
      } else {
         %>빈 시간이 없습니다!<%
      }
      }
      %>
    </body>
</html>
