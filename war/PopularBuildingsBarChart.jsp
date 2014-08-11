<%@page import="topspot.BarChartHelper"%>
<%@page import="topspot.ConnectToCloudSQL"%>
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
String req_Area =null;
if(request.getParameter("hid_Area") != null)
req_Area=request.getParameter("hid_Area");

String req_SubArea =null;
if(request.getParameter("hid_SubArea") != null)
req_SubArea=request.getParameter("hid_SubArea");

String req_datepicker =null;
if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
req_datepicker=request.getParameter("hid_datepicker");

String req_datepicker1 =null;
if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
req_datepicker1=request.getParameter("hid_datepicker1");

ConnectToCloudSQL objConnectToCloudSQL = new ConnectToCloudSQL();

BarChartHelper objBarChartHelper= new BarChartHelper();
objBarChartHelper.getConnection();

Iterator<String> colAreaItr=objBarChartHelper.colArea.iterator();
Iterator<String> colSubAreaItr=objBarChartHelper.colSubArea.iterator();

objBarChartHelper.getBarChartData(req_Area,req_SubArea,req_datepicker,req_datepicker1);
String scatVal=objBarChartHelper.scattValue;
String scatVal1=objBarChartHelper.scattValue1;
String scatVal2=objBarChartHelper.scattValue2;
String fromDat=objBarChartHelper.Fromdate;
String toDat=objBarChartHelper.Todate;
java.util.ArrayList<java.util.ArrayList<Integer>> colBedroomcounts = objBarChartHelper.colBedroomcounts;
ArrayList<String> colBuildNames=objBarChartHelper.colBuildNames;
ArrayList<String> colBedRooms=objBarChartHelper.colBedRooms;

Iterator<String> colItrBuildNames =colBuildNames.iterator();
Iterator<String> colItrBedRooms =colBedRooms.iterator();

%>

<form action="PopularBuildingsBarChart.jsp" method="post" onsubmit="checkForm();">
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
                	<td>Area</td> <td> From Date</td> <td>To Date</td>
                </tr>
                <tr>
<td nowrap>
		<select name="sel_Area" id="sel_Area" class="tcal">
		<%
			if(req_Area == null || req_Area.equals("null") || req_Area.equals("All") )
			{
		%>
		<option value="All" selected class="tcal">Area</option>
		<%
			}
		else
		{
			%>
			<option value="All" class="tcal">Area</option>
			<%
		}
		while(colAreaItr.hasNext())
			{
				String ssA= colAreaItr.next();
				if(ssA != null && !ssA.equals("NULL") && !ssA.equals("null") && ssA.equals(req_Area))
				{
			%>
			<option value= "<%= ssA %>" selected class="tcal"><%=ssA %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ssA %>" class="tcal"><%=ssA %></option> 
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
 <input type="hidden" name="hid_Area" id="hid_Area">
<input type="hidden" name="hid_SubArea" id="hid_SubArea">
<input type="hidden" name="hid_datepicker" id="hid_datepicker">
<input type="hidden" name="hid_datepicker1" id="hid_datepicker1">
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
	function drawChart() 
	{
		<% 
		int i=0;
		while(colItrBuildNames.hasNext())
		{ 
			String dat=colItrBuildNames.next();
			ArrayList<Integer> colnum=colBedroomcounts.get(i);
			int j=1;
			int sizes=colnum.size();
			Iterator<Integer> itrnum= colnum.iterator();
	%>
	jsArr[<%= i %>] = new Array(); 
	jsArr[<%= i %>][0]='<%= dat%>'; 
	<% 
			while(itrnum.hasNext())
			{ 
				int in=itrnum.next();
 	%>
	jsArr[<%= i %>][<%= j %>]= '<%=in%>'; 
	<% 
				j++;
			}
			i++;
		} 
	%>

var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
<%
while(colItrBedRooms.hasNext())
{ 
	String strb=colItrBedRooms.next();
%>
var valb = '<%=strb%>';
data.addColumn('number', valb); 
<%
}
%>


data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
	var arr=jsArr[i];
	for  (var j = 0; j < arr.length; j++){
		data.setCell(i,j,jsArr[i][j]);
	}
}
var options = {
          title: "Top 10 Buildings on Bedrooms vide",
          width: 600,
          height: 400,
          legend: { position: 'right', maxLines: 8 },
  	bar: { groupWidth: '75%' },
          isStacked: true,
        };
	var chart = new google.visualization.BarChart(document.getElementById('piechart'));
    chart.draw(data, options);
	  }
function checkForm() {
    	
		var sb1 = document.getElementById("sel_Area");
		var strselArea = sb1.options[sb1.selectedIndex].value;
		document.getElementById("hid_Area").value =strselArea; 
		
	/*	var sb2 = document.getElementById("sel_SubArea");
		var strselSubArea = sb2.options[sb2.selectedIndex].value;
		document.getElementById("hid_SubArea").value =strselSubArea; */
		var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		document.getElementById("hid_datepicker").value = datepicker;
		document.getElementById("hid_datepicker1").value = datepicker1;	
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
