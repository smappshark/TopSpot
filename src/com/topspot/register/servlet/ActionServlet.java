package com.topspot.register.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.google.gson.Gson;
import com.topspot.register.Dao.BuildingDao;
import com.topspot.register.beans.Building;

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
					List<Building> buildObjs = BuildingDao.getBedroomHistogram(bedrooms);
					json = new Gson().toJson(buildObjs);
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
