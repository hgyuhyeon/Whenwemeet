<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01
Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
		content="text/html; charset=UTF-8">
		<title>Inquire Schedule</title>
	</head>
	<%
	request.setCharacterEncoding("UTF-8");
	class Table{
		String name;
		int [][] isFill = new int[24][7];
		
	}

	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://localhost/testdb";
	Connection conn = DriverManager.getConnection(url, "user", "1234");
	Statement state = conn.createStatement();

	String sql = "SELECT * FROM testtable WHERE name = 'testname'";
	ResultSet rs = state.executeQuery(sql);

	Table tb = new Table();
	int daynum = 0;

	while(rs.next()){
		String weekday = rs.getString("weekday");
		int starttime = Integer.parseInt(rs.getString("starttime");
		int endtime = Integer.parseInt(rs.getString("endtime");
		switch(weekday){
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
		for (int i = starttime; i < endtime; i++) {
			tb.isFill[i][daynum] = 1;
		}
	}
	%>
	<body>
		<h1> *빈 시간 조회*</h1>
		<hr/>
		<p>필터</p>
		<%
		int dstart, dend; //for 1: do not disturb
		int time = 0; //for 2: mininum spending time
		%>
		1. do not disturb(체크 시 폼 나타나야 함)
		<form>
			<input name="start" type="text" />시부터
			<input name="end" type="text" />시 까지<br>
			<input type="submit" value="적용" />
		</form>
		<!--관건: 적용 버튼 누르면 같은 페이지의 하단에 결과가 나타나야 함 -->
		<br>
		2. 필요한 최소 시간(1번과 동일한 형태로 결과 display)
		<form>
			최소 <input name="time" type="text"/>시간
			<input type="submit" value="적용" />
		</form>
		<%
		//for weeks print
		String [] weeks = {"월", "화", "수", "목", "금", "토", "일"};
		
		//1
		dstart = Integer.parseInt(request.getParameter("start"));
		dend = Integer.parseInt(request.getParameter("end");
                if(dtart!=null&&dend!=null){
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
		time = Integer.parseInt(request.getParameter("time");
                if(time == null)
                        time = 0;
		
		//output
		int start = -1;
		for (int i=0;i<24;i++) //시간 체크
			for(int j=0;j<7;j++) //요일별로
				if(tb.isFill[i][j] !=0){
					start = -1; //reset starting point
					continue; //빈 시간이 아니라 걸러진 시간이면 패스
				}
				if(start == -1)
					start = j; //set starting point
				int k = j+1;
				if(k ==24)
					k = 0; //날짜 변겨 시 시간 변경
				if(tb.isFill[k][i] != 0)
					if(j-start < time){
						start = -1;
						continue; //최소 시간을 만족하지 못하면 패스
					} else {
						if(start>k) //익일로 넘어간 시간이면
							out.println(weeks[i-1]+"요일 "+start+"시~ "+weeks[i]+"요일 "+k+"시");
						else
							out.println(weeks[i]+"요일 "+start+"시~ "+weeks[i]+"요일 "+k+"시"); //해당 시간도 사용하므로 1시간 높여(k = j+1) 출력
		%>
	</body>
</html>

