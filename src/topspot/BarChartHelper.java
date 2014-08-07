package topspot;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;

public class BarChartHelper {
	String url = null;
	String req_Building = null;
	ResultSet rs1 = null;
	public static Connection conn = null;
	public ArrayList<String> colBuildin = new ArrayList<String>();
	public ArrayList<String> colArea = new ArrayList<String>();
	public ArrayList<String> colSubArea = new ArrayList<String>();

	public java.util.ArrayList<java.util.ArrayList<Integer>> colBedroomcounts = new java.util.ArrayList<java.util.ArrayList<Integer>>();
	public ArrayList<String> colBuildNames = new ArrayList<String>();
	public ArrayList<String> colBedRooms = new ArrayList<String>();
	public ArrayList<String> tempBuildNames = new ArrayList<String>();
	public String Fromdate = null;
	public String Todate = null;
	public String scattValue = null;
	public String scattValue1 = null;
	public String scattValue2 = null;
	public String Fromdate1 = null;
	public String Todate1 = null;
	public String DBName = null;

	public void getConnection() {
		try {
			/*
			 * if (SystemProperty.environment.value() ==
			 * SystemProperty.Environment.Value.Production) { // Load the class
			 * that provides the new "jdbc:google:mysql://" prefix.
			 * Class.forName("com.mysql.jdbc.GoogleDriver"); url =
			 * "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root"
			 * ; } else {
			 */
			// Local MySQL instance to use during development.
			// Class.forName("com.mysql.jdbc.Driver");
			// url =
			// "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";

			// commented on 01-08-2014 by gopal
			/*
			 * Class.forName("com.mysql.jdbc.GoogleDriver"); url =
			 * "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root"
			 * ; DBName = "TameerClientDB";
			 */
			// commented on 01-08-2014 by gopal

			// }

			// commenetd by gopal on 31-07-2014
			// conn = DriverManager.getConnection(url);
			// commenetd by gopal on 31-07-2014

			// added by gopal on 31-07-2014
			Constants objConstants = new Constants(); // for reading properties
														// file
			conn = ConnectionUtil.getConnection(); // for getting google cloud
													// sql connection from util
													// class
			DBName = objConstants.getValue("DBName"); // reading db name from
														// properties file

			rs1 = conn.createStatement().executeQuery(
					"SELECT DISTINCT(Build_Area) FROM " + DBName
							+ ".newton  WHERE (Build_Area IS NOT NULL) ORDER BY Build_Area");
			while (rs1.next()) {
				String ss2 = rs1.getString(1);
				colArea.add(ss2);
			}
			rs1 = conn.createStatement().executeQuery(
					"SELECT DISTINCT(Sub_Area) FROM " + DBName
							+ ".newton  WHERE (Sub_Area IS NOT NULL) ORDER BY Sub_Area");
			while (rs1.next()) {
				String ss2 = rs1.getString(1);
				colSubArea.add(ss2);
			}
		} catch (Exception ex) {
			System.out.println("getConnection Exception --->" + ex);
		}

	}

