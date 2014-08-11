<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@page import="topspot.ValuePieChartHelper"%>
<%@page import="topspot.TopspotBean"%>

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
<link rel="stylesheet" href="css/style.css" type="text/css"/>
<link rel="stylesheet" href="css/style_exp.css" type="text/css"/>
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
/*String url = null;
if (SystemProperty.environment.value() ==
    SystemProperty.Environment.Value.Production) {
  // Load the class that provides the new "jdbc:google:mysql://" prefix.
  Class.forName("com.mysql.jdbc.GoogleDriver");
  url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
} else {
  // Local MySQL instance to use during development.
  Class.forName("com.mysql.jdbc.Driver");
  url = "jdbc:mysql://127.0.0.1:3306/TameerClientDB?user=root";
} */
String req_Sub_Area =null;
String req_Area =null;
String req_Type =null;
String req_com_res =null;
String req_rent_sales =null;

if(request.getParameter("hid_Sub_Area") != null)
req_Sub_Area =request.getParameter("hid_Sub_Area");
if(request.getParameter("hid_Area") != null)
req_Area =request.getParameter("hid_Area");
if(request.getParameter("hid_Type") != null)
req_Type =request.getParameter("hid_Type");
if(request.getParameter("hid_com_res") != null)
req_com_res =request.getParameter("hid_com_res");
if(request.getParameter("hid_rent_sales") != null)
req_rent_sales =request.getParameter("hid_rent_sales");

String req_datepicker =null;
if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
req_datepicker=request.getParameter("hid_datepicker");

String req_datepicker1 =null;
if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
req_datepicker1=request.getParameter("hid_datepicker1");

ValuePieChartHelper objValuePieChartHelper= new ValuePieChartHelper();
objValuePieChartHelper.getConnection();

Iterator<String> colAreaItr=objValuePieChartHelper.colArea.iterator();
Iterator<String> colSubAreaItr=objValuePieChartHelper.colSubArea.iterator();
Iterator<String> colBuildTypeItr=objValuePieChartHelper.colBuildType.iterator();
Iterator<String> colcomresItr=objValuePieChartHelper.colcomres.iterator();
Iterator<String> colrentsalesItr=objValuePieChartHelper.colrentsales.iterator();

objValuePieChartHelper.getValuePieChartData(req_Area,req_Sub_Area,req_Type,req_com_res, req_rent_sales,req_datepicker,req_datepicker1);
String scatVal=objValuePieChartHelper.scattValue;
String fromDat=objValuePieChartHelper.Fromdate;
String toDat=objValuePieChartHelper.Todate;
Iterator<TopspotBean> colBuildValueItr=objValuePieChartHelper.colPropValue.iterator();


%>

<form action="BuildingByValuePieChart.jsp" method="post" onsubmit="checkForm();">
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
    	<div class="logo"><img src="images/topspot-logo.png"/></div>
    </div>
    <div class="container">
    	<div class="searchbg">
        	<table width="100%" >
            	<tr>
                	<td>Area</td> <td>Property Type</td><td>Com/Res</td><td>Rent/Sales</td><td> From Date</td> <td>To Date</td><td></td>
                </tr>
                <tr>
<td nowrap>

		<select name="sel_Area" id="sel_Area">
		<%
			if(req_Area == null || req_Area.equals("null") || req_Area.equals("All") )
			{
		%>
		<option value="All" selected>Area</option>
		<%
			}
		else
		{
			%>
			<option value="All">Area</option>
			<%
		}
		while(colAreaItr.hasNext())
			{
				String ssA= colAreaItr.next();
				if(ssA != null && !ssA.equals("NULL") && !ssA.equals("null") && ssA.equals(req_Area))
				{
			%>
			<option value= "<%= ssA %>" selected><%=ssA %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ssA %>" ><%=ssA %></option> 
		<%
				}
			}							
		%>
</select> 
	</td>
	
<td nowrap>

		<select name="sel_Type" id="sel_Type">
		<%
			if(req_Type == null || req_Type.equals("null") || req_Type.equals("All") )
			{
		%>
		<option value="All" selected>Property Type</option>
		<%
			}
		else
		{
			%>
			<option value="All">Property Type</option>
			<%
		}
		while(colBuildTypeItr.hasNext())
			{
				String ssSubA= colBuildTypeItr.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_Type))
				{
			%>
			<option value= "<%= ssSubA %>" selected><%=ssSubA %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ssSubA %>" ><%=ssSubA %></option> 
		<%
				}
			}							
		%>
</select> 
	</td>
	<td nowrap>
		<select name="sel_com_res" id="sel_com_res">
		<%
			if(req_com_res == null || req_com_res.equals("null") || req_com_res.equals("All") )
			{
		%>
		<option value="All" selected>Comm/Res</option>
		<%
			}
		else
		{
			%>
			<option value="All">Comm/Res</option>
			<%
		}
		while(colcomresItr.hasNext())
			{
				String ssSubA= colcomresItr.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_com_res))
				{
			%>
			<option value= "<%= ssSubA %>" selected><%=ssSubA %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ssSubA %>" ><%=ssSubA %></option> 
		<%
				}
			}							
		%>
