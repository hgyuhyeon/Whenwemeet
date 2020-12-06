package room;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public RoomManager() {
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/wwm", "user", "1234");
			} catch (Exception e) {
			e.printStackTrace(); 
		}
	}
	public int makeRoom(String userID, String roomName) throws IOException {
		//방 링크를 위한 랜덤 문자열 생성
		char[] tmp = new char[20]; //for roomID
		for(int i=0; i<tmp.length;i++) {
			int div = (int)Math.floor(Math.random()*3); //알파벳, 숫자 랜덤
			
			if(div==0) //0이면 숫자
				tmp[i]=(char)(Math.random()*10+'0');
			else if(div==1)//1이면 알파벳 대문자
				tmp[i]=(char)(Math.random()*26+'A');
			else //2면 알파벳 소문자
				tmp[i]=(char)(Math.random()*26+'a');
		}
		String roomID = new String(tmp);
		//
		
		//디렉터리, 파일 생성하여 그곳의 index 파일에 이동
		//새 room 디렉터리 생성
		File newdir = new File("/var/lib/tomcat8/webapps/ROOT/room/"+roomID); //디렉터리 경로 생성
		if(!newdir.exists()) {
			Runtime.getRuntime().exec("chmod 777 /var/lib/tomcat8/webapps/ROOT/room/"+roomID);
			try {
				newdir.mkdirs(); //디렉터리 생성
				//파일 복사
				String[] filelist = { "index.jsp", 
						"detail.jsp", 
						"calendar.jsp",
						"addSchedule.jsp", 
						"updateaddSchedule.jsp", 
						"deleteSchedule.jsp", 
						"updatedeleteSchedule.jsp", 
						"filter.jsp", 
						"emptySchedule.jsp" };
				for (int i=0;i<filelist.length;i++) {
					String path = "/var/lib/tomcat8/webapps/ROOT/doc/"+filelist[i];
					File roominfo = new File(path);
					String copypath = newdir.getPath()+"/"+filelist[i];
					File addinfo = new File(copypath);
					addinfo.setExecutable(true, false);
					addinfo.setReadable(true, false);
					addinfo.setWritable(true, false);
					addinfo.createNewFile(); //파일 생성
					Files.copy(roominfo.toPath(), addinfo.toPath(), StandardCopyOption.REPLACE_EXISTING);
				}
				//
				
				//room 정보 insert
				String sql = "INSERT INTO ROOMLIST VALUES(?, ?, ?);";
				int rst = -1;
				try { 
					pstmt = conn.prepareStatement(sql); 
					pstmt.setString(1, userID); 
					pstmt.setString(2, roomID); 
					pstmt.setString(3, roomName); 
					rst =  pstmt.executeUpdate(); //return 1;
				}catch (Exception e) {
						e.printStackTrace(); 
						rst = -1;
				} finally {
			        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
			        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
			        return rst;
			    }
			} catch (Exception e){
				e.getStackTrace();
			}
		}
		return 0; //-1: 데이터베이스 오류, 0: 파일 오류
	}
	public List<Room> getRoomList(String userID) {
		List<Room> rooms = new ArrayList<Room>();
		String sql = "SELECT * FROM ROOMLIST WHERE userID=?;";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, userID); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Room room = new Room();
				room.setRoomID(rs.getString("roomID"));
				room.setRoomName(rs.getString("roomName"));
				rooms.add(room);
			}
		}catch (Exception e) {
				e.printStackTrace(); 
		} finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	    }
		return rooms;
	}
	public int delRoom(String roomID) throws IOException {
		Runtime.getRuntime().exec("chmod 777 /var/lib/tomcat8/webapps/ROOT/room/"+roomID);
		Runtime.getRuntime().exec("rm -r /var/lib/tomcat8/webapps/ROOT/room/"+roomID);
		
		//room 정보 delete
    	try { 
    		String sql = "DELETE FROM SCHEDULE WHERE roomID=?;"; //SCHEDULE에서 해당 방의 모든 일정 삭제
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.executeUpdate();
			
    		String sqll = "DELETE FROM ROOMLIST WHERE roomID=?;"; //ROOMLIST에서 해당 방 삭제
			pstmt = conn.prepareStatement(sqll); 
			pstmt.setString(1, roomID); 
			pstmt.executeUpdate();
			pstmt.close();
	    	conn.close();
		}catch (Exception e) { //등록된 일정이 없는 방이면 예외 생기긴 함 ㅋㅋ
				e.printStackTrace(); 
		}
		return 1;
		}
}
