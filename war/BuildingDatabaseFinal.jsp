<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TopSpot</title>
<script type='text/javascript' src='js/jquery-1.2.3.min.js'></script>
<script type='text/javascript' src='js/menu.js'></script>
<link rel="stylesheet" href="css/style.css" type="text/css"/>

<!--expand div-->
<link rel="stylesheet" href="css/style_exp.css" type="text/css"/>
<!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
<script type="text/javascript" src="js/ddaccordion.js"></script>
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
<!--expand div end-->

</head>
  <body>

<%
String url = null;
/*if (SystemProperty.environment.value() ==
    SystemProperty.Environment.Value.Production) {
  // Load the class that provides the new "jdbc:google:mysql://" prefix.
  Class.forName("com.mysql.jdbc.GoogleDriver");
  url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
} else {*/
  // Local MySQL instance to use during development.
/*   Class.forName("com.mysql.jdbc.Driver");
  url = "jdbc:mysql://127.0.0.1:3306/TameerClientDB?user=root"; */
  
  //Class.forName("com.mysql.jdbc.Driver");
  //url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";
  
//commented on 01-08-2014 by gopal
			/*Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			DBName = "TameerClientDB";*/
			//commented on 01-08-2014 by gopal
        
  //DBName = "TameerClientDB";
  
//}
String req_Sub_Area =null;
String req_Building_Type =null;
String req_Building_Status =null;
String req_Structural_Material =null;
String req_Architectural_Style =null;
String req_UsageType =null;
String DBName =null;

if(request.getParameter("hid_Sub_Area") != null)
req_Sub_Area =request.getParameter("hid_Sub_Area");
if(request.getParameter("hid_Building_Type") != null)
req_Building_Type = request.getParameter("hid_Building_Type");
if(request.getParameter("hid_Building_Status") != null)
req_Building_Status =request.getParameter("hid_Building_Status");
if(request.getParameter("hid_Structural_Material") != null)
req_Structural_Material =request.getParameter("hid_Structural_Material");
if(request.getParameter("hid_Architectural_Style") != null)
req_Architectural_Style =request.getParameter("hid_Architectural_Style");

if(request.getParameter("hid_UsageType") != null)
req_UsageType =request.getParameter("hid_UsageType");



//commenetd by gopal on 31-07-2014
//Connection conn = DriverManager.getConnection(url);
//commenetd by gopal on 31-07-2014

//added by gopal on 31-07-2014
Constants objConstants = new Constants(); //for reading properties file 
Connection conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
DBName = objConstants.getValue("DBName"); //reading db name from properties file
		
ResultSet rs1 = conn.createStatement().executeQuery(
    "SELECT Sub_Area FROM "+DBName+".Building_Database_final group by Sub_Area");
	String ss1=null;

	ResultSet rs2 = conn.createStatement().executeQuery(
    "SELECT Building_Type FROM "+DBName+".Building_Database_final group by Building_Type");
	String ss2=null;

	ResultSet rs3 = conn.createStatement().executeQuery(
    "SELECT Building_Status FROM "+DBName+".Building_Database_final group by Building_Status");
	String ss3=null;

	ResultSet rs4 = conn.createStatement().executeQuery(
    "SELECT Structural_Material FROM "+DBName+".Building_Database_final group by Structural_Material");
	String ss4=null;

	ResultSet rs5 = conn.createStatement().executeQuery(
    "SELECT Architectural_Style FROM "+DBName+".Building_Database_final group by Architectural_Style");
	String ss5=null;

	ResultSet rs6 = conn.createStatement().executeQuery(
    "SELECT UsageType FROM "+DBName+".Building_Database_final group by UsageType");
	String ss6=null;
	
%>
<div class="wrapper">
		<h1>Agent Dashboard</h1>
