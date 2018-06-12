package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;

public class DataSource {
	
	public static Connection getConnection() throws NamingException, SQLException  {
		InitialContext ctx = new InitialContext();
		return ((javax.sql.DataSource) ctx.lookup("java:/comp/env/jdbc/ces")).getConnection();
	}
	
	public static Connection getJdbcConnection() throws NamingException, SQLException  {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			return DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=ZHCT1220;SelectMethod=cursor", "sa", "63149253"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
