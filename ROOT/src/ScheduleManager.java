package Schedule;

import java.sql.*;

public class ScheduleManager {
	public void updateaddSchedule(String roomid, String day, String start, String end) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
		
    	String sql = "INSERT INTO "+roomid+" (name, weekday, starttime, endtime) VALUES('testname', '"+day+"', '"+start+"', '"+end+"');";
    	state.executeUpdate(sql);
    	state.close();
    	conn.close();
	}
	public void updatedeleteSchedule(String roomid, String day, String start, String end) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
		
		String sql = "DELETE FROM "+roomid+" WHERE name='testname' AND weekday='"+day+"' AND starttime='"+start+"' AND endtime='"+end+"';";
		state.executeUpdate(sql);
		state.close();
		conn.close();
	}
}

