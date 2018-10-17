package net.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen {
	public Connection getConnection(){ //DB연결
		//1) 오라클 DB
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String user="java0927";
		String password="1234";
		String driver="oracle.jdbc.driver.OracleDriver"; //ojdbc6.jar
		
				
		
		//2) My-SQL DB
		/*
		String url="jdbc:mysql://localhost:3306/myjava";
		String user="root";
		String password="Soldesk1234~";
		String driver="org.gjt.mm.mysql.Driver";
		*/
		
		Connection con=null;
		try {
			Class.forName(driver);
		    con = DriverManager.getConnection(url, user, password);
		}catch(Exception e){
			System.out.println("DB 연결 실패 : " + e);
		}
		
		return con;
		
	}//end
}//class end
