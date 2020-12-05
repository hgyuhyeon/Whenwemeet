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
    	String totalday = year+month+day;
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
				+ "AND year=? AND month=? AND day=?;";
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
	public List<Schedule> getEntireSchedule(String roomID) {
		List<Schedule> sdules = new ArrayList<Schedule>();
		String sql = "SELECT * FROM SCHEDULE WHERE roomID=?;";
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
	public List<Schedule> getEmptySchedule(String roomID, String dstartend[], String tstartend[], String ltime) {
		List<Schedule> sdules = new ArrayList<Schedule>();
		
		
		String sqlselect = "SELECT * FROM SCHEDULE WHERE (roomID=?) ";
		String sqlfilter = "";
		
		if(dstartend[0]!=null) //필터 1
			sqlfilter += "AND (totalDay BETWEEN "+dstartend[0]+" AND "+dstartend[1]+") ";
		if(tstartend[0]!=null)
			sqlfilter += "AND (startTime>=+"+tstartend[0]+" AND endtime<="+tstartend[1]+") ";
		if(ltime!=null)
			sqlfilter += "AND (endtime-starttime>="+ltime+") ";
		String sqlorder = " ORDER BY 2,3,4,5;";
		
		String sql = sqlselect + sqlfilter + sqlorder;
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
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
