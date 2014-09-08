package com.topspot;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.topspot.common.Constants;
import java.util.logging.Logger;
/**
 * Defined database connections and common methods to use through out
 * application.
 * 
 * @author pdudekula
 * 
 */
public class ConnectionUtil {
	private static ConnectionUtil instance = new ConnectionUtil();
	private static final Logger log = Logger.getLogger(ConnectionUtil.class.getName());
	private static Connection connection;
	private Constants objConstants = new Constants();
	
	 //private constructor
    private ConnectionUtil() {
        try {
        	Class.forName(objConstants.getValue("DBDriver"));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private Connection createConnection() {
       // Connection connection = null;
        String URL = null;
        System.out.println("connection - "+connection);
        
        try {
        	if(connection ==  null || connection.isClosed()){
        		 System.out.println("if connection - "+connection);
	        	URL = objConstants.getValue("DBUrl");
	        	log.info("DB URL: " + URL);
	            connection = DriverManager.getConnection(URL);
	            return connection;
        	}else{
        		 return connection;
        	}
        } catch (SQLException e) {
        	log.severe(e.toString());
            System.out.println("ERROR: Unable to Connect to Database.");
            return null;
        }
       
    }  
     
    //singleton method
	public static Connection getConnection() throws Exception {
		 return instance.createConnection();
		
	}
	
public static ResultSet executeChartQueries(String strBuildQuery,Connection conn){
	//Connection conn = null;
		//ResultSet rs = null;
		try {
			//conn = getConnection();
			ResultSet rs = conn.createStatement().executeQuery(strBuildQuery);
			return rs;
		} catch (SQLException sqlEx) {
			// TODO Auto-generated catch block
			System.out.println("executeChartQueries exception --->"+sqlEx);
			return null;
		}catch(Exception ex)
		{
			// TODO Auto-generated catch block
			System.out.println("executeChartQueries exception --->"+ex);
			return null;
		}
		
		
	}
	public static void executeQuery(String strQuery) throws Exception {
		Connection conn = null;

		try {
			conn = getConnection();
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(strQuery);

		} catch (SQLException sqle) {
			System.out.println("SQLException: Unable to execute query : "
					+ strQuery);
			throw sqle;
		} catch (Exception e) {
			System.out.println("Exception: Unable to execute query: "
					+ strQuery);
			throw e;
		} finally {
			closeConnection();
		}
	}

	public static void closeConnection() {
		try {
			if (connection != null && !connection.isClosed()) {
				
				connection.close();
				connection = null;
			}
		} catch (SQLException sqle) {
			System.out.println("Error while closing connection.");
		}
	}

	public static int getUserIdByEmailId(Connection conn, String query) {
		int id = 0;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			id = rs.getInt(1);
		} catch (Exception ex) {
			System.out.println("Exception occurred "
					+ "while getting user id by email id." + ex);
		}
		return id;
	}

	public static String encryptMD5(String str) {
		java.security.MessageDigest d = null;
		try {
			d = java.security.MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		d.reset();
		d.update(str.getBytes());
		String result = "";
		byte by[] = d.digest();
		for (int i = 0; i < by.length; i++) {
			result += Integer.toString((by[i] & 0xff), 16);
		}
		return result;
	}

}
