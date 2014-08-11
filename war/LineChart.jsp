<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TopSpot</title>
<script type='text/javascript' src='js/jquery-1.2.3.min.js'></script>
<script type='text/javascript' src='js/menu.js'></script>
<link rel="stylesheet" href="css/style.css" type="text/css"/>

<!--expand div-->
<link rel="stylesheet" href="css/style_exp.css" type="text/css"/>

<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->

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
String req_Building1 =null;
if(request.getParameter("hid_Building1") != null)
req_Building1=request.getParameter("hid_Building1");

String req_Building2 =null;
if(request.getParameter("hid_Building2") != null)
req_Building2=request.getParameter("hid_Building2");

String req_Building3 =null;
if(request.getParameter("hid_Building3") != null)
req_Building3=request.getParameter("hid_Building3");

String req_datepicker =null;
if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
req_datepicker=request.getParameter("hid_datepicker");

String req_datepicker1 =null;
if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
req_datepicker1=request.getParameter("hid_datepicker1");

ArrayList<Integer> colpersqftFrom=new ArrayList<Integer>();
ArrayList<Integer> colpersqftTo=new ArrayList<Integer>();
ConnectToCloudSQL objConnectToCloudSQL = new ConnectToCloudSQL();
ArrayList<String> colBuild =objConnectToCloudSQL.getConnection();
Iterator<String> colItr1=colBuild.iterator();
Iterator<String> colItr2=colBuild.iterator();
Iterator<String> colItr3=colBuild.iterator();

//Iterator<String> colAreaItr=objConnectToCloudSQL.colArea.iterator();
//Iterator<String> colSubAreaItr=objConnectToCloudSQL.colSubArea.iterator();

List<BuildingTrendDetails> colBuildingTrendDetails=objConnectToCloudSQL.getLineChartData(req_Building1,req_Building2,req_Building3,req_datepicker,req_datepicker1);
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

%>
<form action="LineChart.jsp" method="post" onsubmit="checkForm();">
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
                	<td>Building1</td> <td> Building2</td> <td>Building3</td><td> From Date</td> <td>To Date</td><td></td>
                </tr>
                <tr>
<td nowrap>
		<select name="sel_Building1" id="sel_Building1">
		<div class="subnav" align="center"> 
		<ul>
		<%
			if(req_Building1 == null || req_Building1.equals("null") || req_Building1.equals("All") || req_Building1.equals(""))
			{
		%>
		<li><option value="All" selected>Building 1</option></li>
		<%
			}
		else
		{
			%>
		<li>	<option value="All">Building 1</option></li>
			<%
		}
		if(colItr1!=null)
		{
		while(colItr1.hasNext())
			{
				String ss1= colItr1.next();
				if(ss1 != null && !ss1.equals("NULL") && !ss1.equals("null") && ss1.equals(req_Building1))
				{
			%>
			<li><option value= "<%= ss1 %>" selected><%=ss1 %></option> </li>
			<%
				}
			else
				{
		%>
		<li><option value= "<%= ss1 %>" ><%=ss1 %></option> </li>
		<%
				}
			}
		}
		%>
		</ul>
		</div>
</select> 
 

	</td>
	
<td nowrap>
		
		<div  class="subnav" align="center">
		<select name="sel_Building2" id="sel_Building2">
		<ul>
		<%
			if(req_Building2 == null || req_Building2.equals("null") || req_Building2.equals("All") || req_Building2.equals("") )
			{
		%>
		<li><option value="All" selected>Building 2</option> </li>
		<%
			}
		else
		{
			%>
			<li><option value="All">Building 2</option> </li>
			<%
		}
		if(colItr2!=null)
		{
		while(colItr2.hasNext())
			{
				String ssSubA= colItr2.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_Building2))
				{
			%>
			<li><option value= "<%= ssSubA %>" selected><%=ssSubA %></option>  </li>
			<%
				}
			else
				{
		%>
		<li><option value= "<%= ssSubA %>" ><%=ssSubA %></option> </li>
		<%
				}
			}	
		}
		%>
		</ul>
		
