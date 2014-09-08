package topspot;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
			

			// added by gopal on 31-07-2014
			Constants objConstants = new Constants(); // for reading properties
														// file
			conn = ConnectionUtil.getConnection(); // for getting google cloud
													// sql connection from util
													// class
			DBName = objConstants.getValue("DBName"); // reading db name from
														// properties file

			rs1 = conn
					.createStatement()
					.executeQuery(
							"SELECT DISTINCT(Build_Area) FROM "
									+ DBName
									+ ".newton  WHERE (Build_Area IS NOT NULL) ORDER BY Build_Area");
			while (rs1.next()) {
				String ss2 = rs1.getString(1);
				colArea.add(ss2);
			}
			rs1 = conn
					.createStatement()
					.executeQuery(
							"SELECT DISTINCT(Sub_Area) FROM "
									+ DBName
									+ ".newton  WHERE (Sub_Area IS NOT NULL) ORDER BY Sub_Area");
			while (rs1.next()) {
				String ss2 = rs1.getString(1);
				colSubArea.add(ss2);
			}
		} catch (Exception ex) {
			System.out.println("getConnection Exception --->" + ex);
		}

	}

	public List<TopspotBean> getBarChartData(String req_Area, String req_SubArea,
			String req_datepicker, String req_datepicker1, ArrayList<String> buidlingsList) {

		ResultSet rsBuildNames = null;
		ArrayList<Integer> colBedroomcount = null;
		Iterator<String> colItrBuildNames = null;
		TopspotBean barChartBean = new TopspotBean();
		List<TopspotBean> buildingList = new ArrayList<TopspotBean>();
		int indexBedNum = 0;

		Fromdate1 = req_datepicker;
		Todate1 = req_datepicker1;
		int indexval = 0;
		
		Constants objConstants = new Constants(); 
		try {
			conn = ConnectionUtil.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		DBName = objConstants.getValue("DBName");

		try {
			System.out.println("req_Area --->" + req_Area);
			System.out.println("req_SubArea --->" + req_SubArea);
			System.out.println("req_datepicker --->" + req_datepicker);
			System.out.println("req_datepicker1 --->" + req_datepicker1);

			String strtopBuildingsQuery = "SELECT building FROM " + DBName
					+ ".newton ";
			

			if (buidlingsList == null || buidlingsList.size() == 0 ) {

				if (req_Area != null && !req_Area.equals("null")
						&& !req_Area.equalsIgnoreCase("All") && req_Area != "") {
					strtopBuildingsQuery = strtopBuildingsQuery
							+ "where Build_Area='" + req_Area + "' ";
					indexval = indexval + 1;
				}// end of if
				if (req_datepicker != null
						&& !req_datepicker.equalsIgnoreCase("")
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

			}else{
				// todo
				if(buidlingsList != null && buidlingsList.size() > 0)
					colBuildNames = new ArrayList<String>(buidlingsList);
			}
			
			rsBuildNames = null;

			String strBedroomQuery = "SELECT DISTINCT(Bedrooms) FROM " + DBName
					+ ".newton WHERE (Bedrooms IS NOT NULL) ORDER BY Bedrooms";
			String strBedroomCountQuery = "SELECT COUNT(Bedrooms),Building,Bedrooms FROM TameerClientDB.newton WHERE Bedrooms IN (";
			System.out.println("strBedroomQuery --->" + strBedroomQuery);

			rsBuildNames = conn.createStatement().executeQuery(strBedroomQuery);

			while (rsBuildNames.next()) {
				String noOfBedRooms = rsBuildNames.getString(1);
				if (rsBuildNames.isLast()) { // loop to know end of list
					strBedroomCountQuery = strBedroomCountQuery + "'"
							+ noOfBedRooms + "') ";
				} else {
					strBedroomCountQuery = strBedroomCountQuery + "'"
							+ noOfBedRooms + "',";
				}

				colBedRooms.add(noOfBedRooms);
			}
			rsBuildNames = null;

			if (colBuildNames != null) {
				colItrBuildNames = colBuildNames.iterator();
			
			} else {
				System.out.println("colItrBuildNames is null --->");
			}
			
			if (colBuildNames != null && colBuildNames.size() > 0) {
				strBedroomCountQuery = strBedroomCountQuery + "and Building IN(";
			}

			while (colItrBuildNames.hasNext()) { // loop to buid dynamic sql query using buildingnames

				String BuildingName = (String) colItrBuildNames.next();
				
				if (indexBedNum == colBuildNames.size() - 1) { // loop to know end of list
					strBedroomCountQuery = strBedroomCountQuery + "'"
							+ BuildingName + "')";
				} else {
					strBedroomCountQuery = strBedroomCountQuery + "'"
							+ BuildingName + "',";
				}

				indexBedNum = indexBedNum + 1;
			}

			if (Fromdate != null) {
				strBedroomCountQuery = strBedroomCountQuery
						+ " and tran_date >= '" + Fromdate + "' ";
			}
			if (Todate != null) {
				strBedroomCountQuery = strBedroomCountQuery
						+ " and tran_date <= '" + Todate + "'";
			}

			strBedroomCountQuery = strBedroomCountQuery
					+ " GROUP BY Building,Bedrooms ORDER BY Building desc";

			System.out
					.println("strBedroomCountQuery - " + strBedroomCountQuery);
			rsBuildNames = conn.createStatement().executeQuery(
					strBedroomCountQuery);

			colBedroomcount = new ArrayList<Integer>();

			colBuildNames = new ArrayList<String>();
			
			
			int k = 0;
			
			if (rsBuildNames != null) {

				while (rsBuildNames.next()) {// loop to iterate resultset
					boolean isFlag = false;
					String buildingName = rsBuildNames.getString(2);// temp variable to hold buildng name
					Integer noOfBedRooms = rsBuildNames.getInt(1);
					String typeOfBedRoomString = rsBuildNames.getString(3);
					Integer typeOfBedRoom = null;
					
					if(!typeOfBedRoomString.equals("Com")){
						typeOfBedRoom = new Integer(rsBuildNames.getString(3));
					}else{
						typeOfBedRoom = colBedRooms.size() - 1;
					}
					
					if (!colBuildNames.contains(buildingName)) { // loop to check whether building name is already in the list
						if (colBuildNames.size() > 0) { // loop to check at the initial step
							//barChartBean.setBuildingRoomsList(tempBuildingName,colBedroomcount);
							colBedroomcounts.add(colBedroomcount);
							colBedroomcount = null;
							colBedroomcount = new ArrayList<Integer>();
							k = 0;
							isFlag = false;
							
						} // end of if
						colBuildNames.add(buildingName); // adding building name to array list

					} // end of if
					
					if(isFlag)
						k =0;
					
					while(k <= typeOfBedRoom){
						Integer tempk = k;
						if(k != typeOfBedRoom){
							colBedroomcount.add(k,0); // adding bedroom count available per area to array list
							barChartBean.setNoOfAvaialableRooms(0);
							barChartBean.setBuildingRoomType(tempk.toString());
						}else{
							if(typeOfBedRoomString.equals("Com")){
								isFlag = true;
								barChartBean.setBuildingRoomType("Com");
							}else{
								isFlag = false;
								barChartBean.setBuildingRoomType(tempk.toString());
							}
							
							colBedroomcount.add(k,noOfBedRooms); // adding bedroom count available per area to array list
							barChartBean.setNoOfAvaialableRooms(noOfBedRooms);
						}
						barChartBean.setBuildingName(buildingName);
						
						buildingList.add(barChartBean);
						barChartBean = new TopspotBean();
						k++;
					}

				}// end of while
				
				//adding building list
				/*barChartBean = new TopspotBean();
				barChartBean.setBuildingList(colBuildNames);
				buildingList.add(barChartBean);*/
				
				
				//adding type of rooms list
				barChartBean = new TopspotBean();
				barChartBean.setBuildingRoomTypeList(colBedRooms);
				barChartBean.setBuildingListLength(colBuildNames.size());
				buildingList.add(barChartBean);

				colBedroomcounts.add(colBedroomcount);
				colBedroomcount = null;

			}

		} catch (SQLException sqlex) {
			System.out.println("SQL Exceptions --->" + sqlex);
		} catch (Exception ex) {
			System.out.println("Exceptions --->" + ex);
		}
		return buildingList;

	}
	
	
}
