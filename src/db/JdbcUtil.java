package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcUtil {
	public static Connection getConnection() throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con=DriverManager.getConnection
	    		("jdbc:mysql://localhost:3306/testDB?serverTimezone=UTC",
	    				"java","java");	    
	    return con;
	}
}