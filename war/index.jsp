
<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topspot</title>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript"
	src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.1.9/src/markerwithlabel.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>

<style>
.textbox {
	background: #F8F8F8 url(images/arrow.png) no-repeat 125px 10px;
	border: none;
	outline: 0;
	padding-left: 10px;
	padding-right: 15px;
	height: 25px;
	width: 145px;
}
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

.width_175 {
    width: 175px !important;
}
</style>
<script>
var buildingArray = new Array();
var bedroomsTypeArray = new Array();
var areaArray = new Array();
var dataForFilters = [],
dataForFilterType = [];

function bindToTextboxBuilding(value) {
    jQuery("#txtBuilding").val(value);
}
function appendToBedrooms(dis) {
	jQuery("#spanBedrooms").html(dis.innerHTML);
}
function selectedBuildingType(value) {
    jQuery("#txtBuildingTypes").val(value);
}
	if ( /*@cc_on!@*/false && document.documentMode === 10) {
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
    <link rel="stylesheet" type="text/css" href="css/dropdown_scrollbar.css" />
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    
    <!-- index events -->
     <script type="text/javascript" src="js/index.js"></script>
     <script type="text/javascript" src="js/index_events.js"></script>
     <!-- index events --> 
     
     <!-- menu events -->
     <script type="text/javascript" src="js/menu_events.js"></script>
     <!-- menu events -->
     
      <!-- histogram script -->
     <script type='text/javascript' src='js/histogram.js'></script>
     <!-- histogram script-->
     
      <!-- growth return matrix script -->
        <script type='text/javascript' src='js/growthreturnmatrix.js'></script>
      <!-- growth return matrix script-->
      
       <!--fact sheet script -->
      <!--   <script type="text/javascript" src="js/factsheet.js"></script> -->
       <!--fact sheet script -->
      
	
       <!--util script -->
      	<script type="text/javascript" src="js/util/util.js"></script> 
       <!--util script -->
       
     
        
    <!--datepicker script -->  
    <script type="text/javascript" src="tcal.js"></script> 
    <!--datepicker script -->
    
    <!--project building information animation script-->
    <script type="text/javascript" src="js/ddaccordion.js"></script>
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
  <!--project building information animation script-->

  <script>
  
  //Load the Visualization API and the piechart package.
  google.load('visualization', '1', {'packages':['corechart']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.setOnLoadCallback(drawBarChart);
  
  function drawBarChart(){
	  var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		var hid_Building1 = document.getElementById("hid_Building1").value;
		var hid_Building2 = document.getElementById("hid_Building2").value;
		var hid_Building3 = document.getElementById("hid_Building3").value;
		var hid_Building4 = document.getElementById("hid_Building4").value;
		var hid_Building5 = document.getElementById("hid_Building5").value;

		jQuery.get('ActionServlet', {
		  reqBuilding1: hid_Building1,
		  reqBuilding2: hid_Building2,
		  reqBuilding3: hid_Building3,
		  reqBuilding4: hid_Building4,
		  reqBuilding5: hid_Building5,
		  req_Area: '',
		  req_SubArea: '',
		  datepicker: datepicker,
		  datepicker1: datepicker1,
	      serviceName: "getBarChartData",
	    }, function(responseJson) {
	       
	    	if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
	    	
	          var data = new google.visualization.DataTable();
	          
	          data.addColumn('string', 'Transaction Date');
	          
				var buildinRoomTypeList = responseJson[responseJson.length  - 1].buildinRoomTypeList;
				var buildingListLength = responseJson[responseJson.length  - 1].buildingListLength;
				 
				for ( var i = 0; i < buildinRoomTypeList.length; i++) {
			       		   data.addColumn('number', buildinRoomTypeList[i]); 
			      }
		      	
	          data.addRows(parseInt(buildingListLength));
	          
	          for  (var i = 0,j = 0; i < responseJson.length; i++){
	        		var buildingName = responseJson[i].buildingName;
	        		var roomType = parseInt(responseJson[i].roomType);
	        		var noOfBedroomsAvaialable = responseJson[i].noOfBedroomsAvaialable;
        			
					//if loop to eliminate com type and add 9
					if(isNaN(roomType)){
						roomType = 9;
					}
					
					//if loop to add building name in  first location whch means froist row of graph
	        		if(roomType == 0){ //to add buidling name
	        			
	        			if(i !=0){
	        				j++;
	        			}
	        			data.setCell(j,roomType,buildingName);
	        			
	        		}
	        		//increment it because of adding building name in first location
	        		roomType = roomType + 1;
	        		
					
	        		data.setCell(j,roomType,noOfBedroomsAvaialable); //to add no of bedrooms per room type
	        		
	        	}
	          
	          var options = {
	                  title: "Top 10 Buildings on Bedrooms vide",
	                  width: 400,
	                  height: 400,
	                  legend: { position: 'right', maxLines: 8 },
	          	bar: { groupWidth: '75%' },
	                  isStacked: true,
	                };
	        	var chart = new google.visualization.BarChart(document.getElementById('barchart'));
	            chart.draw(data, options);
	         }
	        	 
	       

	    });
		
		//calling pie chart function
		drawPieChart();
  }
  
  //piechart code
  function drawPieChart(){
		 
	  jQuery.get('ActionServlet', {
	      serviceName: "getPieChartData",
	    }, function(responseJson) {
	       
	    	if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
	    		var areaListJson = responseJson[0].areaList;
				var areaCountListJson = responseJson[0].areaCountList;
				var googleData = [["SubArea Name", "Number of buildings per Area"]]
				for  (var i = 0; i < areaListJson.length; i++) {
					var adata = [];
					adata.push(areaListJson[i]);
					adata.push(areaCountListJson[i]);
					googleData.push(adata);
	        	}
	          
	      		var options = {
					title : "Top 10 Buildings per Area",
					width : 400,
					height : 400,
					is3D : true
				};
	      		var data = google.visualization.arrayToDataTable(googleData);
				var chart = new google.visualization.PieChart(document.getElementById('piechart'));
				chart.draw(data, options);
	         }
	        	 
	    });
	  return false;
	  
}
 </script> 
 
 
</head>
<body class="" >
<form method="post"> 
<!--  <form> -->
   <!-- Main Container Fluid -->
    <div class="container-fluid menu-hidden">
    <!--  Side Menu -->
 		<%@ include file="includes/Menu.jsp" %>
    <!--  Side Menu -->
    
      <!-- Content -->
        <div id="content">
          <%@ include file="includes/header.jsp" %>
           <%@ include file="includes/index_body.jsp" %>
        </div>
        <!-- // Content END -->
         <div class="clearfix"></div>
            <!--  Side Menu -->
    <%@ include file="includes/footer.jsp" %>
    <!--  Side Menu -->
        </div>
  <!--SaleAndRentTrends script -->
        <script src="js/SaleAndRentTrends.js"></script>
       <!--SaleAndRentTrends script -->
        
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