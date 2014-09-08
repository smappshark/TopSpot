<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>
<%@ page import="java.sql.*"%>
<%@page import="topspot.BarChartHelper"%>
<%@page import="com.topspot.sessionvalidation.UserSessionValidation"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    
</head>
   
<%


//String pieChartQuery = "SELECT Sub_Area, COUNT(Sub_Area) FROM TameerClientDB.Building_Database_final  GROUP BY Sub_Area ORDER BY COUNT(Sub_Area) DESC LIMIT 10";

ArrayList<String> selectedBuidlingNamesList = new ArrayList<String>();

String buildingTypeOne="";
String developerOne="";
String buildingStatusOne="";
String buildingOne="";
String areaOne="";
String noOfFloorsOne="";
String completionYearOne="";
String usageTypeOne ="";

String buildingTypeTwo="";
String developerTwo="";
String buildingStatusTwo="";
String buildingTwo="";
String areaTwo="";
String noOfFloorsTwo="";
String completionYearTwo="";
String usageTypeTwo ="";

String buildingTypeThree="";
String developerThree="";
String buildingStatusThree="";
String buildingThree="";
String areaThree="";
String noOfFloorsThree="";
String completionYearThree="";
String usageTypeThree ="";

String buildingFour = "";
String buildingTypeFour = "";
String areaFour = "";
String developerFour = "";
String noOfFloorsFour = "";
String buildingStatusFour = "";
String completionYearFour = "";
String usageTypeFour =  "";

String buildingFive = "";
String buildingTypeFive = "";
String areaFive = "";
String developerFive = "";
String noOfFloorsFive = "";
String buildingStatusFive = "";
String completionYearFive = "";
String usageTypeFive= "";

int listIteratorCount = 0;

String req_Building1 =null;
String erroMessage =null;

ResultSet rs = null;

if(request.getParameter("hid_Building1") != null){
req_Building1=request.getParameter("hid_Building1").trim();
selectedBuidlingNamesList.add(req_Building1);
}

String req_Building2 =null;
if(request.getParameter("hid_Building2") != null){
req_Building2=request.getParameter("hid_Building2").trim();
selectedBuidlingNamesList.add(req_Building2);
}

String req_Building3 =null;
if(request.getParameter("hid_Building3") != null){
req_Building3=request.getParameter("hid_Building3").trim();
selectedBuidlingNamesList.add(req_Building3);
}

String req_Building4 =null;
if(request.getParameter("hid_Building4") != null){
	req_Building4=request.getParameter("hid_Building4").trim();
	selectedBuidlingNamesList.add(req_Building4);
}

String req_Building5 =null;
if(request.getParameter("hid_Building5") != null){
	req_Building5=request.getParameter("hid_Building5").trim();
	selectedBuidlingNamesList.add(req_Building5);
}

String req_datepicker =null;
if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
req_datepicker=request.getParameter("hid_datepicker");

String req_datepicker1 =null;
if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
req_datepicker1=request.getParameter("hid_datepicker1");

ArrayList<Integer> colpersqftFrom=new ArrayList<Integer>();
ArrayList<Integer> colpersqftTo=new ArrayList<Integer>();
ConnectToCloudSQL objConnectToCloudSQL = new ConnectToCloudSQL();
//ArrayList<String> colBuild =objConnectToCloudSQL.getConnection();

//Iterator<String> colAreaItr=objConnectToCloudSQL.colArea.iterator();
//Iterator<String> colSubAreaItr=objConnectToCloudSQL.colSubArea.iterator();

List<BuildingTrendDetails> colBuildingTrendDetails=objConnectToCloudSQL.getLineChartData(req_Building1,req_Building2,req_Building3,req_Building4,req_Building5,req_datepicker,req_datepicker1);
String buildin1From = objConnectToCloudSQL.buildin1From;
String buildin1To = objConnectToCloudSQL.buildin1To;
String buildin2From = objConnectToCloudSQL.buildin2From;
String buildin2To = objConnectToCloudSQL.buildin2To;
String buildin3From = objConnectToCloudSQL.buildin3From;
String buildin3To = objConnectToCloudSQL.buildin3To;

Iterator<String> colItrBuildingDate = null;
java.util.ArrayList<String> colDate = objConnectToCloudSQL.colDate;
if(colDate !=null && colDate.size()> 0)
{
colItrBuildingDate = colDate.iterator();
}
Iterator<BuildingTrendDetails> colItrBuildingTrendDetails1=null;
List<String> colListBuil=new ArrayList<String>();
if(colBuildingTrendDetails != null && colBuildingTrendDetails.size() > 0)
{
	colItrBuildingTrendDetails1=colBuildingTrendDetails.iterator();
}