<form action="BuildingDatabaseFinal.jsp" method="post" onsubmit="checkForm();">
<table style="border-collapse:collapse" border="0">
<tr>
	<td>
		<nav>
        	<ul>
            	<li><a href="BuildingPieChart.jsp">Pie Chart By Count</a></li> 
                <li><a href="BuildingByValuePieChart.jsp">Pie Chart By Value</a></li> 
                <li><a href="PopularBuildingsBarChart.jsp">Bar Chart</a></li> 
                <li><a href="BuildingScatterChart.jsp">Scatter Chart</a></li> 
                <li><a href="LineChart.jsp">Line Chart</a></li> 
                <li><a href="BuildingDatabaseFinal.jsp">Building Analysis</a></li>
            </ul>
        </nav>
</td></tr>
<tr><td>
<table style="border-collapse:collapse" border="0" align="center">
<tr>
	<td nowrap>
		<select name="sel_Sub_Area" id="sel_Sub_Area">
		<%
			if(req_Sub_Area == null || req_Sub_Area.equals("null") || req_Sub_Area.equals("All") )
			{
		%>
		<option value="All" selected>Sub Area</option>
		<%
			}
		else
		{
			%>
			<option value="All">Sub Area</option>
			<%
		}
		while(rs1.next())
			{
				ss1= rs1.getString(1);
				if(ss1.equals(req_Sub_Area))
				{
			%>
			<option value= "<%= ss1 %>" selected><%=ss1 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss1 %>" ><%=ss1 %></option> 
		<%
				}
			}							
		%>
</select> 
	</td>
		<td nowrap>
		<select name="sel_Building_Type" id="sel_Building_Type">
		<%
		if(req_Building_Type == null || req_Building_Type.equals("null") || req_Building_Type.equals("All"))
			{
		%>
		<option value="All" selected>Building Type</option>
		<%
			}
		else
		{
			%>
			<option value="All">Building Type</option>
			<%
		}
		while(rs2.next())
			{
				ss2= rs2.getString(1);
				if(ss2.equals(req_Building_Type))
				{
			%>
			<option value= "<%= ss2 %>" selected><%=ss2 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss2 %>" ><%=ss2 %></option> 
		<%
				}
				}							
		%>
</select> 
	</td>
	<td nowrap>
		<select name="sel_Building_Status" id="sel_Building_Status">
		<%
			if(req_Building_Status == null || req_Building_Status.equals("null")  || req_Building_Status.equals("All"))
			{
		%>
		<option value="All" selected>Building Status</option>
		<%
			}
		else
		{
			%>
			<option value="All">Building Status</option>
			<%
		}
		while(rs3.next())
			{
				ss3= rs3.getString(1);
				if(ss3.equals(req_Building_Status))
				{
			%>
			<option value= "<%= ss3 %>" selected><%=ss3 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss3 %>" ><%=ss3 %></option> 
		<%
				}
				}							
		%>
</select> 
	</td>
	<td nowrap>
		<select name="sel_Structural_Material" id="sel_Structural_Material">
		<%
			if(req_Structural_Material == null || req_Structural_Material.equals("null") || req_Structural_Material.equals("All"))
			{
		%>
		<option value="All" selected>Structural Material</option>
		<%
			}
		else
		{
			%>
			<option value="All">Structural Material</option>
			<%
		}
		while(rs4.next())
			{
				ss4= rs4.getString(1);
				if(ss4.equals(req_Structural_Material))
				{
			%>
			<option value= "<%= ss4 %>" selected><%=ss4 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss4 %>" ><%=ss4%></option> 
		<%
				}
				}							
		%>
</select> 
	</td>
	<td nowrap>
		<select name="sel_Architectural_Style" id="sel_Architectural_Style">
		<%
			if(req_Architectural_Style == null || req_Architectural_Style.equals("null")  || req_Architectural_Style.equals("All"))
			{
		%>
		<option value="All" selected>Architectural Style</option>
		<%
			}
		else
		{
			%>
			<option value="All">Architectural Style</option>
			<%
		}
		while(rs5.next())
			{
				ss5= rs5.getString(1);
				if(ss5.equals(req_Architectural_Style))
				{
			%>
			<option value= "<%= ss5 %>" selected><%=ss5 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss5%>" ><%=ss5 %></option> 
		<%
				}
				}							
		%>
