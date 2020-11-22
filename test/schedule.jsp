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
		<h2>&nbsp;&nbsp;&nbsp; 월 화 수 목 금 토 일</h2>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost/testdb";
		Connection conn = DriverManager.getConnection(url, root, wwm1023*);
		state = conn.CreateStatement();
		
		String sql = "SELECT * INTO testtable WHERE name = 'testname'";
		Resultset rs = state.executeQuery(sql);
		
		//각 일정별로 미리 칸 채워서 출력
		Table tb = new Table();
		int daynum = 0;

		while(rs.next()){
			String weekday = rs.getString("weekday");
			int starttime = rs.getString("starttime");
			int endtime = rs.getString("endtime");
			switch(day) {
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
			for(int i=starttime;i<endtime;i++)
				tb.isFIll[i][daynum] = 1;
		}
		
		for (int i=0;i<24;i++) { %>
		<h2>
			<% out.print(i+"시");
			for(int j=0;j<7;j++) {
				if(query == null)
					out.print("□ ");
				else {
					if(tb.isFill[i][j] == 1)
						out.print("■ ");
					else
						out.print("□ ");
				}
			} %>
		</h2>
			<%
		}
		rs.close();
		state.close();
		conn.close();
		%>
		<button type="button" onclick="location.href = 'addSchedule.jsp'">일정 추가</button>
	</body>
</html>
