package com.topspot;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.google.appengine.api.utils.SystemProperty;

public class UtilityClass {
	public static Connection conn = null;
	public static int count=0;
	private static final String DBNAME = "topspot";
	private static final String DB_USERNAME = "root";
	private static final String DB_PASSWORD = "";
	public static Connection dbConnection()
	 {
		 
		 try
		  {
			  String url = null;
			 /* if (SystemProperty.environment.value() ==
			      SystemProperty.Environment.Value.Production) {
			    // Load the class that provides the new "jdbc:google:mysql://" prefix.
			    Class.forName("com.mysql.jdbc.GoogleDriver");
			    url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			  } else {
			    // Local MySQL instance to use during development.
			    Class.forName("com.mysql.jdbc.Driver");
			    //url = "jdbc:mysql://127.0.0.1:3306/topspot?user=root";
			 //   url = "jdbc:mysql://192.168.10.192:3306/topspot?user=root";
			    url = "jdbc:mysql://localhost/"+DBNAME+"?user="+DB_USERNAME+"&password="+DB_PASSWORD;
			  }*/
			 
			  //Class.forName("com.mysql.jdbc.GoogleDriver");
			  //String  url = "jdbc:google:mysql://173.194.85.211:tameer-db/TameerClientDB?user=root";
			 //Class.forName("com.mysql.jdbc.Driver");
			//String url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";

			  Class.forName("com.mysql.jdbc.GoogleDriver");
		        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
		        
			  conn = DriverManager.getConnection(url);
			  conn.setAutoCommit(false);
		  }
		  catch(Exception ex)
		  {
			 ex.printStackTrace();
		  }
		 return conn;
	 }
	 
	public static void purgeDomains(String DomainTable)
	{
		String query = "DELETE FROM "+DomainTable;
		try 
		{
			 Statement stmt=conn.createStatement();
			 int result= stmt.executeUpdate(query);
			 System.out.println(DomainTable+" Delete result----->"+result);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	
	 public static int recordCount(String DomainTable)
	{
		 String query = "SELECT MAX(Sno) AS count FROM "+DomainTable;
		try 
		{
			 Statement stmt=conn.createStatement();
			 ResultSet rs = stmt.executeQuery(query);
			 rs.next();
			 count = rs.getInt(1);
			 System.out.println("bayut_data Count----->"+count);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return count;
	}
	 public static void SubToMainTables()
	 {
		 CallableStatement callableStatement = null;
		 String getDBUSERByUserIdSql = "{call SubtoMainTable()}";
		 try
		 {
			 callableStatement = conn.prepareCall(getDBUSERByUserIdSql);
			 callableStatement.executeUpdate();
			 conn.commit();
			 
	 } catch (Exception e) {
		 try {
			conn.rollback();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
		//	e1.printStackTrace();
			e1.printStackTrace();
		}
			e.printStackTrace();

		} finally {
		}
	 }
	 
	 
	 
}
