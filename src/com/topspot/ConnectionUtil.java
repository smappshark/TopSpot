package com.topspot;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.topspot.common.Constants;

/**
 * Defined database connections and common methods to use through out
 * application.
 * 
 * @author pdudekula
 * 
 */
public class ConnectionUtil {
	private static ConnectionUtil instance = new ConnectionUtil();
	private Constants objConstants = new Constants();
	
	 //private constructor
    private ConnectionUtil() {
        try {
        	System.out.println("DBDriver - "+objConstants.getValue("DBDriver"));
            Class.forName(objConstants.getValue("DBDriver"));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    private Connection createConnection() {
        Connection connection = null;
        String URL = null;
        try {
        	URL = objConstants.getValue("DBUrl") + objConstants.getValue("DBName") + "?user="
					+ objConstants.getValue("DBUserName") + "&password=" + objConstants.getValue("DBPassword");
            connection = DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println("ERROR: Unable to Connect to Database.");
        }
        return connection;
    }  
     
    //singleton method
	public static Connection getConnection() throws Exception {
		 return instance.createConnection();
		/*Connection conn = null;
		
		try {
			Class.forName(objConstants.getValue("DBDriver"));
			url = objConstants.getValue("DBUrl") + objConstants.getValue("DBName") + "?user="
					+ objConstants.getValue("DBUserName") + "&password=" + objConstants.getValue("DBPassword");
			
			 //url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			conn = DriverManager.getConnection(url);
		} catch (SQLException sqle) {
			System.out.println("SQLException:"
					+ " Unable to open connection to db: " + sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			System.out.println("Exception: Unable to open connection to db: "
					+ e.getMessage());
			throw e;
		}
		return conn;*/
	}
	
public static ResultSet executeChartQueries(String strBuildQuery){
	Connection conn = null;
		//ResultSet rs = null;
		try {
			conn = getConnection();
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
			closeConnection(conn);
		}
	}

	public static void closeConnection(Connection conn) {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
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
