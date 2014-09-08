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
    <script type='text/javascript' src='js/jquery.autocomplete.js'></script>
    
<script	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <script src="js/components/core/js/menu.js"></script>
    <!--dropdown menu end-->
    
    <!--expand div-->
   <link rel="stylesheet" href="css/styleadmin.css" type="text/css" />
    
    
<style>
html,body,#map-canvas {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#panel {
	position: absolute;
	top: 5px;
	left: 50%;
	margin-left: -180px;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
}
</style>
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
	});
</script>
</head>
<body class="">
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
                               <li><a href="#" id="type">Select Type</a>
                                    <ul>
                                        <li><a href="#">Sale</a></li>
                                        <li><a href="#">Rent</a></li>
                                    </ul>
                                </li>
                                <li><a href="#" id="area">Select Area</a>
                                    <ul>
                                       <!-- to do list needs to define  -->
                                    </ul>
                                </li>
                                
                            </ul>
                        </div>
                        <!-- //Row -->
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                           
                            <div class="widget-body innerAll">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock"  id="map_canvas" style="width: 700px; height: 400px; margin-right: 100px;">
									
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
 <script>
    function loadSearchData() {
        $("#search").autocomplete(areaArray, {
            width : 320,
            highlight : false,
            multiple : true,
            multipleSeparator : " ",
            scroll : true,
            scrollHeight : 300
        });
    }
    
    var areaArray = new Array();
    $(document).ready(function() {
        $('#type').change(function(event) {
            var $type = $("select#type").val();
            $.get('ActionServlet', {
                serviceName : "getAreaByType",
                type : $type
            }, function(responseJson) {
            	areaArray = [];
                var $select = $('#area');
                $select.find('option').remove();
                $('<option>').val("0").text("Select Area").appendTo($select);
                $.each(responseJson, function(key, value) {
                    areaArray.push(value);
                    $('<option>').val(key).text(value).appendTo($select);
                });
            });
        });

        $('#area').change(function(event) {
            var $area = $("select#area").val();
            var $type = $("select#type").val();
            if ($type == "0") {
                alert("Please select type");
            } else if ($area == "0") {
                alert("Please select Area");
            } else {
                $.get('ActionServlet', {
                    serviceName : "getAreaDetails",
                    areaname : $area,
                    type : $type
                }, function(responseJson) {
                    if (responseJson != null) {
                    	var map, pointarray, heatmap;
                        var totalPrice_sqft = 0, avgPrice_sqft = 0, mapArray = [];
                        var bound = new google.maps.LatLngBounds();
                        for(var i = 0; i < responseJson.length; i++) {
                            totalPrice_sqft += parseInt(responseJson[i].Price_sqft, 10);
                        }
                        avgPrice_sqft = totalPrice_sqft / responseJson.length;
                        for(var i = 0; i < responseJson.length; i++) {
                        	var obj = {};
                        	obj.weight =  parseInt(responseJson[i].Price_sqft, 10) / avgPrice_sqft;
                        	if (obj.weight < 1) {
                                obj.weight = 0;
                            } else if (obj.weight >= 1 && obj.weight < 3) {
                                obj.weight = 30;
                            } else {
                            	obj.weight = 70;
                            }
                        	obj.location = new google.maps.LatLng(responseJson[i].Latitude, responseJson[i].Longitude);
                        	mapArray.push(obj);
                            responseJson[i].avgPrice_sqft = avgPrice_sqft;
                            bound.extend( new google.maps.LatLng(responseJson[i].Latitude, responseJson[i].Longitude) );
                        }
                        console.log(JSON.stringify(mapArray));
                        function initialize() {
                            var mapOptions = {
                                zoom : 14,
                                center : bound.getCenter(),
                                mapTypeId : google.maps.MapTypeId.SATELLITE
                            };
                            var container = document.getElementById('map_canvas');
                            map = new google.maps.Map(container, mapOptions);

                            var pointArray = new google.maps.MVCArray(mapArray);

                            heatmap = new google.maps.visualization.HeatmapLayer({
                                data : pointArray
                            });

                            heatmap.setMap(map);
                        }
                        initialize();
                    }

                });
            }
        });
    });
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
    
</body>
</html>