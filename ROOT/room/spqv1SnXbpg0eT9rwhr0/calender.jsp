<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<style type="text/css">
body{
background-color: #FFF4F7;
}
</style>
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
			/* 버튼 꾸미기 */
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
			.container{
				width:1000px;
				height:1000px;
				margin:auto;
				padding:70px 0;
			}
		</style>		
	</head>
  <title>calendar</title>
 </head>
 <body>
 <nav class="navbar navbar-expand-lg bg-light navbar-light">
			<ul class="navbar-nav" style="text-align: left;">
		      <li class="nav-item">
		        <a class="nav-link" href="#">When we meet</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="http://118.67.132.180:8080/main.jsp">메인</a>
		      </li>
		      <li class="nav-item active">
		        <a class="nav-link" href="#">캘린더</a>
		      </li>
		    </ul>
		</nav>		
  <%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
  %>
  <center>
  <table border=0>
   <tr>
    <td align=left width=200> <!-- 년 도-->
    <a href="calendar.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>"><</a>
    <% out.print(year); %>년
    <a href="calendar.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">></a>
    </td>
    <td align=center width=300> <!-- 월 -->
    <h2><a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>"><</a>
    <span style="font-size:2em;color:pink;"><% out.print(month+1); %>월</span>
    <a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">></a></h2>
    </td>
    <td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></span></h2></td>
   </tr>
  </table>
  <HR>
  <table border=1 cellspacing=0 bordercolor= "#FFF4F7"> <!-- 달력 부분 -->
   <tr height=70>
    <td width=150><span style="font-size:1.5em;color:gray;">일</span></td> <!-- 일=1 -->
    <td width=150><span style="font-size:1.5em;color:gray;">월</span></td> <!-- 월=2 -->
    <td width=150><span style="font-size:1.5em;color:gray;">화</span></td> <!-- 화=3 -->
    <td width=150><span style="font-size:1.5em;color:gray;">수</span></td> <!-- 수=4 -->
    <td width=150><span style="font-size:1.5em;color:gray;">목</span></td> <!-- 목=5 -->
    <td width=150><span style="font-size:1.5em;color:gray;">금</span></td> <!-- 금=6 -->
    <td width=150><span style="font-size:1.5em;color:gray;">토</span></td> <!-- 토=7 -->
   </tr>
   <tr height=100>
   <%
   cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
   int br=0; //7일마다 줄 바꾸기
   
   for(int i=0; i<(startDay-1); i++) { //빈칸출력
    out.println("<td>&nbsp;</td>");
    br++;
    
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
    
	
   //    일정 추가 부분
//   일정이 없으면 그냥 날짜만 출력하고 일정이 있으면 버튼 출력해서 진서가 만든 상세 일정으로 들어갈 수 있게 하려구!
//   일정 없을 때 
//   out.println("<td>" + i + "</td>");
   
   //일정 있을 때
   %>
   <td>
   <%=i%>
   <!-- 이부분은 버튼 누르면 연, 월, 일 정보 보내는 부분이야! -->
   <form action="detail.jsp" method="get">
   		<input type="hidden" name="years" value="<%=year%>">
   		<input type="hidden" name="months" value="<%=month+1%>">
   		<input type="hidden" name="days" value="<%=i%>">
   		<button type="submit" class="btn btn-primary" onclick="location.href='detail.jsp'"></button>
   </form>
   </td>
   <%
    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=100>");
    }
   }
   while((br++)%7!=0) //말일 이후 빈칸출력
    out.println("<td>&nbsp;</td>");
   %>
   </tr>
  </table>
  <HR>
  <button role="submit" class="btn btn-primary" onclick="location.href = 'addSchedule.jsp'">일정 추가</button>
  <button role="submit" class="btn btn-primary"  onclick="location.href = 'deleteSchedule.jsp'">일정 삭제</button>
  <button role="submit" class="btn btn-primary"  onclick="location.href = 'filter.jsp'">빈 시간 조회</button>	
  </center>
 </body>
</html>

