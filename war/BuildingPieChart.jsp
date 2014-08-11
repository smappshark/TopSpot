<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>
<%@page import="topspot.ValuePieChartHelper"%>
<%@page import="topspot.TopspotBean"%>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>

<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Topspot</title>
<script type='text/javascript' src='js/jquery-1.2.3.min.js'></script>
<script type='text/javascript' src='js/menu.js'></script>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<link rel="stylesheet" href="css/style_exp.css" type="text/css" />
<!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
<script type="text/javascript" src="js/ddaccordion.js"></script>
<link rel="stylesheet" type="text/css" href="tcal.css" />
<script type="text/javascript" src="tcal.js"></script>

<script type="text/javascript">
//Initialize 2nd demo:
ddaccordion.init({
	headerclass: "tabContentSec", //Shared CSS class name of headers group
	contentclass: "tabContent_data", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: false, //Collapse previous content (so only one open at any time)? true/false 
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

<body onload="onloadchanges()">
	<%
		String DBName = null;
		String url = null;
		/*if (SystemProperty.environment.value() ==
		 SystemProperty.Environment.Value.Production) {
		 // Load the class that provides the new "jdbc:google:mysql://" prefix.
		 Class.forName("com.mysql.jdbc.GoogleDriver");
		 url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
		 } else {*/
		// Local MySQL instance to use during development.
		// Class.forName("com.mysql.jdbc.Driver");
		//  url = "jdbc:mysql://192.168.10.192:3306/topspot?user=root";

		//}
		
		//commenetd by gopal on 31-07-2014
		//Class.forName("com.mysql.jdbc.Driver");
		//url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";
		//commenetd by gopal on 31-07-2014
		
		//Class.forName("com.mysql.jdbc.GoogleDriver");
        //url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
         
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
			req_Building_Type = request.getParameter("hid_Building_Type");
		if (request.getParameter("hid_Building_Status") != null)
			req_Building_Status = request
					.getParameter("hid_Building_Status");
		if (request.getParameter("hid_Structural_Material") != null)
			req_Structural_Material = request
					.getParameter("hid_Structural_Material");
		if (request.getParameter("hid_Architectural_Style") != null)
			req_Architectural_Style = request
					.getParameter("hid_Architectural_Style");

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
				.executeQuery(
						"SELECT Building_Status FROM "
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

	<form action="BuildingPieChart.jsp" method="post"
		onsubmit="checkForm();">
		<div class="nav-wrap">
			<div class="nav">
				<ul>
					<li><a href="#">Charts</a></li>
					<li><a href="buildMap.jsp">Maps</a></li>
					<li><a href="#">Histogram</a></li>
					<li><a href="#">Scatter Charts</a></li>
					<li><a href="#">Mash Charts</a></li>
					<li><a href="signin.jsp">SignIn</a></li>
				</ul>
			</div>
		</div>
		<div class="main">
			<div class="header">
				<div class="logo">
					<img src="images/topspot-logo.png" />
				</div>
			</div>
			<div class="container">
				<div class="searchbg">
					<table width="100%">
						<tr>
							<td align="center">Area</td>
							<td align="center">Property Type</td>
							<td align="center">Building Status</td>
							<td align="center">Structural Material</td>
							<td align="center">Architectural Style</td>
							<td></td>
						</tr>
						<tr>
							<td nowrap><select name="sel_Area" id="sel_Area">
									<%
										if (req_Area == null || req_Area.equals("null")
												|| req_Area.equals("All")) {
									%>
									<option value="All" selected><center>Area</center>
									</option>
									<%
										} else {
									%>
									<option value="All"><center>Area</center>
									</option>
									<%
										}
										while (rs6.next()) {
											ss6 = rs6.getString(1);
											if (ss6.equals(req_Area)) {
									%>
									<option value="<%=ss6%>" selected><%=ss6%></option>
									<%
										} else {
									%>
									<option value="<%=ss6%>"><%=ss6%></option>
									<%
										}
										}
									%>
							</select></td>

							<td nowrap><select name="sel_Building_Type"
								id="sel_Building_Type">
									<%
										if (req_Building_Type == null || req_Building_Type.equals("null")
												|| req_Building_Type.equals("All")) {
									%>
									<option value="All" selected>Building Type</option>
									<%
										} else {
									%>
									<option value="All">Building Type</option>
									<%
										}
										while (rs2.next()) {
											ss2 = rs2.getString(1);
											if (ss2.equals(req_Building_Type)) {
									%>
									<option value="<%=ss2%>" selected><%=ss2%></option>
									<%
										} else {
									%>
									<option value="<%=ss2%>"><%=ss2%></option>
									<%
										}
										}
									%>
							</select></td>
							<td nowrap><select name="sel_Building_Status"
								id="sel_Building_Status">
									<%
										if (req_Building_Status == null
												|| req_Building_Status.equals("null")
												|| req_Building_Status.equals("All")) {
									%>
									<option value="All" selected>Building Status</option>
									<%
										} else {
									%>
									<option value="All">Building Status</option>
									<%
										}
										while (rs3.next()) {
											ss3 = rs3.getString(1);
											if (ss3.equals(req_Building_Status)) {
									%>
									<option value="<%=ss3%>" selected><%=ss3%></option>
									<%
										} else {
									%>
									<option value="<%=ss3%>"><%=ss3%></option>
									<%
										}
										}
									%>
							</select></td>
							<td nowrap><select name="sel_Structural_Material"
								id="sel_Structural_Material">
									<%
										if (req_Structural_Material == null
												|| req_Structural_Material.equals("null")
												|| req_Structural_Material.equals("All")) {
									%>
									<option value="All" selected>Structural Material</option>
									<%
										} else {
									%>
									<option value="All">Structural Material</option>
									<%
										}
										while (rs4.next()) {
											ss4 = rs4.getString(1);
											if (ss4.equals(req_Structural_Material)) {
									%>
									<option value="<%=ss4%>" selected><%=ss4%></option>
									<%
										} else {
									%>
									<option value="<%=ss4%>"><%=ss4%></option>
									<%
										}
										}
									%>
							</select></td>
							<td nowrap><select name="sel_Architectural_Style"
								id="sel_Architectural_Style">
									<%
										if (req_Architectural_Style == null
												|| req_Architectural_Style.equals("null")
												|| req_Architectural_Style.equals("All")) {
									%>
									<option value="All" selected>Architectural Style</option>
									<%
										} else {
									%>
									<option value="All">Architectural Style</option>
									<%
										}
										while (rs5.next()) {
											ss5 = rs5.getString(1);
											if (ss5.equals(req_Architectural_Style)) {
									%>
									<option value="<%=ss5%>" selected><%=ss5%></option>
									<%
										} else {
									%>
									<option value="<%=ss5%>"><%=ss5%></option>
									<%
										}
										}
									%>
							</select></td>
							<td align='center' valign='middle'><input type="submit"
								value="Show Report" name="B1"></td>
						</tr>
					</table>
				</div>
				<input type="hidden" name="hid_Area" id="hid_Area"> <input
					type="hidden" name="hid_Building_Type" id="hid_Building_Type">
						<input type="hidden" name="hid_Building_Status"
						id="hid_Building_Status"> <input type="hidden"
							name="hid_Structural_Material" id="hid_Structural_Material">
								<input type="hidden" name="hid_Architectural_Style"
								id="hid_Architectural_Style"> <input type="hidden"
									name="hid_datepicker" id="hid_datepicker"> <input
										type="hidden" name="hid_datepicker1" id="hid_datepicker1">
											<script type="text/javascript"
												src="https://www.google.com/jsapi"></script> 
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

													function checkForm() {

														var e6 = document.getElementById("sel_Area");
														var strselArea = e6.options[e6.selectedIndex].value;
														document.getElementById("hid_Area").value = strselArea;
														/*      	
														var e1 = document.getElementById("sel_Sub_Area");
														var strselSubArea = e1.options[e1.selectedIndex].value;
														document.getElementById("hid_Sub_Area").value =strselSubArea;
														 */

														var e2 = document.getElementById("sel_Building_Type");
														var strselBuildingType = e2.options[e2.selectedIndex].value;
														document.getElementById("hid_Building_Type").value = strselBuildingType;

														var e3 = document.getElementById("sel_Building_Status");
														var strselBuildingStatus = e3.options[e3.selectedIndex].value;
														document.getElementById("hid_Building_Status").value = strselBuildingStatus;

														var e4 = document.getElementById("sel_Structural_Material");
														var selStructuralMaterial = e4.options[e4.selectedIndex].value;
														document.getElementById("hid_Structural_Material").value = selStructuralMaterial;

														var e5 = document.getElementById("sel_Architectural_Style");
														var strselArchitecturalStyle = e5.options[e5.selectedIndex].value;
														document.getElementById("hid_Architectural_Style").value = strselArchitecturalStyle;

													}
												</script>


											<div class="leftBlock">
												<ul>
													<li><a href="BuildingPieChart.jsp">Pie Charts by
															count</a></li>
													<li><a href="BuildingByValuePieChart.jsp">Pie
															Charts by value</a></li>
													<li><a href="PopularBuildingsBarChart.jsp">Bar
															Charts</a></li>
													<li><a href="LineChart.jsp">Line Charts</a></li>
													<li><a href="BuildingScatterChart.jsp">Scatter
															Charts</a></li>
												</ul>
											</div>
											<div class="rightBlock">
												<div id="piechart" style="width: 900px; height: 500px;"
													class="wrapper"></div>
											</div>
			</div>
		</div>
		<!--main end-->
		<div class="footer-wrap">
			<div class="footer">
				<p style="color: #e51737; padding: 5px;">For Sale, For Rent, For
					Investment, For Advise</p>
				<p style="color: #052f6e;">Call Top Spot Tel: +971 4 430 6228 /
					Fax: +971 4 430 6229 info@topspot.ae / Visit us at Regal Tower,
					Business Bay, Dubai, United Arab Emirates</p>
			</div>
		</div>
	</form>
</body>
</html>
