<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@page import="topspot.ValuePieChartHelper"%>
<%@page import="topspot.TopspotBean"%>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
  
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <link rel="stylesheet" href="css/topspot_style.css"/>
    <!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
    <script src="js/components/core/js/menu.js"></script>
    <!--dropdown menu end-->
    
    <!--expand div-->
    <link rel="stylesheet" href="css/style_exp.css"/>
    
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    <script type="text/javascript" src="tcal.js"></script> 
    <script type="text/javascript" src="js/piechartScripting.js"></script> 
    <script src="js/components/core/js/ddaccordion.js"></script>
    <script type="text/javascript">
	//Initialize:
	ddaccordion.init({
		headerclass: "tabContentSec", //Shared CSS class name of headers group
		contentclass: "tabContent_data", //Shared CSS class name of contents group
		revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
		mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
		collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
		defaultexpanded: [0], //index of content(s) open by default [0, 1, etc]. [] denotes no content.
		onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
		animatedefault: false, //Should contents open by default be animated into view?
		persiststate: true, //persist state of opened contents within browser session?
		toggleclass: ["closedlanguage", "openlanguage"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
		//togglehtml: ["prefix", "<img src='images/plus.png' style='width:18px; height:18px; float:left; margin-top:6px;' /> ", "<img src='images/minus.png' style='width:18px; height:18px; float:left; margin-top:6px;' />  "], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
		animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
		oninit:function(expandedindices){ //custom code to run when headers have initalized
			//do nothing
		},
		onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
			//do nothing
		}
	})
