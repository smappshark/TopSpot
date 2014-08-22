<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
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
    <script>
    
    function selectedBuildingOne(selectedBuidling){
    	$('#buildingOne').text("");
    	$('#buildingOne').text(selectedBuidling);
    	$('#hid_Building1').val(selectedBuidling);
    }
    
    function selectedBuildingTwo(selectedBuidling){
    	$('#buildingTwo').text("");
    	$('#buildingTwo').text(selectedBuidling);
    	$('#hid_Building2').val(selectedBuidling);
    }

    function selectedBuildingThree(selectedBuidling){
    	$('#buildingThree').text("");
    	$('#buildingThree').text(selectedBuidling);
    	$('#hid_Building3').val(selectedBuidling);
    }

    if ( /*@cc_on!@*/ false && document.documentMode === 10)
    {
        document.documentElement.className += ' ie ie10';
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

String DBName = null;
String url = null;

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
<body class="" onload="onloadchanges()">
<form action="LineChart.jsp" method="post" onsubmit="checkForm();">

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
                                <li><a href="#" id="buildingOne">Building 1</a>
                                    <ul>
                                    <%
										if(colItr1!=null)
										{
										while(colItr1.hasNext())
											{
												String ss1= colItr1.next();
												if(ss1 != null && !ss1.equals("NULL") && !ss1.equals("null") && ss1.equals(req_Building1))
												{
										%>
                                        <li><a href="#" onclick="selectedBuildingOne('<%= ss1 %>');"><%= ss1 %></a></li>
                                 <%
											}
										else
											{
									%>
									 <li><a href="#" onclick="selectedBuildingOne('<%= ss1 %>');"><%= ss1 %></a></li>
												<%
											}
										}
									}
									%>
                                    </ul>
                                </li>
                                <li><a href="#" id="buildingTwo">Building 2</a>
                                    <ul>
            <%                           if(colItr2!=null)
		{
		while(colItr2.hasNext())
			{
				String ssSubA= colItr2.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_Building2))
				{
			%>
                                        <li><a href="#" onclick="selectedBuildingTwo('  <%=ssSubA %>  ');"><%= ssSubA %></a></li>
                                        <%
				}
			else
				{
		%>
		<li><a href="#" onclick="selectedBuildingTwo('  <%=ssSubA %>  ');"><%=ssSubA %></a> </li>
		<%
				}
			}	
		}
		%>
                                    </ul>
                                </li>
                                
                                <li><a href="#" id="buildingThree" >Building 3</a>
                                    <ul>
                                    <%
				if(colItr3!=null)
		{
		while(colItr3.hasNext())
			{
				String sb3= colItr3.next();
				if(sb3 != null && !sb3.equals("NULL") && !sb3.equals("null") && sb3.equals(req_Building3))
				{
			%>
                                        <li><a href="#" onclick="selectedBuildingThree(' <%=sb3 %> ');"><%=sb3 %></a></li>
                                  <%
				}
			else
				{
		%>
		<li><a href="#" onclick="selectedBuildingThree(' <%=sb3 %> ');"><%=sb3 %></a> </li>
		<%
				}
			}	
		}
		%>
                                    </ul>
                                </li>
                                <li><input type="text" id="datepicker" name="date" class="tcal" value="From date"/> </li>
                                 <li><input type="text" id="datepicker1" name="date1" class="tcal" value="To date"> </li>
                                 <li><input type ="submit" value="Show Report" name="B1"/> </li>
                                <!--  <li><a href="#">Type 1</a>
                                    <ul>
                                        <li><a href="#">Type</a></li>
                                        <li><a href="#">Type</a></li>
                                        <li><a href="#">Type</a></li>
                                    </ul>
                                </li> -->
                            </ul>
                        </div>
                        <!-- //Row -->
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                           
                            <div class="widget-body innerAll">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock">
								<div id="linechart" style="width: 600px; height: 400px;" class="wrapper"></div>
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
var chart = new google.visualization.LineChart(document.getElementById('linechart'));
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
	pickvalue ="From date";
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
	pickvalueTodate ="To date";
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
		var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		document.getElementById("hid_datepicker").value = datepicker;
		document.getElementById("hid_datepicker1").value = datepicker1;			
		$('form').submit();
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