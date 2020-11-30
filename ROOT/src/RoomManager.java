package Room;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.*;

public class RoomManager {
	public void makeRoom(String mainuser, String roomname) throws ClassNotFoundException, SQLException, IOException {
		//방 링크를 위한 랜덤 문자열 생성
		char[] rstr = new char[20];
		for(int i=0; i<rstr.length;i++) {
			int div = (int) Math.floor(Math.random()*2); //알파벳, 숫자 랜덤
			
			if(div==0) //0이면 숫자
				rstr[i]=(char)(Math.random()*10+'0');
			else //1이면 알파벳
				rstr[i]=(char)(Math.random()*52+'A');
		}
		String str = new String(rstr);
		//
		
		//디렉터리, 파일 생성하여 그곳의 index 파일에 이동
		String original = "/var/lib/tomcat8/webapps/ROOT/src/roominfo.jsp";
		File oriroominfo = new File(original);
		String path = "/var/lib/tomcat8/webapps/ROOT/room/"+str+"/index.jsp";
		File roominfo = new File(path);
		roominfo.createNewFile();
		//파일 복사
		Files.copy(oriroominfo.toPath(), roominfo.toPath(), StandardCopyOption.REPLACE_EXISTING);
		//파일 내용 수정
		/* 이곳에 원본 파일 sql문 찾아서 mainuser부분 이름을 바꿔야함*/
		
		//room 정보 insert
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
		
		String sql = "INSERT INTO user (mainuser, roomid, roomname) VALUES('"+mainuser+"', '"+str+"' , '"+roomname+"');";
		state.executeUpdate(sql);
	    state.close();
	    conn.close();
	}
	public void delRoom(String mainuser, String roomid) throws ClassNotFoundException, SQLException {
		String path = "/var/lib/tomcat8/webapps/ROOT/room/"+roomid;
		File folder = new File(path);
		while(folder.exists()) {
			File[] folderlist = folder.listFiles();
			
			for(int i=0; i<folderlist.length;i++)
				folderlist[i].delete();
			if(folderlist.length==0&&folder.isDirectory())
				folder.delete();
		}
		
		//room 정보 delete
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
				
		String sql = "DELETE FROM roomlist WHERE mainuser="+mainuser+" AND roomid="+roomid+";";
    	state.executeUpdate(sql);
    	state.close();
    	conn.close();
	}
}