if(colItrBuildingTrendDetails1 !=null)
{
	while(colItrBuildingTrendDetails1.hasNext())
	{
		BuildingTrendDetails BuildingTrendDetailsobj=colItrBuildingTrendDetails1.next();
		colpersqftFrom.add((int)BuildingTrendDetailsobj.getFromPriPerSqft());
		colpersqftTo.add((int)BuildingTrendDetailsobj.getToPriPerSqft());
		colListBuil.add(BuildingTrendDetailsobj.getBuilding());
		
		if(listIteratorCount == 0){
			
			if(BuildingTrendDetailsobj.getBuilding_Type() != null && BuildingTrendDetailsobj.getBuilding_Type() != "")
			 	buildingTypeOne = BuildingTrendDetailsobj.getBuilding_Type();
			
			if(BuildingTrendDetailsobj.getDeveloper() != null && BuildingTrendDetailsobj.getDeveloper() != "")
			 	developerOne=BuildingTrendDetailsobj.getDeveloper();
			
			if(BuildingTrendDetailsobj.getBuildingStatus() != null && BuildingTrendDetailsobj.getBuildingStatus() != "")
			 	buildingStatusOne=BuildingTrendDetailsobj.getBuildingStatus();
			
			if(BuildingTrendDetailsobj.getBuilding() != null && BuildingTrendDetailsobj.getBuilding() != "")
			 	buildingOne=BuildingTrendDetailsobj.getBuilding();
			
			if(BuildingTrendDetailsobj.getArea() != null && BuildingTrendDetailsobj.getArea() != "")
				areaOne=BuildingTrendDetailsobj.getArea();
			
			if(BuildingTrendDetailsobj.getFloors() != null && BuildingTrendDetailsobj.getFloors() != "")
			 noOfFloorsOne=BuildingTrendDetailsobj.getFloors();
			
			if(BuildingTrendDetailsobj.getCompletion() != null && BuildingTrendDetailsobj.getCompletion() != "")
			 completionYearOne=BuildingTrendDetailsobj.getCompletion();
			
			if(BuildingTrendDetailsobj.getUsage() != null && BuildingTrendDetailsobj.getUsage() != "")
			 usageTypeOne =BuildingTrendDetailsobj.getUsage();
		}
	
	
		if(listIteratorCount == 1){
			if(BuildingTrendDetailsobj.getBuilding_Type() != null && BuildingTrendDetailsobj.getBuilding_Type() != "")
					buildingTypeTwo = BuildingTrendDetailsobj.getBuilding_Type();
			
			if(BuildingTrendDetailsobj.getDeveloper() != null && BuildingTrendDetailsobj.getDeveloper() != "")
					developerTwo=BuildingTrendDetailsobj.getDeveloper();
			
			if(BuildingTrendDetailsobj.getBuildingStatus() != null && BuildingTrendDetailsobj.getBuildingStatus() != "")
				buildingStatusTwo=BuildingTrendDetailsobj.getBuildingStatus();	
			
			if(BuildingTrendDetailsobj.getBuilding() != null && BuildingTrendDetailsobj.getBuilding() != "")
					buildingTwo=BuildingTrendDetailsobj.getBuilding();
			
			if(BuildingTrendDetailsobj.getArea() != null && BuildingTrendDetailsobj.getArea() != "")
					areaTwo=BuildingTrendDetailsobj.getArea();
			
			if(BuildingTrendDetailsobj.getFloors() != null && BuildingTrendDetailsobj.getFloors() != "")
				noOfFloorsTwo=BuildingTrendDetailsobj.getFloors();
			
			if(BuildingTrendDetailsobj.getCompletion() != null && BuildingTrendDetailsobj.getCompletion() != "")
			completionYearTwo=BuildingTrendDetailsobj.getCompletion();
			
			if(BuildingTrendDetailsobj.getUsage() != null && BuildingTrendDetailsobj.getUsage() != "")
				usageTypeTwo =BuildingTrendDetailsobj.getUsage();
		}

		if(listIteratorCount == 2){
			if(BuildingTrendDetailsobj.getBuilding_Type() != null && BuildingTrendDetailsobj.getBuilding_Type() != "")
				buildingTypeThree = BuildingTrendDetailsobj.getBuilding_Type();
			
			if(BuildingTrendDetailsobj.getDeveloper() != null && BuildingTrendDetailsobj.getDeveloper() != "")
				developerThree=BuildingTrendDetailsobj.getDeveloper();
			
			if(BuildingTrendDetailsobj.getBuildingStatus() != null && BuildingTrendDetailsobj.getBuildingStatus() != "")
				buildingStatusThree=BuildingTrendDetailsobj.getBuildingStatus();
			
			if(BuildingTrendDetailsobj.getBuilding() != null && BuildingTrendDetailsobj.getBuilding() != "")
				buildingThree=BuildingTrendDetailsobj.getBuilding();
			
			if(BuildingTrendDetailsobj.getArea() != null && BuildingTrendDetailsobj.getArea() != "")
				areaThree=BuildingTrendDetailsobj.getArea();
			
			if(BuildingTrendDetailsobj.getFloors() != null && BuildingTrendDetailsobj.getFloors() != "")
				noOfFloorsThree = BuildingTrendDetailsobj.getFloors();
			
			if(BuildingTrendDetailsobj.getCompletion() != null && BuildingTrendDetailsobj.getCompletion() != "")
				completionYearThree =BuildingTrendDetailsobj.getCompletion();
			
			if(BuildingTrendDetailsobj.getUsage() != null && BuildingTrendDetailsobj.getUsage() != "")
				usageTypeThree =BuildingTrendDetailsobj.getUsage();
			
		}

	
		if(listIteratorCount == 4){
			if(BuildingTrendDetailsobj.getBuilding_Type() != null && BuildingTrendDetailsobj.getBuilding_Type() != "")
				buildingTypeFive = BuildingTrendDetailsobj.getBuilding_Type();
			
			if(BuildingTrendDetailsobj.getDeveloper() != null && BuildingTrendDetailsobj.getDeveloper() != "")
				developerFive=BuildingTrendDetailsobj.getDeveloper();
			
			if(BuildingTrendDetailsobj.getBuildingStatus() != null && BuildingTrendDetailsobj.getBuildingStatus() != "")
				buildingStatusFive=BuildingTrendDetailsobj.getBuildingStatus();
			
			if(BuildingTrendDetailsobj.getBuilding() != null && BuildingTrendDetailsobj.getBuilding() != "")
				buildingFive=BuildingTrendDetailsobj.getBuilding();
			
			if(BuildingTrendDetailsobj.getArea() != null && BuildingTrendDetailsobj.getArea() != "")
				areaFive=BuildingTrendDetailsobj.getArea();
			
			if(BuildingTrendDetailsobj.getFloors() != null && BuildingTrendDetailsobj.getFloors() != "")
				noOfFloorsFive = BuildingTrendDetailsobj.getFloors();
			
			if(BuildingTrendDetailsobj.getCompletion() != null && BuildingTrendDetailsobj.getCompletion() != "")
				completionYearFive =BuildingTrendDetailsobj.getCompletion();
			
			if(BuildingTrendDetailsobj.getUsage() != null && BuildingTrendDetailsobj.getUsage() != "")
				usageTypeFive =BuildingTrendDetailsobj.getUsage();
			
		}
		
		if(listIteratorCount == 3){
			if(BuildingTrendDetailsobj.getBuilding_Type() != null && BuildingTrendDetailsobj.getBuilding_Type() != "")
				buildingFour = BuildingTrendDetailsobj.getBuilding_Type();
			
			if(BuildingTrendDetailsobj.getDeveloper() != null && BuildingTrendDetailsobj.getDeveloper() != "")
				developerFour=BuildingTrendDetailsobj.getDeveloper();
			
			if(BuildingTrendDetailsobj.getBuildingStatus() != null && BuildingTrendDetailsobj.getBuildingStatus() != "")
				buildingStatusFour=BuildingTrendDetailsobj.getBuildingStatus();
			
			if(BuildingTrendDetailsobj.getBuilding() != null && BuildingTrendDetailsobj.getBuilding() != "")
				buildingFour=BuildingTrendDetailsobj.getBuilding();
			
			if(BuildingTrendDetailsobj.getArea() != null && BuildingTrendDetailsobj.getArea() != "")
				areaFour=BuildingTrendDetailsobj.getArea();
			
			if(BuildingTrendDetailsobj.getFloors() != null && BuildingTrendDetailsobj.getFloors() != "")
				noOfFloorsFour = BuildingTrendDetailsobj.getFloors();
			
			if(BuildingTrendDetailsobj.getCompletion() != null && BuildingTrendDetailsobj.getCompletion() != "")
				completionYearFour =BuildingTrendDetailsobj.getCompletion();
			
			if(BuildingTrendDetailsobj.getUsage() != null && BuildingTrendDetailsobj.getUsage() != "")
				usageTypeFour =BuildingTrendDetailsobj.getUsage();
			
		}
		
		listIteratorCount++;
	}
}
Iterator<String> colItrBuilding = null;
if(colListBuil != null && colListBuil.size()> 0)
{
	colItrBuilding = colListBuil.iterator();
}
java.util.ArrayList<java.util.ArrayList<Integer>> colreps= new java.util.ArrayList<java.util.ArrayList<Integer>>();
if(colpersqftFrom.size()>0 && colpersqftTo.size()>0)
{
colreps.add(colpersqftFrom);
colreps.add(colpersqftTo);
}
Iterator<java.util.ArrayList<Integer>> colItrBuildingPSQFT =null;
if(colreps != null && colreps.size()>0)
{
	colItrBuildingPSQFT = colreps.iterator();
}