</select> 
</div>
	</td>	
	
	<td nowrap>
		
		<div  class="subnav" align="center">
		<select name="sel_Building3" id="sel_Building3">
		<ul>
		<%
			if(req_Building3 == null || req_Building3.equals("null") || req_Building3.equals("All") || req_Building3.equals("") )
			{
		%>
		<li><option value="All" selected>Building 2</option></li>
		<%
			}
		else
		{
			%>
			<li><option value="All">Building 2</option></li>
			<%
		}
		if(colItr3!=null)
		{
		while(colItr3.hasNext())
			{
				String sb3= colItr3.next();
				if(sb3 != null && !sb3.equals("NULL") && !sb3.equals("null") && sb3.equals(req_Building3))
				{
			%>
			<li><option value= "<%= sb3 %>" selected><%=sb3 %></option> </li>
			<%
				}
			else
				{
		%>
		<li><option value= "<%= sb3 %>" ><%=sb3 %></option> </li>
		<%
				}
			}	
		}
		%>
		</ul>
</select> 
</div>
	</td>
	<td nowrap>
		<input type="text" id="datepicker" name="date" class="tcal" value="From date">
	</td>	
<td nowrap>
		<input type="text" id="datepicker1" name="date1" class="tcal" value="To date">
	</td>	
	<td align='center' valign='middle'>
<input type ="submit" value="Show Report" name="B1">
</td>
</tr>
<tr><td>

</td>
</tr>
</table>
</div>
<input type="hidden" name="hid_Building1" id="hid_Building1">
<input type="hidden" name="hid_Building2" id="hid_Building2">
<input type="hidden" name="hid_Building3" id="hid_Building3">
<input type="hidden" name="hid_datepicker" id="hid_datepicker">
<input type="hidden" name="hid_datepicker1" id="hid_datepicker1">


 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script Language="JavaScript">
var jsArr = new Array();  
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() 
{
	<% 
	int i=0;
	if(colreps!= null && colreps.size() > 0)
	{
	while(colItrBuildingDate.hasNext())
	{ 
		String dat=colItrBuildingDate.next();
		ArrayList<Integer> colnum=colreps.get(i);
		int j=1;
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
}
%>
if(jsArr != null && jsArr.length > 0)
{
var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
<%
if(colItrBuilding != null)
{
while(colItrBuilding.hasNext())
{ 
String strb=colItrBuilding.next();
%>
var valb = '<%=strb%>';
data.addColumn('number', valb); 
<%
}
}
%>
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
    };
var chart = new google.visualization.LineChart(document.getElementById('piechart'));
chart.draw(data, options);
}
}

  }
function onloadchanges()
{
	var pickvalue;
	<%
	if(req_datepicker == null || req_datepicker.equals("null") || req_datepicker.equals("From date") || req_datepicker.equals(""))
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
	if(req_datepicker1 == null || req_datepicker1.equals("null") || req_datepicker1.equals("To date") || req_datepicker1.equals("") )
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

	function checkForm() {
    	
		var sb1 = document.getElementById("sel_Building1");
		var strselBuilding1 = sb1.options[sb1.selectedIndex].value;
		document.getElementById("hid_Building1").value =strselBuilding1;
		
		var sb2 = document.getElementById("sel_Building2");
		var strselBuilding2 = sb2.options[sb2.selectedIndex].value;
		document.getElementById("hid_Building2").value =strselBuilding2;
		
		var sb3 = document.getElementById("sel_Building3");
		var strselBuilding3 = sb3.options[sb3.selectedIndex].value;
		document.getElementById("hid_Building3").value =strselBuilding3;
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
		<div id="piechart" style="width: 600px; height: 400px;" class="wrapper"></div>
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
