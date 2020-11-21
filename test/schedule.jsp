<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

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
	class Table{
		String name; //Tablename - meeting name
		int[][] isFill = new int[24][7];
		/* isFill for value
		*  value = 1: 일정이 있어서 fill 
		*  value = 2: 필터로 인한 fill */
		}
	%>
	<body>
		<%
		Table tb = new Table();
		%>
		<h1>   *주간 일정*</h1>
		<hr/>
		<h2>&nbsp;&nbsp;&nbsp; 월 화 수 목 금 토 일</h2>
		<% for (int i=0;i<24;i++){ %>
		<h2>
			<% if(i<=9)
				out.print(" "+i+"시");
			else
				out.print(i+"시");
			for(int j=0;j<7;j++){
				if(tb.isFill[i][j] == 1)
					out.print("■ ");
				else
					out.print("□ ");
			} %>
		</h2>
			<%
		}
		%>
		<button type="button" onclick="location.href = '#'">일정 추가</button>
	</body>
</html>