/* //for pie chart
Constants objConstants = new Constants(); //for reading properties file 
Connection conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
rs = conn.createStatement().executeQuery(pieChartQuery);
		
//for bar chart		
BarChartHelper objBarChartHelper= new BarChartHelper();
objBarChartHelper.getBarChartData(null,null,null,null,"index",selectedBuidlingNamesList);
java.util.ArrayList<java.util.ArrayList<Integer>> colBedroomcounts = objBarChartHelper.colBedroomcounts;
ArrayList<String> colBedRooms=objBarChartHelper.colBedRooms;
ArrayList<String> colBuildNames=objBarChartHelper.colBuildNames;
Iterator<String> colItrBuildNames =colBuildNames.iterator();
Iterator<String> colItrBedRooms =colBedRooms.iterator(); */


%>

<body>
<div class="innerLR">
                <h2 class="margin-none">Analytics &nbsp;<i class="fa fa-fw fa-pencil text-muted"></i>
                </h2>
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                       
                        <div class="subnav" id="dashboradNav">
                            <ul id="nav">
                             <%
								if(req_Building1 != null && req_Building1 != "") {
							%>
									<!--  <li onClick ="enableSearch();"><a href="#"  style="display: block;" id="buildingOne"><%=req_Building1%></a> <input id="searchBuilding" class="searchBox" type="text" onkeyup ="autoCompleteList();" placeholder="Building 1"  onblur="this.placeholder = 'Building 1'" onfocus="this.placeholder = ''" autocomplete="off" value="" /> -->
									 <li><input id="building1" type="text" value="<%=req_Building1%>" placeholder="Building 1"  onblur="this.placeholder = 'Building 1'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('1');" style="color:#000 !important;  background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingOne"></a> --> 
							<%
 								} else {
							%>
							<li><input id="building1" type="text" value="" placeholder="Building 1"  onblur="this.placeholder = 'Building 1'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('1');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/>  <!--  <a href="#" id="buildingOne">Building 1</a>-->
							<!--  <li onClick ="enableSearch();"><a href="#" style="display: block;"  id="buildingOne">Building 1</a> <input id="searchBuilding" type="text" class="searchBox"  value=""  onkeyup ="autoCompleteList();"/> -->
							
							<%
						 		}
							 %>
							
						 		<ul id="dynamicBuildingLi1" class="scrollbar ">
							 		
								</ul>
						    </li>
						      <%
								if(req_Building2 != null && req_Building2 != "") {
							%>
									<li><input id="building2" type="text" value="<%=req_Building2%>" placeholder="Building 2"  onblur="this.placeholder = 'Building 2'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('2');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/><!--  <a href="#" id="buildingTwo"></a>  -->
									<%
 								} else {
							%>
								<li><input id="building2" type="text" value="" placeholder="Building 2"  onblur="this.placeholder = 'Building 2'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('2');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!-- <a href="#" id="buildingTwo">Building 2</a> -->
								<%
						 		}
							 %>
								<ul id="dynamicBuildingLi2" class="scrollbar">
								</ul>
							</li>	
						
							 						      <%
								if(req_Building3 != null && req_Building3 != "") {
							%>
									<li><input id="building3" type="text" value="<%=req_Building3%>" placeholder="Building 3"  onblur="this.placeholder = 'Building 3'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('3');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingThree"></a>  --><%
 								} else {
							%>
								<li><input id="building3" type="text" value="" placeholder="Building 3"  onblur="this.placeholder = 'Building 3'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('3');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingThree">Building 3</a>  -->
								<%
						 		}
							 %>
							 
								<ul id="dynamicBuildingLi3" class="scrollbar">
								</ul>
							</li>
							
							 <%
								if(req_Building4 != null && req_Building4 != "") {
							%>
									<li><input id="building4" type="text" value="<%=req_Building4%>" placeholder="Building 4"  onblur="this.placeholder = 'Building 4'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('4');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingFour"></a>  -->
									<%
 								} else {
							%>
								<li><input id="building4" type="text" value="" placeholder="Building 4"  onblur="this.placeholder = 'Building 4'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('4');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingFour">Building 4</a> --><% 
						 		}
							 %>
							 
								<ul id="dynamicBuildingLi4"  class="scrollbar">
								</ul>
							</li>
							
							  <%
								if(req_Building5 != null && req_Building5 != "") {
							%>
									<li><input id="building5" type="text" value="<%=req_Building5%>" placeholder="Building 5"  onblur="this.placeholder = 'Building 5'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('5');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;"/> <!--  <a href="#" id="buildingFive"></a>  --><%
 								} else {
							%>
								<li><input id="building5" type="text" value="" placeholder="Building 5"  onblur="this.placeholder = 'Building 5'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoCompleteList('5');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px!important;width: 106px;" /> <!-- <a href="#" id="buildingFive">Building 5</a> --><%
						 		}
							 %>
							 
								<ul id="dynamicBuildingLi5"  class="scrollbar">
								</ul>
							</li>
						        <li><input type="text" id="datepicker" name="date" class="tcal" value="From date"/> </li>
                                 <li><input type="text" id="datepicker1" name="date1" class="tcal" value="To date"> </li>
                                 <li><input type ="submit" value="Show Report" name="showReport" id="showReport" onclick="drawBarChart();"/> </li>
                            </ul>
                        </div>
                        
                        <div class="subnav" id="histogramNav" style="display: none;">
                            <ul id="nav">
                           		<li><input id="histogrambuildings" type="text" value="" placeholder="Select Building"  onblur="this.placeholder = 'Select Building'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoPopulateList('histogrambuildings','selectedBedrooms',buildingArray,'dynamicHistogramBuildingLi');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 136px 10px!important;"/>
			                            <ul id="dynamicHistogramBuildingLi"  class="scrollbar">
			                            </ul>
			                         </li>
			                         
			                         <li><input id="sel_area" type="text" value="" placeholder="Select Area"  onblur="this.placeholder = 'Select Area'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoPopulateList('sel_area','selectedBedrooms',areaArray,'dynamicAreaLi');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px!important;width: 136px;"/><!-- <a href="#" id="bedroom">Select Bedroom</a> -->
			                          <ul id="dynamicAreaLi"  class="scrollbar">
	                                    </ul>
                                    </li>
                                    <li><input id="bedroom" type="text" value="" placeholder="Select Bedroom"  onblur="this.placeholder = 'Select Bedroom'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoPopulateList('bedroom','selectedBedrooms',bedroomsTypeArray,'dynamicBedroomLi');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px!important;width: 136px;"/><!-- <a href="#" id="bedroom">Select Bedroom</a> -->
			                            <ul id="dynamicBedroomLi"  class="scrollbar">
			                            </ul>
			                         </li>
                                    
		                          </ul>
                         </div>
                         
                        <div class="subnav" id="growthReturnMatrixNav" style="display: none;">
                     
                                 <ul id="nav">
                           		 <!-- <li><a href="#" id="buildings">Select Building</a> -->
                           		 <li><input id="buildings" type="text" value="" placeholder="Select Building"  onblur="this.placeholder = 'Select Building'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeyup="autoPopulateList('buildings','selectedBuildings',buildingArray,'dynamicBuildingLi');" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px!important;width: 136px;"/>
			                            <ul id="dynamicBuildingLi"  class="scrollbar">
			                            </ul>
			                         </li>
		                          </ul>
                       </div>
                       
                       <div class="subnav" id="saleAndrentTrendNav" style="display: none;">
						<ul id="nav">
							<li><input id="txtBuilding" type="text" placeholder="Select Building" onkeyup="autoPopulateList('txtBuilding','bindToTextboxBuilding',dataForFilters,'dynamicSRBuildingLi');"  onblur="this.placeholder = 'Select Building'" onfocus="this.placeholder = ''" class="textbox" autocomplete="off"  style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px!important;width: 106px;"/>
								<ul id="dynamicSRBuildingLi" class="scrollbar">
								</ul></li>
							<li> <a href="#" >Bedrooms: <span id="spanBedrooms">0</span></a>
                                <ul id="">
	                                <li><a href="#" onclick="appendToBedrooms(this)" >0</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >1</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >2</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >3</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >4</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >5</a></li>
                                </ul></li>
                                <li> Price(AED): <input type="text" size="5" id="txtPriceFrom" value="2000"/ >
                                <input type="text" id="txtPriceTo" size="5" value="200000" /></li>
                                <li><input id="txtBuildingTypes" type="text" placeholder="Select Building Type" class="textbox" style="color:#000 !important; background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px!important;" />
                                <ul id="dynamicSRBuildingTypeLi" class="scrollbar">
                                </ul></li>
                                <li> <input type="button" id="btnSearch" value="Search" />
                                </li>
						</ul>
					</div>
                        <!-- //Row -->
                        <!-- Widget -->
					<div class=" widget widget-body-white " style="width: 100%; padding-bottom:20px;" id="chartDiv">

					<div class="widget-body innerAll">
						<!-- Chart with lines and fill with no points -->
						<!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
						<!--lefttBlock strat-->
						<div class="leftBlock" id="leftBlock" style="float: left; width: 55%;">
							
							<!-- sales and rent div -->
							<!-- 	<div id="map-canvas" style="min-height: 241px; height: 450px;display: none;"></div>
									<div id="marker-tooltip" style="display: none;"></div> -->
							<!-- sales and rent div -->
							
							<!-- histogram div -->
							<div class="wrapper" id="dataContainer" style="display: none;"></div>
							<!-- histogram div -->	
							
							<!-- GROWTH RETURN MATRIX div -->
							  <%@ include file="GRTTable.jsp" %>
							<!-- GROWTH RETURN MATRIX div -->

							<!-- linechart div -->
							<div id="linechart" style="width: 400px; height: 400px;"
								class="wrapper"></div>
								<!-- linechart div -->
							
							<!-- project Infromation div -->
							<div class="row" id="projectInfromationDiv">
								<div class="tabmargin">
									<div class="tabContentSec" id="projectInformationOne">
										<h2 style="background: none;" class="asset-icon">Project
											Information Building 1</h2>
									</div>
									<div class="tabContent_data">
										<table cellpadding="5" cellspacing="0" width="100%"
											class="dataTbl">
											<tr>
												<td>Project Name</td>
												<td><%=buildingOne%></td>
												<td>Type</td>
												<td><%=buildingTypeOne%></td>
											</tr>
											<tr>
												<td>Area</td>
												<td><%=areaOne%></td>
												<td>Developer</td>
												<td><%=developerOne%></td>
											</tr>
											<tr>
												<td>No. of Floors</td>
												<td><%=noOfFloorsOne%></td>
												<td>Building Status</td>
												<td><%=buildingStatusOne%></td>
											</tr>
											<tr>
												<td>Completion Date</td>
												<td><%=completionYearOne%></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>Usage</td>
												<td><%=usageTypeOne%></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<!--tabmargin end-->
								<div class="tabmargin">
									<div class="tabContentSec" id="projectInformationTwo">
										<h2 style="background: none;" class="asset-icon">Project
											Information Building 2</h2>
									</div>
									<div class="tabContent_data">
										<table cellpadding="5" cellspacing="0" width="100%"
											class="dataTbl">
											<tr>
												<td>Project Name</td>
												<td><%=buildingTwo%></td>
												<td>Type</td>
												<td><%=buildingTypeTwo%></td>
											</tr>
											<tr>
												<td>Area</td>
												<td><%=areaTwo%></td>
												<td>Developer</td>
												<td><%=developerTwo%></td>
											</tr>
											<tr>
												<td>No. of Floors</td>
												<td><%=noOfFloorsTwo%></td>
												<td>Building Status</td>
												<td><%=buildingStatusTwo%></td>
											</tr>
											<tr>
												<td>Completion Date</td>
												<td><%=completionYearTwo%></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>Usage</td>
												<td><%=usageTypeTwo%></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<!--tabmargin end-->
								<div class="tabmargin">
									<div class="tabContentSec" id="projectInformationThree">
										<h2 style="background: none;" class="asset-icon">Project
											Information Building 3</h2>
									</div>
									<div class="tabContent_data">
										<table cellpadding="5" cellspacing="0" width="100%"
											class="dataTbl">
											<tr>
												<td>Project Name</td>
												<td><%=buildingThree%></td>
												<td>Type</td>
												<td><%=buildingTypeThree%></td>
											</tr>
											<tr>
												<td>Area</td>
												<td><%=areaThree%></td>
												<td>Developer</td>
												<td><%=developerThree%></td>
											</tr>
											<tr>
												<td>No. of Floors</td>
												<td><%=noOfFloorsThree%></td>
												<td>Building Status</td>
												<td><%=buildingStatusThree%></td>
											</tr>
											<tr>
												<td>Completion Date</td>
												<td><%=completionYearThree%></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>Usage</td>
												<td><%=usageTypeThree%></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<div class="tabmargin">
									<div class="tabContentSec" id="projectInformationFour">
										<h2 style="background: none;" class="asset-icon">Project
											Information Building 4</h2>
									</div>
									<div class="tabContent_data">
										<table cellpadding="5" cellspacing="0" width="100%"
											class="dataTbl">
											<tr>
												<td>Project Name</td>
												<td><%=buildingFour%></td>
												<td>Type</td>
												<td><%=buildingTypeFour%></td>
											</tr>
											<tr>
												<td>Area</td>
												<td><%=areaFour%></td>
												<td>Developer</td>
												<td><%=developerFour%></td>
											</tr>
											<tr>
												<td>No. of Floors</td>
												<td><%=noOfFloorsFour%></td>
												<td>Building Status</td>
												<td><%=buildingStatusFour%></td>
											</tr>
											<tr>
												<td>Completion Date</td>
												<td><%=completionYearFour%></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>Usage</td>
												<td><%=usageTypeFour%></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>

								<div class="tabmargin">
									<div class="tabContentSec" id="projectInformationFive">
										<h2 style="background: none;" class="asset-icon">Project
											Information Building 5</h2>
									</div>
									<div class="tabContent_data">
										<table cellpadding="5" cellspacing="0" width="100%"
											class="dataTbl">
											<tr>
												<td>Project Name</td>
												<td><%=buildingFive%></td>
												<td>Type</td>
												<td><%=buildingTypeFive%></td>
											</tr>
											<tr>
												<td>Area</td>
												<td><%=areaFive%></td>
												<td>Developer</td>
												<td><%=developerFive%></td>
											</tr>
											<tr>
												<td>No. of Floors</td>
												<td><%=noOfFloorsFive%></td>
												<td>Building Status</td>
												<td><%=buildingStatusFive%></td>
											</tr>
											<tr>
												<td>Completion Date</td>
												<td><%=completionYearFive%></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>Usage</td>
												<td><%=usageTypeFive%></td>
												<td></td>
												<td></td>
											</tr>
										</table>
									</div>
								</div>

							</div>
							<br />
							<!-- project Infromation div -->
							<!--tabmargin end-->
						</div>
						<!--lefttBlock end-->
						<!--rightBlock start-->
						<div class="rightBlock" id="rightBlock"
							style="float: right; width: 40%;">
							<div id="barchart" style="width: 400px; height: 400px;"
								class="wrapper"></div>
							<div id="piechart" style="width: 400px; height: 400px;"
								class="wrapper"></div>

						</div>
						<!--rightBlock end-->
					</div>
					<div style="clear: both;"></div>
				</div>
				<!-- Widget -->
						<div class=" widget widget-body-white " id="SalesAndTrendDiv"
							style=" float:left; width: 50%; min-height: 480px; display: none;">

							<div class="widget-body innerAll">
								<!-- Chart with lines and fill with no points -->
								<!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->

								<div class="leftBlock">
									<div id="map-canvas" style="min-height: 241px; height: 450px;display: none;"></div>
									<div id="marker-tooltip" style="display: none;"></div>
								</div>
							</div>
							<div style="clear: both;"></div>
						</div>
				       <div class="widget widget-body-white"  id="spanNearbyBuildingNameDiv" style="float:left; width: 50%; display: none;">
						  <h3 style="padding: 10px" id="spanNearbyBuildingName">Nearby Buildings</h3>
						  <div id="nearbyBuildings" style="height: 427px; overflow-y:auto"></div>
						</div>
						<div class="widget widget-body-white" style="float:left; width: 50%;display: none;" id="divLinechart">
						</div>
						<div class="widget widget-body-white" style="float:left; width: 50%; display:none" id="divFactSheet">
						<table frame="box" rules="all" cellpadding="3" style="width: 100%">
                                    <tr><td>Building</td><td id="tdBuilding"></td></tr>
                                    <tr><td>Area</td><td id="tdArea"></td></tr>
                                    <tr><td>Sub Area</td><td id="tdSubArea"></td></tr>
                                    <tr><td>Building Type</td><td id="tdBuildingType"></td></tr>
                                    <tr><td>Building Status</td><td id="tdBuildingStatus"></td></tr>
                                    <tr><td>Structural Material</td><td id="tdStructualMaterial"></td></tr>
                                    <tr><td>Architectural Style</td><td id="tdArchitecturalStyle"></td></tr>
                                    <tr><td>Usage</td><td id="tdUsage"></td></tr>
                                    <tr><td>Height(M)</td><td id="tdHeight"></td></tr>
                                    <tr><td>Floors</td><td id="tdFloors"></td></tr>
                                    <tr><td>Completion Date</td><td id="tdCompletionDate"></td></tr>
                                    <tr><td>Elevators</td><td id="tdElevators"></td></tr>
                                    <tr><td>Parking</td><td id="tdParking"></td></tr>
                                    <tr><td>Architect</td><td id="tdArchitect"></td></tr>
                                    <tr><td>Developer</td><td id="tdDeveloper"></td></tr>
                                    <tr><td>Contrctor</td><td id="tdContrctor"></td></tr>
                                    <tr><td>Amenities</td><td id="tdAmenities"></td></tr>
                                    <tr><td>Surrounding Amenities</td><td id="tdSurroundingAmenities"></td></tr>
                                </table>
                                <div style="clear: both;"></div>
                                </div>
						<!-- // End Widget -->
				
				<!-- // End Widget -->
			</div>
                  
                </div>
          </div>
         
