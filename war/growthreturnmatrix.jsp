<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="sidebar sidebar-discover">
<head>
<style>
.toptobottom {
    width: 0;
    word-wrap: break-word;
    text-align: center;
}
.floatLeft{
    /*float: Left;*/
}
.mar_left_50 {
    margin-left: 50px;
}
.width_71_p {
  /*  width: 72%;*/ 
  float: left;
}
.pad_5 {
    padding: 5px;
    float: left;
}
.pad_7 {
    padding: 7px;
}
.mar_right_3 {
    margin-right: 3px;
}
.mar_left_-3
{
    margin-left: -3px;
}
.shortterm
{
    /*margin-top: 274px;*/
}
#tblLongTerm, #tblShortTerm, #tbl_rt_LongTerm, #tbl_rt_ShortTerm {
    font-size:9px;
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
       
    <script type='text/javascript' src='js/growthreturnmatrix.js'></script>
    <script>

    function BindChart(price, tableID) {
		var tbl = document.getElementById(tableID);
		var rowCount = tbl.rows.length;
		for (var rw = 2; rw < rowCount; rw++) {
			var cellCount = tbl.rows[rw].cells.length;
			for (var cl = 1; cl < cellCount; cl++) {
				if ((rw + 2) > cl) {
					var divisor = (0.01 * (rw + 2));
					var multiplier = (1 + parseFloat("0.0" + cl, 10));
					tbl.rows[rw].cells[cl].innerHTML = ((price * multiplier)/divisor).toFixed(2);
				} else {
					tbl.rows[rw].cells[cl].innerHTML = "";
				}
			}
		}
	}
    
    function selectedBuildings(selectedBuilding){
		jQuery("#dataContainer").hide();
		jQuery(".loader").show();
		jQuery("#buildings").text(selectedBuilding);
		var $building = selectedBuilding;
		jQuery.get('ActionServlet', {
			serviceName : "getGrowthReturnMatrixReport",
			buildingName : $building
		}, function(responseJson) {
			jQuery("#dataContainer").show();
			jQuery(".loader").hide();
			
			
			if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
				if (Object.keys(responseJson[0]).length > 0) {
					var avgRent = responseJson[0].avgRent;
					if (avgRent) {
						BindChart(avgRent, "tblLongTerm");
						BindChart(avgRent, "tblShortTerm");
					}
				}
			}
		});
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
     <link rel="stylesheet" type="text/css" href="css/dropdown_scrollbar.css" />
    <!--expand div-->
    <link rel="stylesheet" href="css/style_exp.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    <script type="text/javascript" src="tcal.js"></script> 
    <script src="js/components/core/js/ddaccordion.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
 
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
                           		 <li><a href="#" id="buildings">Select Building</a>
			                            <ul id="dynamicBuildingLi"  class="scrollbar">
			                            </ul>
			                         </li>
		                          </ul>
                       </div>
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%; min-height: 578px;">
                        
                            <div class="widget-body innerAll" style="min-height:575px;">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock">
                                  <div class="loader">
                       				 <img src="img/loader.gif">
              				      </div>
								  <div class="wrapper" id="dataContainer">
                        <div style="float:left; width:100%;">
                            <div class="floatLeft">
                                <label>Long Term</label>
                            </div>
                            <div class="floatLeft width_71_p pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tblLongTerm" >
                                    <tr><th></th><th colspan="9">GROWTH</th></tr>
                                    <tr><td rowspan="12"><div class="toptobottom pad_7 mar_right_3 mar_left_-3">RETURN</div></td><td></td><td>1%</td><td>2%</td><td>3%</td><td>4%</td><td>5%</td><td>6%</td><td>7%</td><td>8%</td></tr>
                                    <tr><td>4%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>5%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>6%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>7%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>8%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>9%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>10%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>11%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>12%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>13%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>14%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                </table>
                            </div>
                            <div class="floatLeft mar_left_50 pad_5" id="tbl_rt_LongTerm">
                                <table frame="box" rules="all" cellpadding="3">
                                    <tr><td>Average Rent</td><td></td></tr>
                                    <tr><td>Average Price</td><td></td></tr>
                                    <tr><td>Median</td><td></td></tr>
                                    <tr><td>Mode</td><td></td></tr>
                                    <tr><td>stDev</td><td></td></tr>
                                    <tr><td>Varience</td><td></td></tr>
                                    <tr><td>Kurtosis</td><td></td></tr>
                                    <tr><td>Skewness</td><td></td></tr>
                                    <tr><td>Min</td><td></td></tr>
                                    <tr><td>Max</td><td></td></tr>
                                    <tr><td>Sum</td><td></td></tr>
                                    <tr><td>Volume</td><td>2531314.29</td></tr>
                                </table>
                            </div>
                        </div>

                        <div style="margin-top:30px;">
                            <div class="shortterm">
                                <label>Short Term</label>
                            </div>
                           
                            <div class="floatLeft width_71_p pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tblShortTerm">
                                    <tr><th></th><th colspan="9">GROWTH</th></tr>
                                    <tr><td rowspan="12"><div class="toptobottom pad_7 mar_right_3 mar_left_-3">RETURN</div></td><td></td><td>1%</td><td>2%</td><td>3%</td><td>4%</td><td>5%</td><td>6%</td><td>7%</td><td>8%</td></tr>
                                    <tr><td>4%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>5%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>6%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>7%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>8%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>9%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>10%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>11%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>12%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>13%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                    <tr><td>14%</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
                                </table>
                            </div>
                            <div class="floatLeft mar_left_50 pad_5">
                                <table frame="box" rules="all" cellpadding="3" id="tbl_rt_ShortTerm">
                                    <tr><td>Average Rent</td><td></td></tr>
                                    <tr><td>Average Price</td><td></td></tr>
                                    <tr><td>Median</td><td></td></tr>
                                    <tr><td>Mode</td><td></td></tr>
                                    <tr><td>stDev</td><td></td></tr>
                                    <tr><td>Varience</td><td></td></tr>
                                    <tr><td>Kurtosis</td><td></td></tr>
                                    <tr><td>Skewness</td><td></td></tr>
                                    <tr><td>Min</td><td></td></tr>
                                    <tr><td>Max</td><td></td></tr>
                                    <tr><td>Sum</td><td></td></tr>
                                    <tr><td>Volume</td><td>2531314.29</td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
							 </div>
							 <div style="clear:both;"></div>
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
       
<input type="hidden" name="ddBuildings" id="ddBuildings">
        
        
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