</select> 
	</td>

<td nowrap>
		<select name="sel_UsageType" id="sel_UsageType">
		<%
			if(req_UsageType == null || req_UsageType.equals("null")  || req_UsageType.equals("All"))
			{
		%>
		<option value="All" selected>Usage Type</option>
		<%
			}
		else
		{
			%>
			<option value="All">Usage Type</option>
			<%
		}
		while(rs6.next())
			{
				ss6= rs6.getString(1);
				if(ss6.equals(req_UsageType))
				{
			%>
			<option value= "<%= ss6 %>" selected><%=ss6 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss6%>" ><%=ss6 %></option> 
		<%
				}
				}							
		%>
</select> 
	</td>
	
</tr>
</table>
</td>
</tr>
<script Language="JavaScript">
        function checkForm() {
var e1 = document.getElementById("sel_Sub_Area");
var strselSubArea = e1.options[e1.selectedIndex].value;
document.getElementById("hid_Sub_Area").value =strselSubArea;

var e2 = document.getElementById("sel_Building_Type");
var strselBuildingType = e2.options[e2.selectedIndex].value;
document.getElementById("hid_Building_Type").value =strselBuildingType;

var e3 = document.getElementById("sel_Building_Status");
var strselBuildingStatus = e3.options[e3.selectedIndex].value;
document.getElementById("hid_Building_Status").value =strselBuildingStatus;

var e4 = document.getElementById("sel_Structural_Material");
var selStructuralMaterial = e4.options[e4.selectedIndex].value;
document.getElementById("hid_Structural_Material").value =selStructuralMaterial;

var e5 = document.getElementById("sel_Architectural_Style");
var strselArchitecturalStyle = e5.options[e5.selectedIndex].value;
document.getElementById("hid_Architectural_Style").value =strselArchitecturalStyle;

var e6 = document.getElementById("sel_UsageType");
var strselUsageType = e6.options[e6.selectedIndex].value;
document.getElementById("hid_UsageType").value =strselUsageType;


        }
    </script>
<tr height='50px'>
	<td align='center' valign='center'>
		<%
		String strquery="SELECT Sub_Area,Building,Building_Type,Building_Status,Structural_Material,Architectural_Style,Foundation,UsageType,Height,Floors,Latitude,Longitude From Building_Database_final";
		int querycount=0;
	//	req_Sub_Area="Business Bay";
		if(req_Sub_Area != null && !req_Sub_Area.equals("null") && req_Sub_Area.length() > 0 && !req_Sub_Area.equals("All") )
		{
			strquery = strquery+" where Sub_Area='"+req_Sub_Area+"'";
			querycount=querycount+1;
		}
	//	req_Building_Type="High Rise";
		if(req_Building_Type != null && !req_Building_Type.equals("null") && req_Building_Type.length() > 0 && !req_Building_Type.equals("All") )
		{
				if(querycount > 0)
			strquery = strquery+" and Building_Type='"+req_Building_Type+"'";
				else
					strquery = strquery+" where Building_Type='"+req_Building_Type+"'";
			querycount=querycount+1;
		}
	//	req_Building_Status="Completed";
		if(req_Building_Status != null && !req_Building_Status.equals("null") && req_Building_Status.length() > 0 && !req_Building_Status.equals("All"))
		{
				if(querycount > 0)
			strquery = strquery+" and Building_Status='"+req_Building_Status+"'";
				else
					strquery = strquery+" where Building_Status='"+req_Building_Status+"'";
			querycount=querycount+1;
		}
	//	req_Structural_Material="Concrete";
		if(req_Structural_Material != null && !req_Structural_Material.equals("null") && req_Structural_Material.length() > 0  && !req_Structural_Material.equals("All"))
		{
				if(querycount > 0)
			strquery = strquery+" and Structural_Material='"+req_Structural_Material+"'";
				else
					strquery = strquery+" where Structural_Material='"+req_Structural_Material+"'";
			querycount=querycount+1;
		}
		if(req_Architectural_Style != null && !req_Architectural_Style.equals("null") && req_Architectural_Style.length() > 0  && !req_Architectural_Style.equals("All"))
		{
				if(querycount > 0)
			strquery = strquery+" and Architectural_Style='"+req_Architectural_Style+"'";
				else
					strquery = strquery+" where Architectural_Style='"+req_Architectural_Style+"'";
		}

		if(req_UsageType != null && !req_UsageType.equals("null") && req_UsageType.length() > 0  && !req_UsageType.equals("All"))
		{
				if(querycount > 0)
			strquery = strquery+" and UsageType='"+req_UsageType+"'";
				else
					strquery = strquery+" where UsageType='"+req_UsageType+"'";
		}

		