<input type="hidden" name="hid_Building1" id="hid_Building1" value="<%=req_Building1%>">
<input type="hidden" name="hid_Building2" id="hid_Building2" value="<%=req_Building2%>">
<input type="hidden" name="hid_Building3" id="hid_Building3" value="<%=req_Building3%>">
<input type="hidden" name="hid_Building4" id="hid_Building4" value="<%=req_Building4%>">
<input type="hidden" name="hid_Building5" id="hid_Building5" value="<%=req_Building5%>">
<input type="hidden" name="hid_datepicker" id="hid_datepicker" value="<%=req_datepicker%>">
<input type="hidden" name="hid_datepicker1" id="hid_datepicker1" value="<%=req_datepicker1%>">
<input type="hidden" name="ddBedrooms" id="ddBedrooms">
<input type="hidden" name="ddBuildings" id="ddBuildings">
<input type="hidden" name="hid_area" id="hid_area">
<input type="hidden" name="hid_building" id="hid_building">
<input type="hidden" name="hid_bedroom" id="hid_bedroom">
<%-- <script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<!-- linechart start -->
	<script Language="JavaScript">
		var jsArr = new Array();
		google.load("visualization", "1", {
			packages : [ "corechart" ]
		});
		google.setOnLoadCallback(drawChart);
		function drawChart() {
	<%int i = 0;
			if (colreps != null && colreps.size() > 0) {
				while (colItrBuildingDate.hasNext()) {
					String dat = colItrBuildingDate.next();
					ArrayList<Integer> colnum = colreps.get(i);
					int j = 1;
					Iterator<Integer> itrnum = colnum.iterator();%>
		jsArr[<%=i%>] = new Array(); 
		jsArr[<%=i%>][0]='<%=dat%>'; 
		<%while(itrnum.hasNext())
		{ 
			int in=itrnum.next();%>
		jsArr[<%=i%>][<%=j%>]= '<%=in%>'; 
		<%j++;
		}
		i++;
	} 
}%>
if(jsArr != null && jsArr.length > 0)
{
var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
<%if(colItrBuilding != null)
{
while(colItrBuilding.hasNext())
{ 
String strb=colItrBuilding.next();%>
var valb = '<%=strb%>';
data.addColumn('number', valb); 
<%}
}%>
if(jsArr != null && jsArr.length > 0)
{
data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
var arr=jsArr[i];
for  (var j = 0; j < arr.length; j++){
	data.setCell(i,j,jsArr[i][j]);
}
}
var options = {
      title: "Buildings Price Trends",
      curveType: 'function',
      width: 500,
      height: 400,
      chartArea: {width: '50%'}
    };
var chart = new google.visualization.LineChart(document.getElementById('linechart'));
chart.draw(data, options);
}
}

  }
