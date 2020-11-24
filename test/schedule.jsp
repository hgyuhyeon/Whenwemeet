<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>Weekly Schedule</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	class Table{ //조회한 테이블 결과 출력용
		String name; //Tablename - meeting name
		int[][] isFill = new int[24][7];
		/* isFill for value
		*  value = 1: 일정이 있어서 fill 
		*  value = 2: 필터로 인한 fill */
		}
	%>
	<body>
		<h1>   *주간 일정*</h1>
		<hr/>
		<p>입력된 일정 정보</p>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost/testdb";
		Connection conn = DriverManager.getConnection(url, "user", "1234");
		Statement state = conn.createStatement();
		
		String sql = "SELECT * FROM testtable WHERE name = 'testname'";
		ResultSet rs = state.executeQuery(sql);
		
		//각 일정별로 미리 칸 채워서 출력
		Table tb = new Table();
		int daynum = 0;

		while(rs.next()){
			String weekday = rs.getString("weekday");
			int starttime = Integer.parseInt(rs.getString("starttime"));
			int endtime = Integer.parseInt(rs.getString("endtime"));
			switch(weekday) {
			case "월":
				daynum = 0;
				break;
			case "화":
				daynum = 1;
				break;
			case "수":
				daynum = 2;
				break;
			case "목":
				daynum = 3;
				break;
			case "금":
				daynum = 4;
				break;
			case "토":
				daynum = 5;
				break;
			case "일":
				daynum = 6;
				break;
			default:
				break;
			}
			for (int i = starttime; i < endtime; i++){
				tb.isFill[i][daynum] = 1;
	 		}
			out.println(weekday+": "+starttime+"시부터 "+endtime+"시까지");
	 	%><br><%
	 	}
		%><hr/><%
		rs.close();
		state.close();
		conn.close();
		%><p>&nbsp;&nbsp;&nbsp; 월 화 수 목 금 토 일</p><%
	 	for (int i=0;i<24;i++) {
	 		%><p><%
			out.print(i+"시");
			for(int j=0;j<7;j++) {
				if(tb.isFill[i][j] == 1)
					out.print(" ■");
				else
					out.print(" □");
			}
		%></p><%
		}
		%>
		<button type="button" onclick="location.href = 'addSchedule.jsp'">일정 추가</button>
		<button type="button" onclick="location.href = 'deleteSchedule.jsp'">일정 삭제</button>
		<button type="button" onclick="location.href = 'emptySchedule.jsp'">빈 시간 조회</button>	
	</body>
</html>