</script>
</head>
<%
		String DBName = null;
		String url = null;
		String req_Area = null;
		String req_Sub_Area = null;
		String req_Building_Type = null;
		String req_Building_Status = null;
		String req_Structural_Material = null;
		String req_Architectural_Style = null;

		if (request.getParameter("hid_Area") != null)
			req_Area = request.getParameter("hid_Area");
		/*if(request.getParameter("hid_Sub_Area") != null)
		 req_Sub_Area =request.getParameter("hid_Sub_Area");
		 */
		if (request.getParameter("hid_Building_Type") != null)
			req_Building_Type = request.getParameter("hid_Building_Type").trim();
		if (request.getParameter("hid_Building_Status") != null)
			req_Building_Status = request
					.getParameter("hid_Building_Status").trim();
		if (request.getParameter("hid_Structural_Material") != null)
			req_Structural_Material = request
					.getParameter("hid_Structural_Material").trim();
		if (request.getParameter("hid_Architectural_Style") != null)
			req_Architectural_Style = request
					.getParameter("hid_Architectural_Style").trim();

		/*
		 String req_datepicker =null;
		 if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
		 req_datepicker=request.getParameter("hid_datepicker");

		 String req_datepicker1 =null;
		 if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
		 req_datepicker1=request.getParameter("hid_datepicker1");*/

		//added by gopal on 31-07-2014
			Constants objConstants = new Constants(); //for reading properties file 
			Connection conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
			DBName = objConstants.getValue("DBName"); //reading db name from properties file

		ResultSet rs6 = conn.createStatement().executeQuery(
				"SELECT Area FROM " + DBName
						+ ".Building_Database_final group by Area");
		String ss6 = null;

		ResultSet rs1 = conn.createStatement().executeQuery(
				"SELECT Sub_Area FROM " + DBName
						+ ".Building_Database_final group by Sub_Area");
		String ss1 = null;

		ResultSet rs2 = conn
				.createStatement()
				.executeQuery(
						"SELECT Building_Type FROM "
								+ DBName
								+ ".Building_Database_final group by Building_Type");
		String ss2 = null;

		ResultSet rs3 = conn
				.createStatement()
				.executeQuery("SELECT Building_Status FROM "
								+ DBName
								+ ".Building_Database_final group by Building_Status");
		String ss3 = null;

		ResultSet rs4 = conn
				.createStatement()
				.executeQuery(
						"SELECT Structural_Material FROM "
								+ DBName
								+ ".Building_Database_final group by Structural_Material");
		String ss4 = null;

		ResultSet rs5 = conn
				.createStatement()
				.executeQuery(
						"SELECT Architectural_Style FROM "
								+ DBName
								+ ".Building_Database_final group by Architectural_Style");
		String ss5 = null;

		String strquery = "SELECT Sub_Area, COUNT(Sub_Area) FROM " + DBName
				+ ".Building_Database_final ";
		int querycount = 0;
		//		req_Sub_Area="Business Bay";
		if (req_Area != null && !req_Area.equals("null")
				&& req_Area.length() > 0 && !req_Area.equals("All")) {
			strquery = strquery + " where Area='" + req_Area + "' ";
			querycount = querycount + 1;
		}
		//	req_Sub_Area="Business Bay";
		/*	if(req_Sub_Area != null && !req_Sub_Area.equals("null") && req_Sub_Area.length() > 0 && !req_Sub_Area.equals("All") )
			{
				
				if(querycount > 0)
					strquery = strquery+" and Sub_Area='"+req_Sub_Area+"'";
						else
							strquery = strquery+" where Sub_Area='"+req_Sub_Area+"'";
					querycount=querycount+1;
			}*/

		//	req_Building_Type="High Rise";
		if (req_Building_Type != null && !req_Building_Type.equals("null")
				&& req_Building_Type.length() > 0
				&& !req_Building_Type.equals("All")) {
			if (querycount > 0)
				strquery = strquery + " and Building_Type='"
						+ req_Building_Type + "'";
			else
				strquery = strquery + " where Building_Type='"
						+ req_Building_Type + "'";
			querycount = querycount + 1;
		}
		//	req_Building_Status="Completed";
		if (req_Building_Status != null
				&& !req_Building_Status.equals("null")
				&& req_Building_Status.length() > 0
				&& !req_Building_Status.equals("All")) {
			if (querycount > 0)
				strquery = strquery + " and Building_Status='"
						+ req_Building_Status + "'";
			else
				strquery = strquery + " where Building_Status='"
						+ req_Building_Status + "'";
			querycount = querycount + 1;
		}
		//	req_Structural_Material="Concrete";
		if (req_Structural_Material != null
				&& !req_Structural_Material.equals("null")
				&& req_Structural_Material.length() > 0
				&& !req_Structural_Material.equals("All")) {
			if (querycount > 0)
				strquery = strquery + " and Structural_Material='"
						+ req_Structural_Material + "'";
			else
				strquery = strquery + " where Structural_Material='"
						+ req_Structural_Material + "'";
			querycount = querycount + 1;
		}
		System.out.println("req_Architectural_Style ---->"
				+ req_Architectural_Style);
		if (req_Architectural_Style != null
				&& !req_Architectural_Style.equals("null")
				&& req_Architectural_Style.length() > 0
				&& !req_Architectural_Style.equals("All")) {
			if (querycount > 0)
				strquery = strquery + " and Architectural_Style='"
						+ req_Architectural_Style + "'";
			else
				strquery = strquery + " where Architectural_Style='"
						+ req_Architectural_Style + "'";
			querycount = querycount + 1;
		}
		/*	if(req_datepicker != null && !req_datepicker.equalsIgnoreCase("") && !req_datepicker.equalsIgnoreCase("null") && !req_datepicker.equalsIgnoreCase("From date") && req_datepicker.length()==10)
			{
				String[] strdate=req_datepicker.split("/");
				String Fromdate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(querycount>0)
				{
					strquery = strquery + " And tran_date >= '"+Fromdate+"'";
					querycount=querycount+1;
				}
				else
				{
					strquery = strquery + " where tran_date >= '"+Fromdate+"'";
					querycount=querycount+1;
				}
			}
			if(req_datepicker1 != null && !req_datepicker1.equalsIgnoreCase("") && !req_datepicker1.equalsIgnoreCase("null") && !req_datepicker1.equalsIgnoreCase("To date") && req_datepicker1.length()==10)
			{
				String[] strdate=req_datepicker1.split("/");
				String Todate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(querycount>0)
				{
					strquery = strquery + " And tran_date <= '"+Todate+"'";
				}
				else
				{
					strquery = strquery + " where tran_date <= '"+Todate+"'";
				}
			}*/
		strquery = strquery
				+ " GROUP BY Sub_Area ORDER BY COUNT(Sub_Area) DESC LIMIT 10";
			System.out.println(strquery);
		ResultSet rs = conn.createStatement().executeQuery(strquery);
	%>
