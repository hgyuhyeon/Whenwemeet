package room;

import java.sql.*;
public class ScheduleManager {
	private Connection conn;
	private PreparedStatement pstmt; 
	public ScheduleManager() {
		try { 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/wwm", "user", "1234");
			} catch (Exception e) {
			e.printStackTrace(); 
		}
	}
	public int addSchedule(String roomID, String year, String month, String day, String startTime, String endTime) {
		String sql = "INSERT INTO SCHEDULE VALUES(?,?,?,?,?,?);";
    	try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			pstmt.setString(4, day); 
			pstmt.setString(5, startTime); 
			pstmt.setString(6, endTime);
			return pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return -1; //데이터베이스 오류
	}
	public ResultSet getSchedule(String roomID, String year, String month, String day) {
		String sql = "SELECT * FROM SCHEDULE WHERE roomID=? "
				+ "AND year=? AND month=? AND day=?;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			pstmt.setString(4, day); 
			return pstmt.executeQuery(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return null; //데이터베이스 오류
	}
	public Object getDaySchedule(String roomID, String year, String month, String day) {
		String sql = "SELECT * FROM SCHEDULE WHERE roomID=? "
				+ "AND year=? AND month=? AND day=?;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			return pstmt.executeQuery(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return 0; //데이터베이스 오류
	}
	public ResultSet getEntireSchedule(String roomID) {
		String sql = "SELECT * FROM SCHEDULE WHERE roomID=?;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			return pstmt.executeQuery(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return null; //데이터베이스 오류
	}
	public int deleteSchedule(String roomID, String year, String month, String day, String startTime, String endTime) {		
		String sql = "DELETE FROM SCHEDULE WHERE roomID=? "
				+ "AND year=? AND month=? AND day=?"
				+ "AND starttime=? AND endtime=?;";
    	try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.setString(2, year); 
			pstmt.setString(3, month); 
			pstmt.setString(4, day); 
			pstmt.setString(5, startTime); 
			pstmt.setString(6, endTime);
			return pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return -1; //데이터베이스 오류
	}
}
