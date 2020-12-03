package user; 
import java.sql.*;
import user.User;
public class UserDAO { //dao란 데이터베이스 접근 객체 Data Access Object 로 db에서 회원정보를 불러오거나 넣을 때 사용한다. 
	private Connection conn; // db에 접근 할 수 있게 해준다. 
	private PreparedStatement pstmt; 
	private ResultSet rs; 
	//mysql에 연결 
	public UserDAO() {
		try { 
			String dbURL = "jdbc:mysql://localhost/wwm"; 
			String dbID = "user"; 
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			} catch (Exception e) { 
				e.printStackTrace(); 
				} 
		} 
	public int login(String userID, String userPassword) { 
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try { pstmt = conn.prepareStatement(SQL); 
		pstmt.setString(1, userID); 
		rs = pstmt.executeQuery(); 
		if(rs.next()) { 
			if(rs.getString(1).equals(userPassword)) {
				return 1; //로그인 성공 
			} 
			else 
				return 0; //비밀번호 오류 
		} 
		return -1; //아이디 없음 
			} catch (Exception e) { 
				e.printStackTrace(); 
			} 
		return -2; // 데이터베이스 오류 
		} 
	
	public int join(User user) { 
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try { 
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, user.getUserID()); 
			pstmt.setString(2, user.getUserPassword()); 
			pstmt.setString(3, user.getUserName()); 
			pstmt.setString(4, user.getUserGender()); 
			pstmt.setString(5, user.getUserEmail()); 
			return pstmt.executeUpdate(); 
		}catch (Exception e) {
				e.printStackTrace(); 
		} 
		return -1; //데이터베이스 오류
	}
	
	public int del(String userID, String userPassword) { 
		int result = -2;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try { 
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID); 
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				if(rs.getString(1).equals(userPassword)) {
					String delsql="DELETE FROM USER WHERE userID = ?";
					pstmt =conn.prepareStatement(delsql);
					pstmt.setString(1, userID);
					pstmt.executeUpdate();
					rs.close();
					pstmt.close();
					conn.close();
					result = 1; //탈퇴 성공 
				}
				else 
					result = 0; //비밀번호 오류 
			}  
		} catch (Exception e) { 
			e.printStackTrace(); 
		} 
		return result; // 데이터베이스 오류 
		}
}