function onloadchanges()
{
	var pickvalue;
	<%if(req_datepicker == null || req_datepicker.equals("null") || req_datepicker.equals("From date") || req_datepicker.equals(""))
	{%>
	pickvalue ="From date";
	<%}
		else
		{%>
	pickvalue = '<%=req_datepicker%>';
	<%}%>
	
	var pickvalueTodate;
	<%if(req_datepicker1 == null || req_datepicker1.equals("null") || req_datepicker1.equals("To date") || req_datepicker1.equals("") )
	{%>
	pickvalueTodate ="To date";
	<%}
		else
		{%>
	pickvalueTodate = '<%=req_datepicker1%>';
	<%}%>
	document.getElementById("datepicker").value=pickvalue;
	document.getElementById("datepicker1").value=pickvalueTodate;
	
	//bar chart onload
	barchartonloadChnages();
	
}

	
    </script> --%>

	<!-- linechart start -->


<%-- 	<!-- piechart start -->
	<script Language="JavaScript">
 
 	 		 var jsArr = new Array();  
	      google.load("visualization", "1", {packages:["corechart"]});
	      google.setOnLoadCallback(drawChart);
	      function drawChart() {
			  <%int j = 0; while (rs.next()) { 
				  System.out.println("sub_area - "+rs.getString(1) + ": count(sub_area)" + rs.getInt(2));%>
				jsArr[<%=j%>] = new Array(); 
				jsArr[<%=j%>][0]='<%=rs.getString(1)%>'; 
				jsArr[<%=j%>][1]= '<%=rs.getInt(2)%>';
			<%j++;}%>
			//console.log(jsArr);
			var data = new google.visualization.DataTable();
				data.addColumn('string', 'SubArea Name');
				data.addColumn('number', 'Number of buildings per Area');
				data.addRows(jsArr.length);
				console.log("jsArr.length - "+jsArr.length);
				for (var i = 0; i < jsArr.length; i++) {
					console.log("i - "+ i);
					console.log("jsArr[i][0] - "+jsArr[i][0] + ": jsArr[i][1] - " + jsArr[i][1]);
					data.setCell(i, 0, jsArr[i][0]);
					data.setCell(i, 1, jsArr[i][1]);
				}
				var options = {
					title : "Top 10 Buildings per Area",
					width : 400,
					height : 400,
					is3D : true
				};
				var chart = new google.visualization.PieChart(document.getElementById('piechart'));
				chart.draw(data, options);
			}
	</script>
	<!-- piechart end -->


	<!-- barchart start -->
	<script Language="JavaScript">


