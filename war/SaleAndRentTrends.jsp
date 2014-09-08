<%@page import="java.util.*"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<script>
var dataForFilters = [],
dataForFilterType = [];
</script>
<style>
.loader {
	width: 20%;
	padding: 100px 200px 0 200px;
}

html,body,#map-canvas {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#marker-tooltip {
	display: none;
	position: absolute;
	width: 200px;
	height: 70px;
	background-color: #FFFFFF;
	border: 1px solid #CCCCCC;
	margin: -85px;
}

.labels {
	color: red;
	background-color: white;
	font-family: "Lucida Grande", "Arial", sans-serif;
	font-size: 10px;
	font-weight: bold;
	text-align: center;
	width: 60px;
	border: 2px solid #CCCCCC;
	white-space: nowrap;
	opacity: 0.25 !important;
}

.labels_active {
	opacity: 1 !important;
}

.textbox {
	background: #F8F8F8 url(images/arrow.png) no-repeat 96px 10px !important;
	border: none;
	outline: 0;
	padding-left: 10px;
	padding-right: 15px;
	height: 25px;
	width: 104px;
}


.width_175 {
    width: 175px !important;
}

</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topspot</title>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript"
	src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.1.9/src/markerwithlabel.js"></script>
<script
	src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
<script
	src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
<script
	src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
<script
	src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
<script
	src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
<script
	src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
<script type='text/javascript' src='js/jquery.autocomplete.js'></script>
<link rel="stylesheet"
	href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css" />

<!--dropdown menu-->
<link rel="stylesheet" href="css/topspot_style.css" />
<!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
<script src="js/components/core/js/menu.js"></script>
<!--dropdown menu end-->


<link rel="stylesheet" href="css/dropdown_scrollbar.css" />

<!--expand div-->
<link rel="stylesheet" href="css/style_exp.css" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="tcal.css" />
<!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
<script type="text/javascript" src="tcal.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <!--util script -->
      <script type="text/javascript" src="js/util/util.js"></script> 
       <!--util script -->

<script> 
google.load("visualization", "1", {packages:["corechart"]});
function bindToTextboxBuilding(value) {
    jQuery("#txtBuilding").val(value);
}
function appendToBedrooms(dis) {
	jQuery("#spanBedrooms").html(dis.innerHTML);
}
function selectedBuildingType(value) {
    jQuery("#txtBuildingTypes").val(value);
}

function autoPopulateList(textBoxId,functionName,arrayToSearch,idToAppend) {
	
	var textBoxvalue = $("#"+textBoxId).val();
	console.log("textBoxvalue - "+textBoxvalue);
	var totalLengthOfArray = dataForFilters.length;
	console.log("totalLengthOfArray - "+totalLengthOfArray);
	console.log("arrayToSearch - "+arrayToSearch);
	var ulInnerHtml ='';
	$('#'+idToAppend).html("");
	
		
	for (var i = 0; i < totalLengthOfArray; i++) {
		console.log("indexOf "+ dataForFilters[i].toLowerCase().indexOf(textBoxvalue.toLowerCase()));
		if (arrayToSearch[i].toLowerCase().indexOf(textBoxvalue.toLowerCase()) == 0) {
			ulInnerHtml = ulInnerHtml + "<li><a href='#' onclick='"+functionName+"(\"" + dataForFilters[i] + "\");'>"+dataForFilters[i]+"</a></li>";
		}
    }
	console.log("ulInnerHtml - "+ulInnerHtml);
	  
     if(ulInnerHtml.length > 0){
     	$("#"+idToAppend).append(ulInnerHtml);
     }
}

/*
google.load("visualization", "1", {packages:["corechart"]});
function manuplateLineChartCallback(d, status, o) {
    if (/success/i.test(status) === true && d && d.constructor === Array && d.length > 0) {
          google.setOnLoadCallback(drawChart);
          function drawChart() {
        	console.log(d);
            var data = google.visualization.arrayToDataTable(d);
            var options = {
                     title: 'Buidling',
                  curveType: 'function'
            };

            var chart = new google.visualization.LineChart(document.getElementById('divLinechart'));

            chart.draw(data, options);
          }

    } else {
        alert("Message: " + o);
    }
}

       setInterval(function() {
		manuplateLineChartCallback([ [ "Transaction Date", "Price" ],
				[ "2013-05-13", Math.random() ], [ "2013-07-21", 1033.56 ],
				[ "2013-09-12", 39.52 ], [ "2013-09-15", 39.52 ],
				[ "2013-10-08", Math.random() ], [ "2013-12-16", 1215.95 ],
				[ "2013-12-17", Math.random() ], [ "2014-01-30", 42.56 ],
				[ "2014-02-02", 42.56 ], [ "2014-02-18", 42.56 ] ], "success",
				null)
	}, 1000);
       */
</script>
</head>