	public void getBarChartData(String req_Area, String req_SubArea,
			String req_datepicker, String req_datepicker1) {

		ResultSet rsBuildNames = null;
		ArrayList<Integer> colBedroomcount = null;
		Iterator<String> colItrBuildNames = null;
		int indexBedNum = 0;
		
		Fromdate1 = req_datepicker;
		Todate1 = req_datepicker1;
		int indexval = 0;
		
		try {
			System.out.println("req_Area --->" + req_Area);
			System.out.println("req_SubArea --->" + req_SubArea);
			System.out.println("req_datepicker --->" + req_datepicker);
			System.out.println("req_datepicker1 --->" + req_datepicker1);

			String strtopBuildingsQuery = "SELECT building FROM " + DBName
					+ ".newton ";
			/*
			 * if(req_SubArea != null && !req_SubArea.equals("null")
			 * &&!req_SubArea.equalsIgnoreCase("All")) {
			 * strtopBuildingsQuery=strtopBuildingsQuery
			 * +"where Sub_Area='"+req_SubArea+"' "; } else
			 */
			if (req_Area != null && !req_Area.equals("null")
					&& !req_Area.equalsIgnoreCase("All")) {
				strtopBuildingsQuery = strtopBuildingsQuery
						+ "where Build_Area='" + req_Area + "' ";
				indexval = indexval + 1;
			}// end of if
			if (req_datepicker != null && !req_datepicker.equalsIgnoreCase("")
					&& !req_datepicker.equalsIgnoreCase("null")
					&& !req_datepicker.equalsIgnoreCase("From date")
					&& req_datepicker.length() == 10) {
				String[] strdate = req_datepicker.split("/");
				Fromdate = strdate[2] + "-" + strdate[0] + "-" + strdate[1];
				if (indexval > 0) {
					strtopBuildingsQuery = strtopBuildingsQuery
							+ " And tran_date >= '" + Fromdate + "'";
					indexval = indexval + 1;
				} else {
					strtopBuildingsQuery = strtopBuildingsQuery
							+ " where tran_date >= '" + Fromdate + "'";
					indexval = indexval + 1;
				}
			} // //end of if
			if (req_datepicker1 != null
					&& !req_datepicker1.equalsIgnoreCase("")
					&& !req_datepicker1.equalsIgnoreCase("null")
					&& !req_datepicker1.equalsIgnoreCase("To date")
					&& req_datepicker1.length() == 10) {
				String[] strdate = req_datepicker1.split("/");
				Todate = strdate[2] + "-" + strdate[0] + "-" + strdate[1];
				if (indexval > 0) {
					strtopBuildingsQuery = strtopBuildingsQuery
							+ " And tran_date <= '" + Todate + "'";
				} else {
					strtopBuildingsQuery = strtopBuildingsQuery
							+ " where tran_date <= '" + Todate + "'";
				}
			}// //end of if
			strtopBuildingsQuery = strtopBuildingsQuery
					+ " GROUP BY building ORDER BY COUNT(building) DESC LIMIT 10";
			scattValue = strtopBuildingsQuery;
			System.out.println("strtopBuildingsQuery --->"
					+ strtopBuildingsQuery);
			System.out.println("conn --->" + conn);
			rsBuildNames = conn.createStatement().executeQuery(
					strtopBuildingsQuery);
			if (rsBuildNames != null) {
				System.out.println("rsBuildNames is not null --->");
				while (rsBuildNames.next()) {
					System.out.println("rsBuildNames is not null123 --->");
					colBuildNames.add(rsBuildNames.getString(1));
				}
			} else {
				System.out.println("rsBuildNames is null --->");
			}
			rsBuildNames = null;

			String strBedroomQuery = "SELECT DISTINCT(Bedrooms) FROM " + DBName + ".newton WHERE (Bedrooms IS NOT NULL) ORDER BY Bedrooms";
			String strBedroomCountQuery = "SELECT COUNT(Bedrooms),Building,Bedrooms FROM TameerClientDB.newton WHERE Bedrooms IN (";
			System.out.println("strBedroomQuery --->"+strBedroomQuery);
		
			rsBuildNames = conn.createStatement().executeQuery(strBedroomQuery);
			
			while(rsBuildNames.next())
			{
				String noOfBedRooms = rsBuildNames.getString(1);
				if (rsBuildNames.isLast()) { //loop to know end of list
					strBedroomCountQuery = strBedroomCountQuery + "'" + noOfBedRooms + "') and Building IN(";
				} else {
					strBedroomCountQuery = strBedroomCountQuery + "'" + noOfBedRooms + "',";
				}

				colBedRooms.add(noOfBedRooms);	
			}
			rsBuildNames=null;
					
			if (colBuildNames != null) {
				colItrBuildNames = colBuildNames.iterator();
			} else {
				System.out.println("colItrBuildNames is null --->");
			}
					
			while (colItrBuildNames.hasNext()) { //loop to buid dynamic sql query using building names

				String BuildingName = (String) colItrBuildNames.next();

				if (indexBedNum == colBuildNames.size() - 1) { //loop to know end of list
					strBedroomCountQuery = strBedroomCountQuery + "'" + BuildingName + "')";
				} else {
					strBedroomCountQuery = strBedroomCountQuery + "'" + BuildingName + "',";
				}

				
				indexBedNum = indexBedNum + 1;
			}
			
			if (Fromdate != null) { 
				strBedroomCountQuery = strBedroomCountQuery + " and tran_date >= '" + Fromdate + "' ";
			}
			if (Todate != null) {
				strBedroomCountQuery = strBedroomCountQuery	+ " and tran_date <= '" + Todate + "'";
			}

			strBedroomCountQuery = strBedroomCountQuery	+ " GROUP BY Building,Bedrooms ORDER BY Building desc";
			
			System.out.println("strBedroomCountQuery - "+strBedroomCountQuery);
			rsBuildNames = conn.createStatement().executeQuery(strBedroomCountQuery);
			
			colBedroomcount = new ArrayList<Integer>();
			
			colBuildNames = new ArrayList<String>();
			
			if(rsBuildNames !=  null){
				
				while (rsBuildNames.next()) {//loop to iterate resultset
					
					String bedroomName = rsBuildNames.getString(2);//temp variable to hold buildng name
					
					if(!colBuildNames.contains(bedroomName) ){ //loop to check whether building name is already in the list
						
						if(colBuildNames.size() > 0){ //loop to check at the initial step
							colBedroomcounts.add(colBedroomcount);
							colBedroomcount = null;
							colBedroomcount = new ArrayList<Integer>();
						} //end of if
						
						colBuildNames.add(bedroomName); //adding building name to array list
						
					}	//end of if
					
					colBedroomcount.add(rsBuildNames.getInt(1)); //adding bedroom count available per area to array list
					
				}//end of while
				
				colBedroomcounts.add(colBedroomcount);
				colBedroomcount = null;
			}
			
		} catch (SQLException sqlex) {
			System.out.println("SQL Exceptions --->" + sqlex);
		} catch (Exception ex) {
			System.out.println("Exceptions --->" + ex);
		}

	}
}
