package room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleManager {
	private Connection conn;
	private PreparedStatement pstmt; 
	private ResultSet rs;
	public ScheduleManager() {
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/wwm", "user", "1234");
			} catch (Exception e) {
			e.printStackTrace(); 
		}
	}
	public int addSchedule(String roomID, String year, String month, String day, String startTime, String endTime) {
		String sql = "INSERT INTO SCHEDULE VALUES(?,?,?,?,?,?,?);";
    	int result = -1;
    	String twmonth = convertPm(month);
    	String twday = convertPm(day);
    	String totalday = year+twmonth+twday;
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, totalday); 
			pstmt.setString(3, year); 
			pstmt.setString(4, month); 
			pstmt.setString(5, day); 
			pstmt.setString(6, startTime); 
			pstmt.setString(7, endTime);
			result = pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return result;
	}
	public List<Schedule> getSchedule(String roomID, String year, String month, String day) {
		List<Schedule> sdules = new ArrayList<Schedule>();

		String sql = "SELECT * FROM SCHEDULE WHERE roomID=? "
				+ "AND year=? AND month=? AND day=? ORDER BY 2;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			pstmt.setString(4, day); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Schedule sdule = new Schedule();
				sdule.setStartTime(rs.getString("startTime"));
				sdule.setEndTime(rs.getString("endTime"));
				sdules.add(sdule);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return sdules;
	}
	public List<Schedule> getMonthSchedule(String roomID, String year, String month) {
		List<Schedule> sdules = new ArrayList<Schedule>();

		String sql = "SELECT * FROM SCHEDULE WHERE roomID=? AND year=? AND month=? ORDER BY 2;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Schedule sdule = new Schedule();
				sdule.setDay(rs.getString("day"));
				sdules.add(sdule);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return sdules;
	}
	public List<Schedule> getEntireSchedule(String roomID) {
		List<Schedule> sdules = new ArrayList<Schedule>();
		String sql = "SELECT * FROM SCHEDULE WHERE roomID=? ORDER BY 2;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			rs = pstmt.executeQuery(); //return 1;
			
			while(rs.next()) {
				Schedule sdule = new Schedule();
				sdule.setYear(rs.getString("year"));
				sdule.setMonth(rs.getString("month"));
				sdule.setDay(rs.getString("day"));
				sdule.setStartTime(rs.getString("startTime"));
				sdule.setEndTime(rs.getString("endTime"));
				sdules.add(sdule);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return sdules;
	}
	public String convertPm(String temp) { //convert Parameter
		if(Integer.parseInt(temp) < 10) //1자릿수면
			temp = "0"+temp; //앞에 0 추가
		//두자릿수면 그대로 리턴
		return temp;
	}
	public List<EmptyScheduleList> getEmptySchedule(String roomID, String dstartend[], String ltime) {	
		String sql = "SELECT * FROM SCHEDULE WHERE (roomID=?)"
				+ " AND (totalDay BETWEEN ? AND ?)"
				+ " ORDER BY 2;";		
				
		List<Schedule> sdules = new ArrayList<Schedule>(); //sql문 결과로 나온 스케줄들을 전부 저장
		List<Schedule> pempty = new ArrayList<Schedule>(); //sdules의 이전 스케줄 리스트
		List<EmptyScheduleList> results = new ArrayList<EmptyScheduleList>(); //빈 시간 리스트: 결과 리턴값
		
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, dstartend[0]); 
			pstmt.setString(3, dstartend[1]); 
			rs = pstmt.executeQuery();
			
			//첫 날 추가 (빈 시간 출력용)
			Schedule first = new Schedule();
			//dstartend[0]의 8자리를 2020 / 01 / 01으로 split
			int fyear = Integer.parseInt(dstartend[0].substring(0, 4));
			int fmonth = Integer.parseInt(dstartend[0].substring(4, 6));
			int fday = Integer.parseInt(dstartend[0].substring(6));
			first.setYear(Integer.toString(fyear));
			first.setMonth(Integer.toString(fmonth));
			first.setDay(Integer.toString(fday));
			first.setStartTime("0");
			first.setEndTime("0");
			sdules.add(first);
			
			while(rs.next()) {
				Schedule sdule = new Schedule();
				sdule.setYear(rs.getString("year"));
				sdule.setMonth(rs.getString("month"));
				sdule.setDay(rs.getString("day"));
				sdule.setStartTime(rs.getString("startTime"));
				sdule.setEndTime(rs.getString("endTime"));
				sdules.add(sdule);
			} //일정들을 리스트에 저장
			//마지막 날 추가 (빈 시간 출력용)
			Schedule last = new Schedule();
			//dstartend[1]의 8자리를 2020 / 01 / 01으로 split
			int lyear = Integer.parseInt(dstartend[1].substring(0, 4));
			int lmonth = Integer.parseInt(dstartend[1].substring(4, 6));
			int lday = Integer.parseInt(dstartend[1].substring(6));
			last.setYear(Integer.toString(lyear));
			last.setMonth(Integer.toString(lmonth));
			last.setDay(Integer.toString(lday));
			last.setStartTime("24");
			last.setEndTime("24");
			sdules.add(last);
			
			for(int i=0;i<sdules.size();i++) {
				Schedule sdule = new Schedule(); 
				sdule = sdules.get(i); //현재 스케줄
				pempty.add(sdule); //이전 스케줄 리스트에 추가
				if(i==0)
					continue;
				EmptyScheduleList empty = new EmptyScheduleList(); //빈 스케줄
				
				//시작시간, 끝시간 설정
				empty.setStartYear(sdules.get(i).getYear());
				empty.setEndYear(pempty.get(i-1).getYear()); //시작년도, 끝년도 설정
				empty.setStartMonth(sdules.get(i).getMonth());
				empty.setEndMonth(pempty.get(i-1).getMonth()); //시작월, 끝월 설정
				empty.setStartDay(pempty.get(i-1).getDay());
				empty.setEndDay(sdules.get(i).getDay()); //시작일, 끝일 설정
				empty.setStartTime(pempty.get(i-1).getEndTime()); //빈 시간의 시작은 이전 스케줄의 끝
				empty.setEndTime(sdules.get(i).getStartTime()); //빈 시간의 끝은 현재 스케줄의 시작
				
				
				//필터 3 시작
				if(ltime!=null) {
					int dstart = Integer.parseInt(empty.getStartDay());
					int dend = Integer.parseInt(empty.getEndDay());
					int tstart = Integer.parseInt(empty.getStartTime());
					int tend = Integer.parseInt(empty.getEndTime());
					if(tend<tstart) //날짜가 넘어가면
						tend += 24 * (dend-dstart); //날짜 일수만큼 시간의 끝 추가
					if(tend-tstart <= Integer.parseInt(ltime)) //최소 시간 만족 못하면
						continue; //패스
				}
				//필터 3 끝
				results.add(empty); //결과값에 추가
			}

		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return results;
	}
	public int deleteSchedule(String roomID, String year, String month, String day, String startTime, String endTime) {		
		String sql = "DELETE FROM SCHEDULE WHERE roomID=? "
				+ "AND year=? AND month=? AND day=?"
				+ "AND starttime=? AND endtime=?;";
    	int result = -1; //데이터베이스 오류
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			pstmt.setString(4, day); 
			pstmt.setString(5, startTime); 
			pstmt.setString(6, endTime);
			result =  pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return result; 
	}
}
