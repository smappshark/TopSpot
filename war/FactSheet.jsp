<%@page import="topspot.FactSheetHelper"%>
<%@page import="topspot.BuildingTrendDetails"%>
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
    
    function selectedArea(selectedArea){
    	$('#sel_area').text("");
    	$('#sel_area').text(selectedArea.trim());
    	$('#hid_Building').val(selectedArea.trim());
    }
    </script>
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <!-- <link rel="stylesheet" href="css/style.css"/> -->
    <!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
    <script src="js/components/core/js/menu.js"></script>
    <!--dropdown menu end-->
    
    <!--expand div-->
    <link rel="stylesheet" href="css/topspot_style.css"/>
    <link rel="stylesheet" href="css/style_exp.css"/>
    <link rel="stylesheet" type="text/css" href="css/dropdown_scrollbar.css" />
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
     <script type="text/javascript" src="js/factsheet.js"></script>
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
<body class="" onload="onloadchanges()">
<form action="FactSheet.jsp" method="post" onsubmit="checkForm();">

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
                               
                                 <%
							if(req_Building != null && req_Building != "") {
						%>
						<li><a href="#" id="sel_area"><%=req_Building%></a> <%
 							} else {
						%>
						<li><a href="#" id="sel_area">Area</a> <%
						 	}
						 %>
                                    <ul id="dynamicAreaLi"  class="scrollbar">
                                  
                                    </ul>
                                </li>
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
										<table class="details" width="100%">
											<tr>
												<td width="25%"><b>City:</b></td>
												<td id="Cityid" width="25%"></td>
												<td width="25%"><b>Floors:</b></td>
												<td id="Floorsid" width="25%"></td>
											</tr>
											<tr>
												<td width="25%"><b>Area:</b></td>
												<td id="Areaid" width="25%"></td>
												<td width="25%"><b>Hieght(M):</b></td>
												<td id="Hieghtid" width="25%"></td>
											</tr>
											<tr>
												<td width="25%"><b>Building:</b></td>
												<td id="Buildingid" width="25%"></td>
												<td width="25%"><b>Completion Date:</b></td>
												<td id="CompletionDateid" width="25%"></td>
											</tr>
											<tr>
												<td width="25%"><b>Type:</b></td>
												<td id="Typeid" width="25%"></td>
												<td width="25%"><b>Developer:</b></td>
												<td id="Developerid" width="25%"></td>
											</tr>
											<tr>
												<td width="25%"><b>Comments:</b></td>
												<td colspan="2"><textarea rows="4" cols="50"
														id="commentsid"></textarea></td>
												<td width="25%"><center>
														<input type="submit" value="Save Comments" name="SC1">
													</center></td>
											</tr>
										</table>
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