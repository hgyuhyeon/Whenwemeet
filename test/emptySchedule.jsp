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
	 	}
		rs.close();
		state.close();
		conn.close();
		%>
		<!-- 빈 시간 조회하기  -->
		<h1> *빈 시간 조회*</h1>
		<hr/>
		<button type="button" onclick="location.href = 'filter.jsp'">필터</button>
    		<%
    		//for weeks print & variable initialize
    		String [] weeks = {"월", "화", "수", "목", "금", "토", "일"};
    
    		//1
		String st, en; //temp
		st = request.getParameter("start")==""?"0":request.getParameter("start");
		en = request.getParameter("end")==""?"0":request.getParameter("end");
		Integer dstart = Integer.parseInt(st);
    		Integer dend = Integer.parseInt(en);
    		if(dstart!=null&&dend!=null){ 
    			if(dstart>dend){
            			for(int i=dstart; i<24;i++)
            				for(int j=0;j<7;j++)
						tb.isFill[i][j] = 2;
            			for(int i = 0;i<dend;i++)
             				for(int j=0;j<7;j++)
       						tb.isFill[i][j] = 2;
        		} else {
            			for(int i=dstart; i<dend; i++)
             				for(int j=0;j<7;j++)
   						tb.isFill[i][j] = 2;
       			}
    		}
    
		//2
		String tm = request.getParameter("time")==""?"0":request.getParameter("time"); //temp
    		Integer time = Integer.parseInt(tm);
    		if(time == null)
    			time = 0;
    		%>				
		<hr/>
		<p>이용 가능한 시간</p>
		<%
		//output
		int start = -1;
		for (int i=0;i<7;i++) //요일별로
			for(int j=0;j<24;j++) {//시간 체크
				if(tb.isFill[j][i] !=0){
					start = -1; //reset starting point
					continue; //빈 시간이 아니라 걸러진 시간이면 패스
				}
				if(start == -1)
					start = j; //set starting point
				int k = j+1;
				if(k == 24)
					k = 0; //날짜 변경 시 시간 변경
				if(tb.isFill[k][i] != 0)
					if(j-start < time){
						start = -1;
						continue; //최소 시간을 만족하지 못하면 패스
					} else {
					%><p><%
						if(start>k){ //익일로 넘어간 시간이면
							out.print(weeks[i-1]+"요일 "+start+"시~ "+weeks[i]+"요일 "+k+"시");
							%><br><%
						}
						else {
							out.print(weeks[i]+"요일 "+start+"시~ "+weeks[i]+"요일 "+k+"시"); //해당 시간도 사용하므로 1시간 높여(k = j+1) 출력
							%><br><%
						}
					%></p><%
					}
			}
		%>
		<button type="button" onclick="location.href='schedule.jsp'">처음으로</button>
	</body>
</html>
