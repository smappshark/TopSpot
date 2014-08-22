<%@page import="topspot.BarChartHelper"%>
<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topspot</title>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
  <script>
  function selectedArea(areaName){
  	$('#area').text("");
  	$('#area').text(areaName);
  	$('#hid_Area').val(areaName);
  }
  
  function checkForm() {
		var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		document.getElementById("hid_datepicker").value = datepicker;
		document.getElementById("hid_datepicker1").value = datepicker1;	
	}
  
  </script>
    
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
				<li><a href="#" id="sel_Area">Area</a>
					<ul>
						<%
							if (colAreaItr != null) {
								while (colAreaItr.hasNext()) {
									String ssA= colAreaItr.next();
									if(ssA != null && !ssA.equals("NULL") && !ssA.equals("null") && ssA.equals(req_Area))
									{
						%>
						<li><a href="#" onclick="selectedArea('<%=ssA%>');"><%=ssA%></a></li>
						<%
							} else {
						%>
						<li><a href="#" onclick="selectedArea('<%=ssA%>');"><%=ssA%></a></li>
						<%
							}
								}
							}
						%>
					</ul></li>
				 <li><input type="text" id="datepicker" name="date" class="tcal" value="From date"/> </li>
                                 <li><input type="text" id="datepicker1" name="date1" class="tcal" value="To date"> </li>

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
								<div id="barchart" style="width: 900px; height: 500px;"	class="wrapper"></div>
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
	var chart = new google.visualization.BarChart(document.getElementById('barchart'));
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