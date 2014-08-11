<%@page import="topspot.FactSheetHelper"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Topspot FactSheet</title>
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
<style>

</style>
</head>
<body onload="onloadchanges()">
<%
String req_Building =null;
BuildingTrendDetails objBuildingTrendDetails = null;
if(request.getParameter("hid_Building") != null)
req_Building=request.getParameter("hid_Building");
FactSheetHelper objFactSheetHelper= new FactSheetHelper();
objFactSheetHelper.getConnection();
ArrayList<String> colBuildin=objFactSheetHelper.colBuildin;
Iterator<String> colBuildinItr= colBuildin.iterator();
objFactSheetHelper.getFactSheet(req_Building);
ArrayList<BuildingTrendDetails> colPropValue=null;
colPropValue = objFactSheetHelper.colPropValue;
Iterator<BuildingTrendDetails> colPropValueItr= null;
if(colPropValue!=null)
{
	colPropValueItr= colPropValue.iterator();

	while(colPropValueItr.hasNext())		
	{
		objBuildingTrendDetails = (BuildingTrendDetails)colPropValueItr.next();
	}
}
//String scattValue =objFactSheetHelper.scattValue;
%>

<form action="FactSheet.jsp" method="post" onsubmit="checkForm();">
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
						<td>Building Name</td> <td> </td>
					</tr>
					<tr>
					<td nowrap>
		<select name="sel_Building" id="sel_Building" class="tcal">
		<%
			if(req_Building == null || req_Building.equals("null") || req_Building.equals("All") )
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
		while(colBuildinItr.hasNext())
			{
				String ssA= colBuildinItr.next();
				if(ssA != null && !ssA.equals("NULL") && !ssA.equals("null") && ssA.equals(req_Building))
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
					<td align='center' valign='middle'>
							<input type ="submit" value="Show Report" name="B1">
					</td>
					</tr>
			</table>
		</div>
		
		<input type="hidden" name="hid_Building" id="hid_Building">
		<script Language="JavaScript">
		
		function updateFactSheet()
		{
			
		}
		
		function onloadchanges()
		{
		
			var City="";
			var Floors="";
			var Area="";
			var Hieght="";
			var Building="";
			var CompletionDate="";
			var Type="";
			var Developer="";
			<%
			if(objBuildingTrendDetails != null)
			{
				System.out.println("objBuildingTrendDetails.getCity() ---->"+objBuildingTrendDetails.getCity());
			%>
			City='<%=objBuildingTrendDetails.getCity() %>';
			Floors='<%=objBuildingTrendDetails.getFloors() %>';
			Area = '<%=objBuildingTrendDetails.getArea() %>';
			Hieght = '<%=objBuildingTrendDetails.getHeight() %>' ;
			Building = '<%=objBuildingTrendDetails.getBuilding() %>' ;
			CompletionDate = '<%=objBuildingTrendDetails.getCompletion() %>';
			Type = '<%=objBuildingTrendDetails.getBuilding_Type() %>' ;
			Developer = '<%=objBuildingTrendDetails.getCity() %>';			
			<%
				}
			%>
			document.getElementById('Cityid').innerHTML = City;
			document.getElementById('Floorsid').innerHTML = Floors;
			document.getElementById('Areaid').innerHTML = Area;
			document.getElementById('Hieghtid').innerHTML = Hieght;
			document.getElementById('Buildingid').innerHTML = Building;
			document.getElementById('CompletionDateid').innerHTML = CompletionDate;
			document.getElementById('Typeid').innerHTML = Type;
			document.getElementById('Developerid').innerHTML = Developer;

		}
		function checkForm() {
			var sb1 = document.getElementById("sel_Building");
			var strselBuilding = sb1.options[sb1.selectedIndex].value;
			document.getElementById("hid_Building").value =strselBuilding; 
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
        
	<!-- 	<div id="piechart" style="width: 900px; height: 500px;" class="wrapper"></div>  -->
		<table class="details" width="100%">
					<tr>
						<td width="25%"><b>City:</b> </td> <td id="Cityid"  width="25%"></td>
						<td width="25%"><b>Floors:</b> </td> <td id="Floorsid" width="25%"></td>
					</tr>
					<tr>
						<td width="25%"><b>Area:</b> </td> <td id="Areaid" width="25%"></td>
						<td width="25%"><b>Hieght(M):</b> </td> <td id="Hieghtid" width="25%"></td>
					</tr>
					<tr>
						<td width="25%"><b>Building:</b> </td> <td id="Buildingid" width="25%"></td>
						<td width="25%"><b>Completion Date:</b> </td> <td id="CompletionDateid" width="25%"></td>
					</tr>
					<tr>
						<td width="25%"><b>Type:</b> </td> <td id="Typeid" width="25%"></td>
						<td width="25%"><b>Developer:</b> </td> <td id="Developerid" width="25%"></td>
					</tr>
					<tr>
						<td  width="25%"><b>Comments:</b> </td> <td  colspan="2"> <textarea rows="4" cols="50" id="commentsid"></textarea> </td>
						<td  width="25%"><center><input type ="submit" value="Save Comments" name="SC1"></center></td>
					</tr>
		</table>
		
		</div>
	</div>
</div>
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>
</form>

</body>
</html>