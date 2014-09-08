package com.topspot.register.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import topspot.BuildingTrendDetails;
import topspot.TopspotBean;

import com.google.gson.Gson;
import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;
import com.topspot.register.beans.Building;
import com.topspot.register.beans.InvestorComments;
import com.topspot.response.TopSpotResponse;

/**
 * 
 * @author pdudekula
 * 
 */

public class BuildingDao {
	static Constants objConstants = new Constants();
	private static String DBName = objConstants.getValue("DBName");

	public static List<Building> getBuildingDetails(String area,
			String subarea, String buildingstr) {
		List<Building> buildings = new ArrayList<Building>();

		Connection conn = null;

		try {

			conn = ConnectionUtil.getConnection();

			if (conn != null) {
				String query = "select * from " + DBName
						+ ".Building_Database_final " + "where AREA = '" + area
						+ "' " + "and Sub_Area='" + subarea + "' "
						+ "and Building='" + buildingstr + "'";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					return convertToDomain(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return buildings;
	}

	public static List<Building> getBuildingDetailsByName(String buildingstr) {
		List<Building> buildings = new ArrayList<Building>();

		Connection conn = null;

		try {

			conn = ConnectionUtil.getConnection();

			if (conn != null) {
				String query = "select * from " + DBName
						+ ".Building_Database_final " + "where Building='"
						+ buildingstr + "'";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					return convertToDomain(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return buildings;
	}

	public static List<Building> getBuildingDetails(String area, String bType,
			String status, String sMaterial, String aStyle) {
		List<Building> buildings = new ArrayList<Building>();

		Connection conn = null;

		try {

			conn = ConnectionUtil.getConnection();

			if (conn != null) {

				String query = "select * from " + DBName
						+ ".Building_Database_final " + "where AREA = '" + area
						+ "' " + "and Building_Type='" + bType + "' "
						+ "and Building_Status='" + status + "' "
						+ "and Structural_Material='" + sMaterial + "' "
						+ "and Architectural_Style='" + aStyle + "'";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					return convertToDomain(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return buildings;
	}

	/**
	 * @author pdudekula This method converts resultset object into Building
	 *         object.
	 * @param rs
	 * @return
	 */
	public static List<Building> convertToDomain(ResultSet rs) {
		List<Building> buildingList = new ArrayList<Building>();
		try {

			while (rs.next()) {
				Building build = new Building();
				Long l = Long.parseLong(String.valueOf(rs.getInt(1)));
				build.setId(l);
				build.setCity(rs.getString("City"));
				build.setArea(rs.getString("AREA"));
				build.setSubArea(rs.getString("Sub_Area"));
				build.setBuilding(rs.getString("Building"));
				build.setBuildingType(rs.getString("Building_Type"));
				build.setBuildingStatus(rs.getString("Building_Status"));
				build.setStructaralMaterial(rs.getString("Structural_Material"));
				build.setArchitecturalStyle(rs.getString("Architectural_Style"));
				build.setFoundation(rs.getString("Foundation"));
				build.setUsageType(rs.getString("UsageType"));
				build.setHeight(String.valueOf(rs.getInt(12)));
				build.setFloors(String.valueOf(rs.getInt(13)));
				build.setCompletion(String.valueOf(rs.getInt(14)));
				build.setElevators(String.valueOf(rs.getInt(15)));
				build.setParking(String.valueOf(rs.getInt(16)));
				build.setArchitect(rs.getString("Architect"));
				build.setDeveloper(rs.getString("Developer"));
				build.setContractor(rs.getString("Contractor"));
				build.setLatitude(String.valueOf(rs.getDouble("Latitude")));
				build.setLongitude(String.valueOf(rs.getDouble("Longitude")));
				build.setImageUrl(rs.getString("ImageLink"));
				build.setComments(rs.getString("Comments"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}


		return buildingList;
	}

	public static void UpdateComments(String buildingId, String comments) {

		String updateQuery = "UPDATE " + DBName
				+ ".Building_Database_final SET Comments = '" + comments
				+ "'  where id=" + buildingId;
		try {
			ConnectionUtil.executeQuery(updateQuery);
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			ConnectionUtil.closeConnection();
		}

	}

	public static String getArea() {
		try {
			String query = "select Distinct(Area) from " + DBName
					+ ".Building_Database_final order by Area";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getBuildingNames() {
		try {
			String query = "SELECT DISTINCT(Building) FROM "
					+ DBName
					+ ".Building_Database_final WHERE Latitude IS NOT NULL AND Latitude!=0 AND Longitude IS NOT NULL AND Longitude!=0 ORDER BY Building";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return null;
	}

	public static String getDistinctBuildingNames() {
		try {
			String query = "SELECT DISTINCT(Building) FROM  "
					+ DBName
					+ ".Building_Database_final ORDER BY Building";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return null;
	}
	public static String getSubAreaByArea(String area) {

		try {
			String query = "select Distinct(Sub_Area) from " + DBName
					+ ".Building_Database_final where Area='" + area
					+ "' order by Sub_Area";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return null;

	}

	public static String getSubAllAreaByAreas() {

		try {
			String query = "select Distinct(Sub_Area) from " + DBName
					+ ".Building_Database_final order by Sub_Area";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return null;

	}

	public static String getBuildingBySubArea(String subArea) {

		try {
			String query = "select Distinct(Building_Type) from "
					+ DBName
					+ ".Building_Database_final where Latitude IS NOT NULL AND Latitude!=0 AND Longitude IS NOT NULL AND Longitude!=0 AND Sub_Area='"
					+ subArea + "' order by Building";
			return executeQuery(query);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return null;

	}

	public static String getBuildingStatusByAreaAndBuilding(String subArea,
			String buildingType) {

		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "select DISTINCT(Building_Status) from "
						+ DBName + ".Building_Database_final "
						+ "where Sub_Area='" + subArea + "' "
						+ "and Building_Type='" + buildingType + "'";

				return executeQuery(query);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return "";
	}

	public static String getBuildingMaterial(String subArea,
			String buildingType, String buildingStatus) {

		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "select DISTINCT(Structural_Material) from "
						+ DBName + ".Building_Database_final "
						+ "where Sub_Area='" + subArea + "' "
						+ "and Building_Type='" + buildingType
						+ "' and Building_Status='" + buildingStatus + "'";

				return executeQuery(query);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return "";
	}

	public static String getArchitecturalStyle(String subArea,
			String buildingType, String buildingStatus, String buildingMaterial) {
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "select DISTINCT(Architectural_Style) from "
						+ DBName + ".Building_Database_final "
						+ "where Sub_Area='" + subArea + "' "
						+ "and Building_Type='" + buildingType
						+ "' and Building_Status='" + buildingStatus
						+ "' and Structural_Material='" + buildingMaterial
						+ "'";

				return executeQuery(query);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return "";
	}

	private static String executeQuery(String query) {

		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();

			if (conn != null) {
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				Map<String, String> map = new LinkedHashMap<String, String>();
				while (rs.next()) {
					String area = rs.getString(1);
					map.put(area, area);
				}
				return new Gson().toJson(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return null;
	}

	public static String getAreaByType(String type) {

		if (StringUtils.isNotEmpty(type)) {
			try {
				String query = "";
				if ("sale".equalsIgnoreCase(type)) {
					query = "SELECT DISTINCT(bdf.Area)FROM "
							+ DBName
							+ ".Building_Database_final bdf JOIN justproperty_data jpd ON (bdf.Area=jpd.Build_Area) WHERE bdf.Latitude!=0 and Longitude!=0";
				} else {
					query = "SELECT DISTINCT(bdf.Area)FROM "
							+ DBName
							+ ".Building_Database_final bdf JOIN justrentals_data jrd ON (bdf.Area=jrd.Build_Area) WHERE bdf.Latitude!=0 and Longitude!=0";
				}

				return executeQuery(query);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionUtil.closeConnection();
			}

		}
		return null;
	}

	public static List<Map<String, String>> getAreaDetails(String type,
			String area) {
		List<Map<String, String>> areaDetails = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				// SELECT Price_AED,Price_sqft,BDF.Latitude,BDF.Longitude FROM
				// justproperty_data JPD JOIN Building_Database_final BDF ON
				// JPD.Build_Area= BDF.Area WHERE Build_Area='Business Bay' AND
				// BDF.Latitude!=0 AND BDF.Longitude!=0
				String query = "SELECT Price_AED,Price_sqft,BDF.Latitude,BDF.Longitude FROM "
						+ DBName
						+ ".justproperty_data JPD JOIN Building_Database_final BDF ON JPD.Build_Area= BDF.Area WHERE Build_Area='"
						+ area + "' AND BDF.Latitude!=0 AND BDF.Longitude!=0";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					areaDetails = convertToResponse(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return areaDetails;
	}

	public static List<Map<String, String>> convertToResponse(ResultSet rs) {
		List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
		try {
			ResultSetMetaData md = rs.getMetaData();
			int columns = md.getColumnCount();
			while (rs.next()) {
				Map<String, String> map = new LinkedHashMap<String, String>();
				for (int i = 1; i <= columns; ++i) {
					if(rs.getObject(i) != null) {
						map.put(md.getColumnName(i), rs.getObject(i).toString());
					} else {
						map.put(md.getColumnName(i), "");
					}
				}
				listMap.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return listMap;
	}

	public static List<Building> getFactSheetData(String whereClause) {
		List<Building> buildings = new ArrayList<Building>();

		Connection conn = null;

		try {

			conn = ConnectionUtil.getConnection();

			if (conn != null) {
				String query = "select * from " + DBName
						+ ".Building_Database_final " + "where " + whereClause;

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					return convertToDomain(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return buildings;
	}

	public static List<Building> convertToList(ResultSet rs) {
		List<Building> buildingList = new ArrayList<Building>();
		try {

			while (rs.next()) {
				Building build = new Building();
				Long l = Long.parseLong(String.valueOf(rs.getInt(1)));
				build.setId(l);
				build.setAvgRent(rs.getString("AvgRent"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}


		return buildingList;
	}

	public static List<Building> convertToBedroomList(ResultSet rs) {
		List<Building> buildingList = new ArrayList<Building>();
		try {
			while (rs.next()) {
				Building build = new Building();
				build.setBedrooms(rs.getString("Bedrooms"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}


		return buildingList;
	}
	
	public static List<Building> convertToBedroomHistogramList(ResultSet rs) {
		List<Building> buildingList = new ArrayList<Building>();
		try {
			while (rs.next()) {
				Building build = new Building();
				build.setCount(rs.getInt("Count"));
				build.setPrice_AED(rs.getString("Price_sqft"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}


		return buildingList;
	}

	public static List<Building> getGrowthReturnMatrixReport(String buildingName) {
		if (StringUtils.isNotEmpty(buildingName)) {
			Connection conn = null;

			try {
				conn = ConnectionUtil.getConnection();

				String query = "SELECT AVG(Price_sqft) as AvgRent  FROM "
						+ DBName
						+ ".justrentals_data as jr WHERE jr.Building LIKE \"%"
						+ buildingName + "%\" AND jr.rent_sales = \"Rent\"";
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					return convertToList(rs);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionUtil.closeConnection();
			}

		}
		return null;
	}

	public static List<Building> getUniqueBedrooms() {
		Connection conn = null;
		List<Building> objBedrooms = null;
		try {
			conn = ConnectionUtil.getConnection();

			String query = "SELECT DISTINCT(Bedrooms) FROM " + DBName + ".newton WHERE Bedrooms != \"\" AND com_res LIKE \"Res%\" ORDER BY Bedrooms ASC";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			if (rs != null) {
				objBedrooms = convertToBedroomList(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return objBedrooms;
	}

	public static List<Building> getBedroomHistogram(String bedrooms,String area,String building) {
		List<Building> objBedrooms = null;
		Boolean isFlag = false;
		if (StringUtils.isNotEmpty(bedrooms)) {
			Connection conn = null;
			try {
				String query = "SELECT COUNT(Bedrooms) AS Count, Price_sqft FROM " + DBName + ".newton WHERE ";
				conn = ConnectionUtil.getConnection();
				
				if(!bedrooms.equals("null") & !bedrooms.equals("")){
				 query =  query + "Bedrooms=\"" + bedrooms + "\"";
				 isFlag = true;
				}
				if(!area.equals("null") & !area.equals("")){
					if(isFlag)
						query =  query + " and Build_Area=\"" + area + "\"";
					else
						query =  query + "Build_Area=\"" + area + "\"";
					
					isFlag = true;
				}
				if(!building.equals("null") & !building.equals("")){
					 if(isFlag)
							query =  query + " and Building=\"" + building + "\"";
						else
							query =  query + "Building=\"" + building + "\"";
				}
				
				query = query + " GROUP BY Price_sqft  Order By Price_sqft ASC";
				
				System.out.println("histogram query - "+query);
				
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);
	
				if (rs != null) {
					objBedrooms = convertToBedroomHistogramList(rs);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionUtil.closeConnection();
			}

		}
		return objBedrooms;
	}
	
	public static TopSpotResponse setInvestorComments(InvestorComments objInvestorComments) {
		TopSpotResponse objTopSpotResponse = new TopSpotResponse();
		if (objInvestorComments != null) {
			Connection conn = null;
			try {
				
				conn = ConnectionUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO investor_comments (investorId, propertyId, City, " + 
	                     "Area, Building, Developer, Comments) VALUES(?,?,?,?,?,?,?)");
				
				// TODO: assign investor ID to 1st value
				pstmt.setInt(1, (int) ((System.currentTimeMillis() / 1000L) / 10000));
				pstmt.setInt(2, objInvestorComments.getPropertyId());
				pstmt.setString(3, objInvestorComments.getCity());
				pstmt.setString(4, objInvestorComments.getArea());
				pstmt.setString(5, objInvestorComments.getBuilding());
				pstmt.setString(6, objInvestorComments.getDeveloper());
				pstmt.setString(7, objInvestorComments.getComments());


				conn.setAutoCommit(true);
				int rowCount = pstmt.executeUpdate();
				if (rowCount == 1) {
					objTopSpotResponse.setCode(0);
					objTopSpotResponse.setMessage("Success");
				} else {
					objTopSpotResponse.setCode(1);
					objTopSpotResponse.setMessage("DB Server Error...");
				}
				
			} catch (Exception e) {
				//e.printStackTrace();
				objTopSpotResponse.setCode(1);
				objTopSpotResponse.setMessage(e.getMessage());
			}finally {
				ConnectionUtil.closeConnection();
			}

		} else {
			objTopSpotResponse.setCode(1);
			objTopSpotResponse.setMessage("Input was empty...");
		}
		return objTopSpotResponse;
	}
	
	public static List<Map<String, String>> getAllAreasSubAreasBuildings() {
		List<Map<String, String>> details = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "SELECT Area, Sub_Area, Building, Building_Type FROM " + DBName
						+ ".Building_Database_final BDF WHERE BDF.Latitude!=0 AND BDF.Longitude!=0";

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					details = convertToResponse(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return details;
	}

	public static List<Map<String, String>> getSaleAndRentTrendsInfo(String building,
			String bedrooms, int minPrice, int maxPrice,
			String buildingType) {
		List<Map<String, String>> details = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "SELECT bdf.*, n.Price_sqft, n.rent_sales FROM  " + DBName
						+ ".Building_Database_final bdf INNER JOIN  " + DBName
						+ ".newton n on n.Build_Area = bdf.Area OR n.Sub_Area = bdf.Sub_Area OR n.Building = bdf.Building"
						+ " WHERE  bdf.Latitude!=0 AND bdf.Longitude!=0 AND (bdf.Area = '" + building + "'"
						+ " OR bdf.Sub_Area='" + building + "'" + " OR bdf.Building='" + building + "')"
						+ " AND n.Price_sqft BETWEEN " + minPrice + " AND " + maxPrice
						+ " and bdf.Building_Type='" + buildingType + "' LIMIT 200";
		
				System.out.println(query);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					details = convertToResponse(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return details;
	}

	public static List<Map<String, String>> getLineChartDataByBuilding(
			String building) {
		List<Map<String, String>> details = new ArrayList<Map<String, String>>();
		Connection conn = null;
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {

				String query = "SELECT tran_date, Price_sqft FROM  " + DBName
						+ ".newton "
						+ "WHERE Building='" + building
						+ "' GROUP BY tran_date ORDER BY tran_date";
				System.out.println(query);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);

				if (rs != null) {
					details = convertToResponse(rs);
				}
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectionUtil.closeConnection();
		}

		return details;
	}
	
	public static List<TopspotBean> getPieChartData() {
		List<String> subAreaList = new ArrayList<String>();
		List<Integer> subAreaCountList = new ArrayList<Integer>();
		List<TopspotBean> subAreaDetails = new ArrayList<TopspotBean>();
		TopspotBean topspotBean = new TopspotBean();
		Connection conn = null;
		
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = "SELECT Sub_Area, COUNT(Sub_Area) FROM TameerClientDB.Building_Database_final  GROUP BY Sub_Area ORDER BY COUNT(Sub_Area) DESC LIMIT 10";
				System.out.println(query);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				if (rs != null) {

					while (rs.next()) {// loop to iterate resultset
						String subArea = rs.getString(1);// temp variable to hold buildng name
						Integer subAreaCount = rs.getInt(2);
						subAreaList.add(subArea);
						subAreaCountList.add(subAreaCount);
					}
					topspotBean.setAreaList(subAreaList);
					topspotBean.setAreaCountList(subAreaCountList);
					subAreaDetails.add(topspotBean);
				}	
				
			}

		} catch (Exception e) {

			e.printStackTrace();
		} 
		return subAreaDetails;
	}
	
	public static List<BuildingTrendDetails> getBuildingInfo(String reqBuilding1,String reqBuilding2,String reqBuilding3,String reqBuilding4,String reqBuilding5) {
		List<BuildingTrendDetails> buildingDetails = new ArrayList<BuildingTrendDetails>();
		Connection conn = null;
		
		String buildingType="";
		String developer="";
		String buildingStatus="";
		String building="";
		String area="";
		String noOfFloors="";
		String completionYear="";
		String usageType="";
		
		BuildingTrendDetails objBuildingTrendDetails = new BuildingTrendDetails();
		Constants objConstants = new Constants(); //for reading properties file 
		String DBName = objConstants.getValue("DBName"); //reading db name from properties file
		
		try {
			conn = ConnectionUtil.getConnection();
			if (conn != null) {
				String query = buidlingInfoQueryBuilder(reqBuilding1,reqBuilding2,reqBuilding3, reqBuilding4, reqBuilding5,DBName);
				System.out.println(query);
				
				if(query == null){
					query = ""; //to do 
				}
				Statement stmt = conn.createStatement();
				
				ResultSet rs = stmt.executeQuery(query);
				if (rs != null) {

					while (rs.next()) {// loop to iterate resultset
						buildingType=rs.getString(4);
						 developer=rs.getString(5);
						 buildingStatus=rs.getString(6);
						 building=rs.getString(7);
						 area=rs.getString(8);
						 noOfFloors= new Integer(rs.getInt(9)).toString();
						 completionYear= new Integer(rs.getInt(10)).toString();
						 usageType=rs.getString(11);
						 
							
						if(buildingType != null && buildingType != "")
							objBuildingTrendDetails.setBuilding_Type(buildingType);
						
						if(developer != null && developer != "")
							objBuildingTrendDetails.setDeveloper(developer);
						
						if(buildingStatus != null && buildingStatus != "")
							objBuildingTrendDetails.setBuildingStatus(buildingStatus);
						
						if(building != null && building != "")
							objBuildingTrendDetails.setBuilding(building);
						
						if(area != null && area != "")
							objBuildingTrendDetails.setArea(area);
						
						if(noOfFloors != null && noOfFloors != "")
							objBuildingTrendDetails.setFloors(noOfFloors);
						
						if(completionYear != null && completionYear != "")
							objBuildingTrendDetails.setCompletion(completionYear);
						
						if(usageType != null && usageType != "")
							objBuildingTrendDetails.setUsage(usageType);
					}
					
					buildingDetails.add(objBuildingTrendDetails);
				}	
				
			}

		} catch (Exception e) {

			e.printStackTrace();
		} 
		return buildingDetails;
	}
	
	
	public static String buidlingInfoQueryBuilder(String req_Building1,String req_Building2,String req_Building3,String req_Building4,String req_Building5,String DBName){
		//String lineChartBuildQuery = "SELECT Building,AVG(Price_sqft),tran_date,City,Bedrooms,Price_sqft,Build_Type,Build_Area,Sub_Area,Building,com_res,rent_sales FROM "+DBName+".newton WHERE building in('";
		int i = 0;
		StringBuilder lineChartBuildQuery = new StringBuilder("SELECT Building,Building_Type,Developer,Building_Status,Building,Area,Floors,Completion,UsageType FROM TameerClientDB.Building_Database_final as bdf WHERE Building in(");
		if(req_Building1 != null)
		{
			lineChartBuildQuery.append("'" + req_Building1 + "','");
		}else{
			i++;
		}
		if(req_Building2 != null)
		{
			lineChartBuildQuery.append( req_Building2 + "','");
		}else{
			i++;
		}
		
		if(req_Building3 != null)
		{
			lineChartBuildQuery.append( req_Building3 + "','");
		}else{
			i++;
		}
		
		if(req_Building4 != null)
		{
			lineChartBuildQuery.append( req_Building4 + "','");
		}else{
			i++;
		}
		
		if(req_Building5 != null)
		{
			lineChartBuildQuery.append(req_Building5 + "'");
		}else{
			i++;
		}
		
		lineChartBuildQuery.append( ") GROUP BY Building LIMIT 10");
			
			if(i == 5)
				lineChartBuildQuery = null;
		
		return lineChartBuildQuery.toString();
	}
}
