package User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class UserManager {
	public void makeUser(String userid, String userpw) throws ClassNotFoundException, SQLException, IOException {
		//유저 디렉토리 생성, index 파일 생성
		String original = "/var/lib/tomcat8/webapps/ROOT/src/roomlistforuser.jsp";
		File oriuserinfo = new File(original);
		String newpath = "/var/lib/tomcat8/webapps/ROOT/user/"+userid;
		File userinfo = new File(newpath);
		userinfo.createNewFile(); //디렉토리 및 파일 생성
		//파일 복사
		Files.copy(oriuserinfo.toPath(), userinfo.toPath(), StandardCopyOption.REPLACE_EXISTING);
		//파일 내용 수정
		/* 이곳에 원본 파일 sql문 찾아서 mainuser부분 이름을 바꿔야함*/
		
		//유저 정보 insert
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
		
		String sql = "INSERT INTO user (id, pw) VALUES('"+userid+"', '"+userpw+"');";
    	state.executeUpdate(sql);
    	state.close();
    	conn.close();
	}
	public void delUser(String userid) throws ClassNotFoundException, SQLException {
		String path = "/var/lib/tomcat8/webapps/ROOT/user/"+userid;
		File folder = new File(path);
		while(folder.exists()) {
			File[] folderlist = folder.listFiles();
			
			for(int i=0; i<folderlist.length;i++)
				folderlist[i].delete();
			if(folderlist.length==0&&folder.isDirectory())
				folder.delete();
		}
		
		//유저 정보 delete
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb", "user", "1234");
		Statement state = conn.createStatement();
				
		String sql = "DELETE FROM user WHERE userid="+userid+";";
    	state.executeUpdate(sql);
    	state.close();
    	conn.close();
	}
}
