package com.topspot.register.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import topspot.BarChartHelper;
import topspot.BuildingTrendDetails;
import topspot.ConnectToCloudSQL;
import topspot.TopspotBean;

import com.google.gson.Gson;
import com.topspot.register.Dao.BuildingDao;
import com.topspot.register.beans.Building;
import com.topspot.register.beans.InvestorComments;
import com.topspot.response.TopSpotResponse;
import com.topspot.sessionvalidation.UserSessionValidation;

/**
 * Servlet implementation class ActionServlet
 */

public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ActionServlet() {
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String service = request.getParameter("serviceName");

		String json = null;
		try {
			if (StringUtils.isNotEmpty(service)) {

				if (StringUtils.equals("getArea", service)) {
					json = BuildingDao.getArea();

				} else if (StringUtils.equals("getSubArea", service)) {
					String area = request.getParameter("areaName");
					json = BuildingDao.getSubAreaByArea(area);

				} else if (StringUtils.equals("getAllSubAreas", service)) {
					json = BuildingDao.getSubAllAreaByAreas();
				} else if (StringUtils.equals("getBuilding", service)) {
					String subArea = request.getParameter("subareaName");
					json = BuildingDao.getBuildingBySubArea(subArea);

				} else if (StringUtils.equals("getBuildingDetails", service)) {
					String area = request.getParameter("areaname");
					String subArea = request.getParameter("subareaName");
					String buildingName = request.getParameter("buildingName");

					List<Building> buildObjs = BuildingDao.getBuildingDetails(
							area, subArea, buildingName);
					json = new Gson().toJson(buildObjs);
				} else if (StringUtils.equals(
						"getBuildingStatusByAreaAndBuilding", service)) {
					String subArea = request.getParameter("subareaName");
					String buildingType = request.getParameter("buildingName");

					json = BuildingDao.getBuildingStatusByAreaAndBuilding(
							subArea, buildingType);
				} else if (StringUtils.equals("getBuildingMaterials", service)) {
					String subArea = request.getParameter("subareaName");
					String buildingType = request.getParameter("buildingName");
					String buildingStatus = request
							.getParameter("buildingStatus");

					json = BuildingDao.getBuildingMaterial(subArea,
							buildingType, buildingStatus);
				} else if (StringUtils.equals("getArchitecturalStyle", service)) {
					String subArea = request.getParameter("subareaName");
					String buildingType = request.getParameter("buildingName");
					String buildingStatus = request
							.getParameter("buildingStatus");
					String buildingMaterial = request
							.getParameter("buildingMaterial");

					json = BuildingDao.getArchitecturalStyle(subArea,
							buildingType, buildingStatus, buildingMaterial);
				} else if (StringUtils.equals("getFactSheetData", service)) {
					String subArea = request.getParameter("subareaName");
					String buildingType = request.getParameter("buildingName");
					String buildingStatus = request
							.getParameter("buildingStatus");
					String buildingMaterial = request
							.getParameter("buildingMaterial");
					String buildingStyle = request
							.getParameter("buildingStyle");
					StringBuilder whereClause = new StringBuilder();
					if (StringUtils.isNotEmpty(subArea)
							&& (whereClause == null || whereClause.length() == 0)) {
						whereClause.append("Sub_Area = '" + subArea + "'");
					} else {
						whereClause.append(" AND Sub_Area = '" + subArea + "'");
					}
					if (StringUtils.isNotEmpty(buildingType)
							&& (whereClause == null || whereClause.length() == 0)) {
						whereClause.append("Building_Type = '" + buildingType
								+ "'");
					} else {
						whereClause.append(" AND Building_Type = '"
								+ buildingType + "'");
					}
					if (StringUtils.isNotEmpty(buildingStatus)
							&& (whereClause == null || whereClause.length() == 0)) {
						whereClause.append("Building_Status = '"
								+ buildingStatus + "'");
					} else {
						whereClause.append(" AND Building_Status = '"
								+ buildingStatus + "'");
					}
					if (StringUtils.isNotEmpty(buildingMaterial)
							&& (whereClause == null || whereClause.length() == 0)) {
						whereClause.append("Structural_Material = '"
								+ buildingMaterial + "'");
					} else {
						whereClause.append(" AND Structural_Material = '"
								+ buildingMaterial + "'");
					}
					if (StringUtils.isNotEmpty(buildingStyle)
							&& (whereClause == null || whereClause.length() == 0)) {
						whereClause.append("Architectural_Style = '"
								+ buildingStyle + "'");
					} else {
						whereClause.append(" AND Architectural_Style = '"
								+ buildingStyle + "'");
					}
					if (whereClause != null && whereClause.length() > 0) {
						List<Building> buildObjs = BuildingDao
								.getFactSheetData(whereClause.toString());
						json = new Gson().toJson(buildObjs);
					}
				} else if (StringUtils.equals("getBuildingNames", service)) {
					json = BuildingDao.getBuildingNames();
				} else if (StringUtils.equals("getDistinctBuildingNames", service)) {
					json = BuildingDao.getDistinctBuildingNames();
				} else if (StringUtils.equals("getBuildingDetailsByName",
						service)) {
					String buildingName = request.getParameter("buildingName");
					if (StringUtils.isNotEmpty(buildingName)) {
						List<Building> buildObjs = BuildingDao
								.getBuildingDetailsByName(buildingName);
						json = new Gson().toJson(buildObjs);
					}
				} else if (StringUtils.equals("getAreaByType", service)) {
					String type = request.getParameter("type");
					json = BuildingDao.getAreaByType(type);
				} else if (StringUtils.equals("getAreaDetails", service)) {
					String type = request.getParameter("type");
					String area = request.getParameter("areaname");
					List<Map<String, String>> buildObjs = BuildingDao
							.getAreaDetails(type, area);
					json = new Gson().toJson(buildObjs);
				} else if (StringUtils.equals("getGrowthReturnMatrixReport",
						service)) {
					String buildingName = request.getParameter("buildingName");
					List<Building> buildObjs = BuildingDao
							.getGrowthReturnMatrixReport(buildingName);
					json = new Gson().toJson(buildObjs);
				} else if (StringUtils.equals("getBedrooms", service)) {
					List<Building> buildObjs = BuildingDao.getUniqueBedrooms();
					json = new Gson().toJson(buildObjs);
				} else if (StringUtils.equals("getBedroomHistogram", service)) {
					String bedrooms = request.getParameter("bedrooms");
					String selectedArea = request.getParameter("selectedArea");
					String selectedBuilding = request.getParameter("selectedBuilding");
					
					List<Building> buildObjs = BuildingDao.getBedroomHistogram(bedrooms,selectedArea,selectedBuilding);
					json = new Gson().toJson(buildObjs);
				} else if (StringUtils.equals("setInvestorComments", service)) {
					InvestorComments objInvestorComments = new InvestorComments();
					objInvestorComments.setPropertyId(Integer.parseInt(request.getParameter("propertyId")));
					objInvestorComments.setCity(request.getParameter("city"));
					objInvestorComments.setArea(request.getParameter("area"));
					objInvestorComments.setBuilding(request.getParameter("building"));
					objInvestorComments.setDeveloper(request.getParameter("developer"));
					objInvestorComments.setComments(request.getParameter("comments"));
					
					TopSpotResponse objTopSpotResponse = BuildingDao.setInvestorComments(objInvestorComments);
					json = new Gson().toJson(objTopSpotResponse);
				}else if (StringUtils.equals("getAllChartInfo", service)) {
					String req_Building1 = request.getParameter("buildingOne");
					String req_Building2 = request.getParameter("buildingTwo");
					String req_Building3 = request.getParameter("buildingThree");
					String req_Building4 = request.getParameter("buildingFour");
					String req_Building5 = request.getParameter("buildingFive");
					String req_datepicker = request.getParameter("datePickerOne");
					String req_datepicker1 = request.getParameter("datePickerTwo");
					System.out.println("req_datepicker - "+req_datepicker);
					System.out.println("req_datepicker1 - "+req_datepicker1);
					ConnectToCloudSQL objConnectToCloudSQL = new ConnectToCloudSQL();
					List<BuildingTrendDetails> colBuildingTrendDetails=objConnectToCloudSQL.getLineChartData(req_Building1,req_Building2,req_Building3,req_Building4,req_Building5,req_datepicker,req_datepicker1);

					json = new Gson().toJson(colBuildingTrendDetails);
				}  else if (StringUtils.equals("getAllAreasSubAreasBuildings", service)) {
					List<Map<String, String>> objTopSpotResponse = BuildingDao.getAllAreasSubAreasBuildings();
					json = new Gson().toJson(objTopSpotResponse);
				}else if (StringUtils.equals("getSaleAndRentTrendsData", service)) {
					String building = request.getParameter("building");
					String bedrooms = request.getParameter("bedrooms");
					int minPrice = Integer.parseInt(request.getParameter("minPrice"));
					int maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
					String buildingType = request.getParameter("buildingType");
					
					List<Map<String, String>> objTopSpotResponse = BuildingDao.getSaleAndRentTrendsInfo(building, bedrooms, minPrice, maxPrice, buildingType);
					json = new Gson().toJson(objTopSpotResponse);
				}else if (StringUtils.equals("getLineChartDataByBuilding", service)) {
					String building = request.getParameter("building");
					List<Map<String, String>> objTopSpotResponse = BuildingDao.getLineChartDataByBuilding(building);
					json = new Gson().toJson(objTopSpotResponse);
				}else if (StringUtils.equals("sessionValidation", service)) {
					Map<String, Boolean> session = new  HashMap<String, Boolean>();
					Boolean isValid = UserSessionValidation.validateUserSession(request,response);
					System.out.println("isValid - "+isValid);
					//if not session valid
					/* if (!isValid)
						response.sendRedirect("/signin.jsp");*/
					
					session.put("isSessionValid", isValid);
					
					List<Map<String, Boolean>> objTopSpotResponse = new ArrayList<Map<String,Boolean>>();
					objTopSpotResponse.add(session);
					
					json = new Gson().toJson(objTopSpotResponse);
					System.out.println("json - "+json.toString());
				}else if (StringUtils.equals("invalidateUserSession", service)) {
					Map<String, Boolean> session = new  HashMap<String, Boolean>();
					Boolean isvalid = UserSessionValidation.inValidateUserSession(request,response);
					session.put("isSessionValid", isvalid);
					List<Map<String, Boolean>> objTopSpotResponse = new ArrayList<Map<String,Boolean>>();
					objTopSpotResponse.add(session);
					json = new Gson().toJson(objTopSpotResponse);
					response.sendRedirect("/signin.jsp");
					System.out.println("json - "+json.toString());
				}else if (StringUtils.equals("getBarChartData", service)) {
					String req_Area = request.getParameter("req_Area");
					String req_SubArea = request.getParameter("req_SubArea");
					ArrayList<String> selectedBuidlingNamesList = new ArrayList<String>();
					List<TopspotBean> barChartBean =  null;
					
					String reqBuilding1 = request.getParameter("reqBuilding1");
					String reqBuilding2 = request.getParameter("reqBuilding2");
					String reqBuilding3 = request.getParameter("reqBuilding3");
					String reqBuilding4 = request.getParameter("reqBuilding4");
					String reqBuilding5 = request.getParameter("reqBuilding5");
				
					if(!reqBuilding1.equals("null") && reqBuilding1 != ""){
						selectedBuidlingNamesList.add(reqBuilding1);
					}
					if(!reqBuilding2.equals("null") && reqBuilding2 != ""){
						selectedBuidlingNamesList.add(reqBuilding2);
					}
					if(!reqBuilding2.equals("null") && reqBuilding3 != ""){
						selectedBuidlingNamesList.add(reqBuilding3);
					}
					if(!reqBuilding2.equals("null") && reqBuilding4 != ""){
						selectedBuidlingNamesList.add(reqBuilding4);
					}
					if(!reqBuilding2.equals("null") && reqBuilding5 != ""){
						selectedBuidlingNamesList.add(reqBuilding5);
					}
					
					String req_datepicker = request.getParameter("datepicker");
					String req_datepicker1 = request.getParameter("datepicker1");
					
					BarChartHelper objBarChartHelper= new BarChartHelper();
					
					if(selectedBuidlingNamesList.size() > 0)
						barChartBean = objBarChartHelper.getBarChartData(req_Area,req_SubArea,req_datepicker,req_datepicker1,selectedBuidlingNamesList);
					else
						barChartBean = objBarChartHelper.getBarChartData(req_Area,req_SubArea,req_datepicker,req_datepicker1,null);
					
					json = new Gson().toJson(barChartBean);
					
					System.out.println("json - "+json);
					//response.sendRedirect("/signin.jsp");
				}else if (StringUtils.equals("getPieChartData", service)) {
				
					List<TopspotBean> pieChartData = BuildingDao.getPieChartData();
					
					json = new Gson().toJson(pieChartData);
					System.out.println("json - "+json);
					//response.sendRedirect("/signin.jsp");
				}else if (StringUtils.equals("getBuildingInfo", service)) {
					String reqBuilding1 = request.getParameter("reqBuilding1");
					String reqBuilding2 = request.getParameter("reqBuilding2");
					String reqBuilding3 = request.getParameter("reqBuilding3");
					String reqBuilding4 = request.getParameter("reqBuilding4");
					String reqBuilding5 = request.getParameter("reqBuilding5");
					
					List<BuildingTrendDetails> buildingData = BuildingDao.getBuildingInfo(reqBuilding1,reqBuilding2,reqBuilding3,reqBuilding4,reqBuilding5);
					
					json = new Gson().toJson(buildingData);
					System.out.println("json - "+json);
					//response.sendRedirect("/signin.jsp");
				}
			}
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			
			response.getWriter().write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
