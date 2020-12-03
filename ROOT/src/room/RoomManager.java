package room;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.*;

public class RoomManager {
	private Connection conn;
	private PreparedStatement pstmt;
	public RoomManager() {
		try { 
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/wwm", "user", "1234");
			} catch (Exception e) {
			e.printStackTrace(); 
		}
	}
	public int makeRoom(String userID, String roomName) throws IOException {
		//방 링크를 위한 랜덤 문자열 생성
		char[] tmp = new char[20]; //for roomID
		for(int i=0; i<tmp.length;i++) {
			int div = (int) Math.floor(Math.random()*2); //알파벳, 숫자 랜덤
			
			if(div==0) //0이면 숫자
				tmp[i]=(char)(Math.random()*10+'0');
			else //1이면 알파벳
				tmp[i]=(char)(Math.random()*52+'A');
		}
		String roomID = new String(tmp);
		//
		
		//디렉터리, 파일 생성하여 그곳의 index 파일에 이동
		//새 room 디렉터리 생성
		String path = "/var/lib/tomcat8/webapps/ROOT/room/"+roomID+"/index.jsp";
		File newroom = new File(path);
		newroom.createNewFile(); //생성
		//파일 복사
		String[] filelist = { "index.jsp", "detail.jsp", "addSchedule.jsp", "deleteSchedule.jsp", "filter.jsp", "emptySchedule.jsp" };
		for (int i=0;i<filelist.length;i++) {
			String index = "/var/lib/tomcat8/webapps/ROOT/doc/"+filelist[i];
			File roominfo = new File(index);
			Files.copy(roominfo.toPath(), newroom.toPath(), StandardCopyOption.REPLACE_EXISTING);
		}
		
		//room 정보 insert
		String sql = "INSERT INTO ROOMLIST VALUES(?, ?, ?);";
		try { 
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, userID); 
			pstmt.setString(2, roomID); 
			pstmt.setString(3, roomName); 
			return pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return -1; //데이터베이스 오류
	}
	public int delRoom(String roomID) {
		String path = "/var/lib/tomcat8/webapps/ROOT/room/"+roomID;
		File folder = new File(path);
		while(folder.exists()) { //디렉터리와 파일 모두 삭제
			File[] folderlist = folder.listFiles();
			
			for(int i=0; i<folderlist.length;i++)
				folderlist[i].delete(); //파일 삭제
			if(folderlist.length==0&&folder.isDirectory())
				folder.delete(); //디렉터리 삭제
		}
		
		//room 정보 delete
    	try { 
    		String sql = "DELETE FROM SCHEDULE WHERE roomID= ?;"; //SCHEDULE에서 해당 방의 모든 일정 삭제
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, roomID); 
			pstmt.executeUpdate();
			
    		String sqll = "DELETE FROM ROOMLIST WHERE roomID= ?;"; //ROOMLIST에서 해당 방 삭제
			pstmt = conn.prepareStatement(sqll); 
			pstmt.setString(1, roomID); 
			pstmt.executeUpdate();
			pstmt.close();
	    	conn.close();
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return -1; //데이터베이스 오류
	}
}