ResultSet rs = conn.createStatement().executeQuery(strquery);
%>
<input type ="submit" value="Show Report" name="B1">
<input type="hidden" name="hid_Sub_Area" id="hid_Sub_Area">
<input type="hidden" name="hid_Building_Type" id="hid_Building_Type">
<input type="hidden" name="hid_Building_Status" id="hid_Building_Status">
<input type="hidden" name="hid_Structural_Material" id="hid_Structural_Material">
<input type="hidden" name="hid_Architectural_Style" id="hid_Architectural_Style">
<input type="hidden" name="hid_UsageType" id="hid_UsageType">
</td></tr>

<tr>
<td>
<table style="border-collapse:collapse" border="1" bordercolor='lightblue'>
<tbody>
<tr>
<th style="background-color: #CCFFCC; margin: 5px">Sub_Area</th>
<th style="background-color: #CCFFCC; margin: 5px">Building</th>
<th style="background-color: #CCFFCC; margin: 5px">Building_Type</th>
<th style="background-color: #CCFFCC; margin: 5px">Building_Status</th>
<th style="background-color: #CCFFCC; margin: 5px">Structural_Material</th>
<th style="background-color: #CCFFCC; margin: 5px">Architectural_Style</th>
<th style="background-color: #CCFFCC; margin: 5px">Foundation</th>
<th style="background-color: #CCFFCC; margin: 5px">Usage</th>
<th style="background-color: #CCFFCC; margin: 5px">Height</th>
<th style="background-color: #CCFFCC; margin: 5px">Floors</th>
<th style="background-color: #CCFFCC; margin: 5px">Latitude</th>
<th style="background-color: #CCFFCC; margin: 5px">Longitude</th>
</tr>

<%
while (rs.next()) {
    String Sub_Area = rs.getString("Sub_Area");
 String Building = rs.getString("Building");
	String Building_Type = rs.getString("Building_Type");
    String Building_Status = rs.getString("Building_Status");
    String Structural_Material = rs.getString("Structural_Material");
	String Architectural_Style = rs.getString("Architectural_Style");
    String Foundation = rs.getString("Foundation");
if(Foundation ==null || Foundation =="null")
{
	Foundation ="";
}
String UsageType = rs.getString("UsageType");
	int Height = rs.getInt("Height");
    int Floors = rs.getInt("Floors");
    double Latitude = rs.getDouble("Latitude");
 double Longitude = rs.getDouble("Longitude");
 %>
<tr>
<td nowrap><%= Sub_Area %></td>
<td nowrap> <%= Building %></td>
<td><%= Building_Type %></td>
<td><%= Building_Status %></td>
<td><%= Structural_Material %></td>
<td><%= Architectural_Style %></td>
<td ><%= Foundation %></td>
<td ><%= UsageType %></td>
<td><%= Height %></td>
<td><%= Floors %></td>
<td><%= Latitude %></td>
<td><%= Longitude %></td>
</tr>
<%
}
conn.close();
%>

</tbody>
</table>
	</td>
</tr>
</table>
	</form>
	</div>
  </body>
</html>