function barchartonloadChnages()
{
	var pickvalue;
	<%if(req_datepicker == null || req_datepicker.equals("null") || req_datepicker.equals("From date") )
	{%>
	pickvalue ="From date";
	<%}
		else
		{%>
	pickvalue = '<%=req_datepicker%>';
	<%}%>
	
	var pickvalueTodate;
	<%if(req_datepicker1 == null || req_datepicker1.equals("null") || req_datepicker1.equals("To date") )
	{%>
	pickvalueTodate ="To date";
	<%}
		else
		{%>
	pickvalueTodate = '<%=req_datepicker1%>';
	<%}%>
	document.getElementById("datepicker").value=pickvalue;
	document.getElementById("datepicker1").value=pickvalueTodate;
}
var jsArr = new Array();  
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
	function drawChart() 
	{
		<%int k=0;
		while(colItrBuildNames.hasNext())
		{ 
			String dat=colItrBuildNames.next();
			ArrayList<Integer> colnum=colBedroomcounts.get(k);
			int l=1;
			int sizes=colnum.size();
			Iterator<Integer> itrnum= colnum.iterator();%>
	jsArr[<%=k%>] = new Array(); 
	jsArr[<%=k%>][0]='<%=dat%>'; 
	<%while(itrnum.hasNext())
			{ 
				int in=itrnum.next();%>
					jsArr[<%=k%>][<%=l%>]= '<%=in%>'; 
					<%l++;
			}
			k++;
		}%>

var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
<%while(colItrBedRooms.hasNext())
{ 
	String strb=colItrBedRooms.next();%>
	var valb = '<%=strb%>';
	data.addColumn('number', valb);
	<%}%>
		data.addRows(jsArr.length);
			for ( var i = 0; i < jsArr.length; i++) {
				var arr = jsArr[i];
				for ( var j = 0; j < arr.length; j++) {
					
					data.setCell(i, j, jsArr[i][j]);
				}
			}
			var options = {
				title : "Top 10 Buildings on Bedrooms vide",
				width : 400,
				height : 400,
				legend : {
					position : 'right',
					maxLines : 8
				},
				bar : {
					groupWidth : '75%'
				},
				isStacked : true,
			};
			var chart = new google.visualization.BarChart(document
					.getElementById('barchart'));
			chart.draw(data, options);
		}
	</script>
	<!-- barchart end -- --> --%>
</body>
</html>