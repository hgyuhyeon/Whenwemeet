<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>




<!-- ���⿡ db �����ϴ� �κ� ������ �� �� ����! -->











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
			/* ��ư �ٹ̱� */
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
			<ul class="navbar-nav">
		      <li class="nav-item">
		        <a class="nav-link" href="#">When we meet</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="schedule.jsp">����</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="#">�Խ���</a>
		      </li>
		    </ul>
		</nav>		
  <%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar��ü cal����
  int currentYear=cal.get(java.util.Calendar.YEAR); //���� ��¥ ���
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //��Ÿ������ �ϴ� ��¥
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //ó�� ȣ������ ��
  year=currentYear;
  month=currentMonth;
  }
  else { //��Ÿ������ �ϴ� ��¥�� ���ڷ� ��ȯ
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1������ 12������ ���� ����.
   if(month>11) { month=0; year=year+1; }
  }
  %>
  <center>
  <table border=0>
   <tr>
    <td align=left width=200> <!-- �� ��-->
    <a href="calendar.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>"><</a>
    <% out.print(year); %>��
    <a href="calendar.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">></a>
    </td>
    <td align=center width=300> <!-- �� -->
    <h2><a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>"><</a>
    <span style="font-size:2em;color:pink;"><% out.print(month+1); %>��</span>
    <a href="calendar.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">></a></h2>
    </td>
    <td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></span></h2></td>
   </tr>
  </table>
  <HR>
  <table border=1 cellspacing=0 bordercolor= "#FFF4F7"> <!-- �޷� �κ� -->
   <tr height=70>
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=1 -->
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=2 -->
    <td width=150><span style="font-size:1.5em;color:gray;">ȭ</span></td> <!-- ȭ=3 -->
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=4 -->
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=5 -->
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=6 -->
    <td width=150><span style="font-size:1.5em;color:gray;">��</span></td> <!-- ��=7 -->
   </tr>
   <tr height=100>
   <%
   cal.set(year, month, 1); //���� ��¥�� ���� ���� 1�Ϸ� ����
   int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //���糯¥(1��)�� ����
   int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //�� ���� ������ ��
   int br=0; //7�ϸ��� �� �ٲٱ�
   
   for(int i=0; i<(startDay-1); i++) { //��ĭ���
    out.println("<td>&nbsp;</td>");
    br++;
    
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //��¥���
    
	
   //    ���� �߰� �κ�
//   ������ ������ �׳� ��¥�� ����ϰ� ������ ������ ��ư ����ؼ� ������ ���� �� �������� �� �� �ְ� �Ϸ���!

//   ���� ���� �� 
//   out.println("<td>" + i + "</td>");
   
   //���� ���� ��
	out.println("<td>" + i   + "<button role='submit'; class='btn btn-primary'; onclick='location.href = addSchedule.jsp'>"+ "</td>");
 

   


    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=100>");
    }
   }
   while((br++)%7!=0) //���� ���� ��ĭ���
    out.println("<td>&nbsp;</td>");
   %>
   </tr>
  </table>
  <HR>
  <button role="submit" class="btn btn-primary" onclick="location.href = 'addSchedule.jsp'">���� �߰�</button>
  <button role="submit" class="btn btn-primary"  onclick="location.href = 'deleteSchedule.jsp'">���� ����</button>
  <button role="submit" class="btn btn-primary"  onclick="location.href = 'filter.jsp'">�� �ð� ��ȸ</button>	
  </center>
 </body>
</html>