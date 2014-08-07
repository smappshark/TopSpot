package com.topspot.register.Dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.gson.Gson;
import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;
import com.topspot.register.beans.Building;

/**
 * 
 * @author pdudekula
 * 
 */

public class BuildingDao {
	Constants objConstants = new Constants();
	private static String DBName = "TameerClientDB";// objConstants.getValue("DBName");

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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
				build.setComments(rs.getString("AvgRent"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
			ConnectionUtil.closeConnection(conn);
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
					map.put(md.getColumnName(i), rs.getObject(i).toString());
				}
				listMap.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
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
			ConnectionUtil.closeConnection(conn);
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
		}

		return buildingList;
	}
	public static List<Building> convertToBedroomHistogramList(ResultSet rs) {
		List<Building> buildingList = new ArrayList<Building>();
		try {
			while (rs.next()) {
				Building build = new Building();
				build.setCount(rs.getInt("Count"));
				build.setPrice_AED(rs.getString("Price_AED"));
				buildingList.add(build);
			}

		} catch (Exception e) {
			e.printStackTrace();
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
			}
		}
		return null;
	}

	public static List<Building> getUniqueBedrooms() {
		Connection conn = null;
		List<Building> objBedrooms = null;
		try {
			conn = ConnectionUtil.getConnection();

			String query = "SELECT DISTINCT(Bedrooms) FROM TameerClientDB.newton WHERE Bedrooms != \"\" AND com_res LIKE \"Res%\" ORDER BY Bedrooms ASC";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			if (rs != null) {
				objBedrooms = convertToBedroomList(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return objBedrooms;
	}

	public static List<Building> getBedroomHistogram(String bedrooms) {
		List<Building> objBedrooms = null;
		if (StringUtils.isNotEmpty(bedrooms)) {
			Connection conn = null;
			try {
				conn = ConnectionUtil.getConnection();
	
				String query = "SELECT COUNT(Bedrooms) AS Count, Price_AED FROM TameerClientDB.newton WHERE Bedrooms=\"" + bedrooms + "\" GROUP BY Price_AED  Order By Price_AED ASC";
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(query);
	
				if (rs != null) {
					objBedrooms = convertToBedroomHistogramList(rs);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return objBedrooms;
	}
}