</select> 

	</td>
	
	<td nowrap>
		
		<select name="sel_rent_sales" id="sel_rent_sales">
		<%
			if(req_rent_sales == null || req_rent_sales.equals("null") || req_rent_sales.equals("All") )
			{
		%>
		<option value="All" selected>Rent/Sales</option>
		<%
			}
		else
		{
			%>
			<option value="All">Rent/Sales</option>
			<%
		}
		while(colrentsalesItr.hasNext())
			{
				String ssSubA= colrentsalesItr.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_rent_sales))
				{
			%>
			<option value= "<%= ssSubA %>" selected><%=ssSubA %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ssSubA %>" ><%=ssSubA %></option> 
		<%
				}
			}							
		%>
</select> 

	</td>
<td nowrap>
		 <input type="text" id="datepicker" name="date" class="tcal" value="From date">
	</td>	
		<td nowrap>
		<input type="text" id="datepicker1" name="date1" class="tcal"  value="To date">
	</td>
	<td align='center' valign='middle'>
<input type ="submit" value="Show Report" name="B1">
</td>
</tr>
</table>
 </div>
<input type="hidden" name="hid_Sub_Area" id="hid_Sub_Area">
<input type="hidden" name="hid_Area" id="hid_Area">
<input type="hidden" name="hid_Type" id="hid_Type">
<input type="hidden" name="hid_com_res" id="hid_com_res">
<input type="hidden" name="hid_rent_sales" id="hid_rent_sales">
<input type="hidden" name="hid_datepicker" id="hid_datepicker">
<input type="hidden" name="hid_datepicker1" id="hid_datepicker1">
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script Language="JavaScript">
function onloadchanges()
{
	var pickvalue;
	<%
	if(req_datepicker == null || req_datepicker.equals("null") || req_datepicker.equals("From date") )
	{
	%>
	pickvalue ="From date"
	<%
		}
		else
		{
	%>
	pickvalue = '<%=req_datepicker%>';
	<%
		}
	%>
	
	var pickvalueTodate;
	<%
	if(req_datepicker1 == null || req_datepicker1.equals("null") || req_datepicker1.equals("To date") )
	{
	%>
	pickvalueTodate ="To date"
	<%
		}
		else
		{
	%>
	pickvalueTodate = '<%=req_datepicker1%>';
	<%
		}
	%>
	document.getElementById("datepicker").value=pickvalue;
	document.getElementById("datepicker1").value=pickvalueTodate;
}

var jsArr = new Array();  
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
	  <% 
		  int i=0;
	  
		  while(colBuildValueItr.hasNext())
		{ 
			  TopspotBean objTopspotBean =colBuildValueItr.next();
		%>
jsArr[<%= i %>] = new Array(); 

jsArr[<%= i %>][0]='<%= objTopspotBean.getBuildingName() %>'; 
jsArr[<%= i %>][1]= '<%= objTopspotBean.getBuildValue() %>'; 
<% 
i++;
} %>

var data = new google.visualization.DataTable();
data.addColumn('string', 'Building Name');
data.addColumn('number', 'Value of a building per SQFT'); 
data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
  data.setCell(i,0,jsArr[i][0]);
data.setCell(i,1,jsArr[i][1]);
}
var options = {
          title: "Top 10 buildings price trends per SQFT",
          width: 600,
          height: 400,
          is3D: true
        };
	var chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(data, options);

}
      function checkForm() {
  		var datepicker = document.getElementById("datepicker").value;
  		var datepicker1 = document.getElementById("datepicker1").value;
  		document.getElementById("hid_datepicker").value = datepicker;
  		document.getElementById("hid_datepicker1").value = datepicker1;	
  		
  		var sb1 = document.getElementById("sel_Area");
  		var strselArea = sb1.options[sb1.selectedIndex].value;
  		document.getElementById("hid_Area").value =strselArea;
  	/*	
  		var sb2 = document.getElementById("sel_SubArea");
  		var strselSubArea = sb2.options[sb2.selectedIndex].value;
  		document.getElementById("hid_Sub_Area").value =strselSubArea;*/

  		var sb3 = document.getElementById("sel_Type");
  		var strselType = sb3.options[sb3.selectedIndex].value;
  		document.getElementById("hid_Type").value =strselType;
  		
  		var sb4 = document.getElementById("sel_com_res");
  		var strselComRes = sb4.options[sb4.selectedIndex].value;
  		document.getElementById("hid_com_res").value =strselComRes;
  		
  		var sb5 = document.getElementById("sel_rent_sales");
  		var strselrentsales = sb5.options[sb5.selectedIndex].value;
  		document.getElementById("hid_rent_sales").value =strselrentsales;

  		
  	}	
      
      
    </script>
            
       
        <div class="leftBlock">
        	<ul>
        	<li><a href="BuildingPieChart.jsp">Pie Charts by count</a></li>
            	<li><a href="BuildingByValuePieChart.jsp">Pie Charts by value</a></li>
                <li><a href="PopularBuildingsBarChart.jsp">Bar Charts</a></li>
                <li><a href="LineChart.jsp">Line Charts</a></li>
                <li><a href="BuildingScatterChart.jsp">Scatter Charts</a></li>
            </ul>
        </div>
        <div class="rightBlock">
		<div id="piechart" style="width: 900px; height: 500px;" class="wrapper"></div>
		</div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>
</form>
</body>
</html>
