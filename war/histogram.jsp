<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>

<style>
.loader {
    width: 20%;
    padding: 100px 200px 0 200px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topspot</title>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script>
    
    function selectedBedrooms(selectedBedroom){
        jQuery(".loader").show();
        jQuery("#dataContainer").hide();
        jQuery("#bedroom").text(selectedBedroom);
        var $bedrooms = selectedBedroom;
        if ($bedrooms != "-1") {
            jQuery.get('ActionServlet', {
                serviceName: "getBedroomHistogram",
                bedrooms: $bedrooms
            }, function(responseJson) {
                jQuery("#dataContainer").show();
                jQuery(".loader").hide();
               
                if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
                    var intervals = 20;
                    var minPrice = responseJson[0].Price_AED;
                    var maxPrice = responseJson[responseJson.length - 1].Price_AED;
                    var range = parseInt((maxPrice - minPrice) / intervals, 10);
                    var priceRange = [0, 0],
                        dataArray = [],
                        googleDataArray = [],
                        obj = {};
                    for (var i = 0; i <= responseJson.length; i++) {
                        if (priceRange[1] === 0) {
                            priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                        }
                        if (!obj.Range && !obj.Count) {
                            obj = {
                                Count: 0,
                                Range: ""
                            };
                        }
                        if (responseJson[i] && responseJson[i].Price_AED > priceRange[0] && responseJson[i].Price_AED <= priceRange[1]) {
                            obj.Count = obj.Count + responseJson[i].Count;
                            obj.Range = priceRange.join(",");
                        } else {
                            if (obj.Range && obj.Range != "") {
                                dataArray.push(obj);
                            }
                            obj = {
                                Count: 0,
                                Range: ""
                            };
                            if (responseJson[i]) {
                                priceRange[0] = priceRange[1];
                                priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                                i--;
                            }
                        }
                    }
                    googleDataArray.push(["Range", "Count", { role: 'annotation' }]);
                    for (var j = 0; j < dataArray.length; j++) {
                        var tmpArray = [];
                        tmpArray.push(dataArray[j].Range);
                        tmpArray.push(dataArray[j].Count);
                        tmpArray.push(dataArray[j].Count);
                        googleDataArray.push(tmpArray);
                    }
                    drawHistogram(googleDataArray);
                }
            });
        }
    }
    
    
    </script>
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <link rel="stylesheet" href="css/topspot_style.css"/>
    <!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
    <script src="js/components/core/js/menu.js"></script>
     <link rel="stylesheet" type="text/css" href="css/dropdown_scrollbar.css" />
    <!--dropdown menu end-->
    
    <!--expand div-->
    <link rel="stylesheet" href="css/style_exp.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    <script type="text/javascript" src="tcal.js"></script> 
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type='text/javascript' src='js/histogram.js'></script>
</head>


<form action="growthreturnmatrix.jsp" method="post">
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
                           		 <li><input id="bedroom" type="text" value="" placeholder="Select Bedroom"  onblur="this.placeholder = 'Select Bedroom'" onfocus="this.placeholder = ''" autocomplete="off" class="textbox" onkeydown="autoCompleteList('bedroom','selectedBedrooms','bedroomsTypeArray','dynamicBedroomLi');" style="color:#000 !important"/><!-- <a href="#" id="bedroom">Select Bedroom</a> -->
			                            <ul id="dynamicBedroomLi"  class="scrollbar">
			                            </ul>
			                         </li>
		                          </ul>
                         </div>
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                        
                            <div class="widget-body innerAll" >
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                              
                                <div class="rightBlock">
                                 <div class="loader">
                       				 <img src="img/loader.gif">
              				      </div>
								  <div class="wrapper" id="dataContainer">
				                    </div>
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
       
<input type="hidden" name="ddBedrooms" id="ddBedrooms">
        
        
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

</html>