<form action="SaleAndRentTrends.jsp" method="post">
	<!-- Main Container Fluid -->
	<div class="container-fluid menu-hidden">
		<!--  Side Menu -->
		<%@ include file="includes/Menu.jsp"%>
		<!--  Side Menu -->

		<!-- Content -->
		<div id="content">
			<%@ include file="includes/header.jsp"%>
			<div class="innerLR">
				<h2 class="margin-none">
					Analytics &nbsp;<i class="fa fa-fw fa-pencil text-muted"></i>
				</h2>

				<div class="row">
					<div class="subnav">
						<ul id="nav">
							<li><input id="txtBuilding" type="text" placeholder="Select Building" onkeyup="autoPopulateList('txtBuilding','bindToTextboxBuilding',dataForFilters,'dynamicBuildingLi');"  onblur="this.placeholder = 'Select Building'" onfocus="this.placeholder = ''" class="textbox" autocomplete="off"  style="color:#000 !important"/>
								<ul id="dynamicBuildingLi" class="scrollbar">
								</ul></li>
							<li> <a href="#" >Bedrooms: <span id="spanBedrooms">0</span></a>
                                <ul id="">
	                                <li><a href="#" onclick="appendToBedrooms(this)" >0</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >1</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >2</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >3</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >4</a></li>
	                                <li><a href="#" onclick="appendToBedrooms(this)" >5</a></li>
                                </ul></li>
                                <li> Price(AED): <input type="text" size="5" id="txtPriceFrom" value="2000"/ >
                                <input type="text" id="txtPriceTo" size="5" value="200000" /></li>
                                <li><input id="txtBuildingTypes" type="text" placeholder="Select Building Type" class="textbox" />
                                <ul id="dynamicBuildingTypeLi" class="scrollbar">
                                </ul></li>
                                <li> <input type="button" id="btnSearch" value="Search" />
                                </li>
						</ul>
					</div>
					<div class="col-md-8" style="width: 100%">

						<!-- Widget -->
						<div class=" widget widget-body-white "
							style=" float:left; width: 50%; min-height: 480px;">

							<div class="widget-body innerAll">
								<!-- Chart with lines and fill with no points -->
								<!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->

								<div class="rightBlock">
									<div id="map-canvas" style="min-height: 241px; height: 450px;"></div>
									<div id="marker-tooltip"></div>
								</div>
							</div>
						</div>
						<div class="widget widget-body-white" style="float:left; width: 50%;">
						  <h3 style="padding: 10px" id="spanNearbyBuildingName">Nearby Buildings</h3>
						  <div id="nearbyBuildings" style="height: 427px; overflow-y:auto"></div>
						</div>
						<div class="widget widget-body-white" style="float:left; width: 50%;" id="divLinechart">
						</div>
						<div class="widget widget-body-white" style="float:left; width: 50%; display:none" id="divFactSheet">
						<table frame="box" rules="all" cellpadding="3" style="width: 100%">
                                    <tr><td>Building</td><td id="tdBuilding"></td></tr>
                                    <tr><td>Area</td><td id="tdArea"></td></tr>
                                    <tr><td>Sub Area</td><td id="tdSubArea"></td></tr>
                                    <tr><td>Building Type</td><td id="tdBuildingType"></td></tr>
                                    <tr><td>Building Status</td><td id="tdBuildingStatus"></td></tr>
                                    <tr><td>Structural Material</td><td id="tdStructualMaterial"></td></tr>
                                    <tr><td>Architectural Style</td><td id="tdArchitecturalStyle"></td></tr>
                                    <tr><td>Usage</td><td id="tdUsage"></td></tr>
                                    <tr><td>Height(M)</td><td id="tdHeight"></td></tr>
                                    <tr><td>Floors</td><td id="tdFloors"></td></tr>
                                    <tr><td>Completion Date</td><td id="tdCompletionDate"></td></tr>
                                    <tr><td>Elevators</td><td id="tdElevators"></td></tr>
                                    <tr><td>Parking</td><td id="tdParking"></td></tr>
                                    <tr><td>Architect</td><td id="tdArchitect"></td></tr>
                                    <tr><td>Developer</td><td id="tdDeveloper"></td></tr>
                                    <tr><td>Contrctor</td><td id="tdContrctor"></td></tr>
                                    <tr><td>Amenities</td><td id="tdAmenities"></td></tr>
                                    <tr><td>Surrounding Amenities</td><td id="tdSurroundingAmenities"></td></tr>
                                </table>
                                </div>
						<!-- // End Widget -->
					</div>
					

				</div>

			</div>
		</div>
	</div>
	<!-- // Content END -->
	<div class="clearfix"></div>
	<!--  Side Menu -->
	<%@ include file="includes/footer.jsp"%>
	<!--  Side Menu -->

	<input type="hidden" name="ddBedrooms" id="ddBedrooms">


	<!-- Global -->
	<script data-id="App.Config">
		var App = {};
		var basePath = '', commonPath = 'js', rootPath = '/', DEV = false, componentsPath = 'js/components/';
		var primaryColor = '#3695d5', dangerColor = '#b55151', successColor = '#609450', infoColor = '#4a8bc2', warningColor = '#ab7a4b', inverseColor = '#45484d';
		var themerPrimaryColor = primaryColor;
	</script>

	<script
		src="js/components/library/bootstrap/js/bootstrap.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/plugins/nicescroll/jquery.nicescroll.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/plugins/breakpoints/breakpoints.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/plugins/preload/pace/pace.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/plugins/preload/pace/preload.pace.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script src="js/components/core/js/animations.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/lib/jquery.flot.resize.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/lib/plugins/jquery.flot.tooltip.min.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/custom/js/flotcharts.common.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-line-2.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-mixed-1.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/flot/assets/custom/js/flotchart-bars-horizontal.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/easy-pie/assets/lib/js/jquery.easy-pie-chart.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/easy-pie/assets/custom/easy-pie.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/sparkline/jquery.sparkline.min.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/charts/sparkline/sparkline.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/modules/admin/maps/vector/assets/lib/jquery-jvectormap-1.2.2.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/modules/admin/maps/vector/assets/lib/maps/jquery-jvectormap-world-mill-en.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script
		src="js/components/modules/admin/maps/vector/assets/custom/maps-vector.world-map-markers.init.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
	<script src="js/components/core/js/sidebar.main.init.js?v=v1.0.3-rc2"></script>
	<script
		src="js/components/core/js/sidebar.discover.init.js?v=v1.0.3-rc2"></script>
	<script src="js/components/core/js/core.init.js?v=v1.0.3-rc2"></script>
	<script src="js/util/util.js"></script>
	<script src="js/SaleAndRentTrends.js"></script>

</form>

</html>