<body class="" onload="onloadchanges()">
<form action="BuildingPieChart.jsp" method="post">

   <!-- Main Container Fluid -->
    <div class="container-fluid menu-hidden">
    <!--  Side Menu -->
 		<%@ include file="includes/Menu.jsp" %>
    <!--  Side Menu -->
    
      <!-- Content -->
        <div id="content">
          <%@ include file="includes/header.jsp" %>
            <div class="innerLR">
                <h2 class="margin-none">Analytics &nbsp;<i class="fa fa-fw fa-pencil text-muted"></i>
                </h2>
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                        
                        <div class="subnav">
                       <ul id="nav">
				<!--  area start -->
				<li><a href="#" id="area">Area</a>
					<ul>
						<%
							if (rs6 != null) {
								while (rs6.next()) {
									ss6 = rs6.getString(1);
									if (ss6.equals(req_Area)) {
						%>
						<li><a href="#" onclick="selectedArea('<%=ss6%>');"><%=ss6%></a></li>
						<%
							} else {
						%>
						<li><a href="#" onclick="selectedArea('<%=ss6%>');"><%=ss6%></a></li>
						<%
							}
								}
							}
						%>
					</ul></li>
				<!--  area end -->

				<!--  Building type start -->
				<li><a href="#" id="sel_Building_Type">Building Type</a>
					<ul>
						<%
							if (rs2 != null) {
								while (rs2.next()) {
									ss2 = rs2.getString(1);
									if (ss2.equals(req_Building_Type)) {
						%>
						<li><a href="#"
							onclick="selectedBuildingType('  <%=ss2%>  ');"><%=ss2%></a></li>
						<%
							} else {
						%>
						<li><a href="#"
							onclick="selectedBuildingType('  <%=ss2%>  ');"><%=ss2%></a>
						</li>
						<%
							}
								}
							}
						%>
					</ul></li>
				<!--  Building type end -->

				<!--  Building Status start -->
				<li><a href="#" id="sel_Building_Status">Building
						Status</a>
					<ul>
						<%
							if (rs3 != null) {
								while (rs3.next()) {
									ss3 = rs3.getString(1);
									if (ss3.equals(req_Building_Status)) {
						%>
						<li><a href="#"
							onclick="selectedBuildingStatus(' <%=ss3%> ');"><%=ss3%></a></li>
						<%
							} else {
						%>
						<li><a href="#"
							onclick="selectedBuildingStatus(' <%=ss3%> ');"><%=ss3%></a>
						</li>
						<%
							}
								}
							}
						%>
					</ul></li>
				<!--  Building Status end -->

				<!--  Structural Material start -->
				<li><a href="#" id="sel_Structural_Material">Structural
						Material</a>
					<ul>
						<%
							if (rs4 != null) {
								while (rs4.next()) {
									ss4 = rs4.getString(1);
									if (ss4.equals(req_Structural_Material)) {
						%>
						<li><a href="#"
							onclick="selectedStructuralMaterial(' <%=ss4%> ');"><%=ss4%></a></li>
						<%
							} else {
						%>
						<li><a href="#"
							onclick="selectedStructuralMaterial(' <%=ss4%> ');"><%=ss4%></a>
						</li>
						<%
							}
								}
							}
						%>
					</ul></li>
				<!--  Structural Material end -->
				<!--  Architectural Style start -->
				<li><a href="#" id="sel_Architectural_Style">Architectural	Style</a>
					<ul>
						<%
							if (rs5 != null) {
								while (rs5.next()) {
									ss5 = rs5.getString(1);
									if (ss5.equals(req_Architectural_Style)) {
						%>
						<li><a href="#"
							onclick="selectedArchitecturalStyle(' <%=ss5%> ');"><%=ss5%></a></li>
						<%
							} else {
						%>
						<li><a href="#"
							onclick="selectedArchitecturalStyle(' <%=ss5%> ');"><%=ss5%></a>
						</li>
						<%
							}
								}
							}
						%>
					</ul></li>
				<!--  Architectural Style dropdown end -->

				<li><input type ="submit" value="Show Report" name="B1"/> </li>
                       </ul>
                        </div>
                        <!-- //Row -->
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                           
                            <div class="widget-body innerAll">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock">
								<div id="piechart" style="width: 900px; height: 500px;"	class="wrapper"></div>
							</div>
                            </div>
                        </div>
                      
                       
                        </div>
                        <!-- // End Widget -->
                    
                    </div>
                  
                </div>
            </div>
        </div>
        <!-- // Content END -->
         <div class="clearfix"></div>
            <!--  Side Menu -->
    <%@ include file="includes/footer.jsp" %>
    <!--  Side Menu -->
        </div>
    <input type="hidden" name="hid_Area" id="hid_Area"> 
    <input type="hidden" name="hid_Building_Type" id="hid_Building_Type">
	<input type="hidden" name="hid_Building_Status"	id="hid_Building_Status"> 
	<input type="hidden" name="hid_Structural_Material" id="hid_Structural_Material">
	<input type="hidden" name="hid_Architectural_Style"	id="hid_Architectural_Style"> 
	<input type="hidden" name="hid_datepicker" id="hid_datepicker"> 
	<input type="hidden" name="hid_datepicker1" id="hid_datepicker1">
      	<script type="text/javascript" src="https://www.google.com/jsapi"></script> 
												<script Language="JavaScript">


												  var jsArr = new Array();  
											      google.load("visualization", "1", {packages:["corechart"]});
											      google.setOnLoadCallback(drawChart);
											      function drawChart() {
													  <%int i = 0; while (rs.next()) { System.out.println(rs.getString(1) + ": " + rs.getInt(2));%>
														jsArr[<%=i%>] = new Array(); 
														jsArr[<%=i%>][0]='<%=rs.getString(1)%>'; 
														jsArr[<%=i%>][1]= '<%=rs.getInt(2)%>';
													<%i++;}%>
													console.log(jsArr);
													var data = new google.visualization.DataTable();
														data.addColumn('string', 'SubArea Name');
														data.addColumn('number', 'Number of buildings per Area');
														data.addRows(jsArr.length);
														for (var i = 0; i < jsArr.length; i++) {
															data.setCell(i, 0, jsArr[i][0]);
															data.setCell(i, 1, jsArr[i][1]);
														}
														var options = {
															title : "Top 10 Buildings per Area",
															width : 600,
															height : 400,
															is3D : true
														};
														var chart = new google.visualization.PieChart(document.getElementById('piechart'));
														chart.draw(data, options);
													}

													
												</script>

        
         <!-- Global -->
   	 <script data-id="App.Config">
	    var App = {};
	    var basePath = '',
	        commonPath = 'js',
	        rootPath = '/',
	        DEV = false,
	        componentsPath = 'js/components/';
	    var primaryColor = '#3695d5',
	        dangerColor = '#b55151',
	        successColor = '#609450',
	        infoColor = '#4a8bc2',
	        warningColor = '#ab7a4b',
	        inverseColor = '#45484d';
	    var themerPrimaryColor = primaryColor;
    </script>
    	
    <script src="js/components/library/bootstrap/js/bootstrap.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/nicescroll/jquery.nicescroll.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/breakpoints/breakpoints.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/preload/pace/pace.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/preload/pace/preload.pace.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/core/js/animations.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.resize.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/plugins/jquery.flot.tooltip.min.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotcharts.common.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-line-2.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-mixed-1.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-bars-horizontal.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/easy-pie/assets/lib/js/jquery.easy-pie-chart.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/easy-pie/assets/custom/easy-pie.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/sparkline/jquery.sparkline.min.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/charts/sparkline/sparkline.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/modules/admin/maps/vector/assets/lib/jquery-jvectormap-1.2.2.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/maps/vector/assets/lib/maps/jquery-jvectormap-world-mill-en.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/maps/vector/assets/custom/maps-vector.world-map-markers.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/core/js/sidebar.main.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/core/js/sidebar.discover.init.js?v=v1.0.3-rc2"></script>
    <script src="js/components/core/js/core.init.js?v=v1.0.3-rc2"></script>
    </form>
</body>
</html>