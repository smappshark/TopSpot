<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%
 String message = request.getParameter("message");
 %>  


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
<title>Insert title here</title>
<script src="js/components/library/jquery/jquery.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/jquery/jquery-migrate.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/library/modernizr/modernizr.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/plugins/less-js/less.min.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
    <script src="js/components/modules/admin/charts/flot/assets/lib/excanvas.js?v=v1.0.3-rc2"></script>
    <script src="js/components/plugins/browser/ie/ie.prototype.polyfill.js?v=v1.0.3-rc2&sv=v0.0.1.1"></script>
  <script src="js/user.js"></script>
    
     <link rel="stylesheet" href="css/admin/module.admin.stylesheet-complete.sidebar_type.discover.min.css"/>
    
    <!--dropdown menu-->
    <link rel="stylesheet" href="css/topspot_style.css"/>
    <!--<script src="../assets/components/core/js/jquery-1.2.3.min.js"></script>-->
    <script src="js/components/core/js/menu.js"></script>
    <!--dropdown menu end-->
    <link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
    <!--expand div-->
    <link rel="stylesheet" href="css/style_exp.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="tcal.css" />
    <!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
    <script type="text/javascript" src="tcal.js"></script> 
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        //Initialize 2nd demo:
        ddaccordion.init({
            headerclass : "tabContentSec", //Shared CSS class name of headers group
            contentclass : "tabContent_data", //Shared CSS class name of contents group
            revealtype : "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
            mouseoverdelay : 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
            collapseprev : false, //Collapse previous content (so only one open at any time)? true/false 
            defaultexpanded : [ 0 ], //index of content(s) open by default [0, 1, etc]. [] denotes no content.
            onemustopen : false, //Specify whether at least one header should be open always (so never all headers closed)
            animatedefault : false, //Should contents open by default be animated into view?
            persiststate : true, //persist state of opened contents within browser session?
            toggleclass : [ "closedlanguage", "openlanguage" ], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
            //togglehtml: ["prefix", "<img src='images/plus.png' style='width:18px; height:18px; float:left; margin-top:6px;' /> ", "<img src='images/minus.png' style='width:18px; height:18px; float:left; margin-top:6px;' />  "], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
            animatespeed : "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
            oninit : function(expandedindices) { //custom code to run when headers have initalized
                //do nothing
            },
            onopenclose : function(header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
                //do nothing
            }
        });
    </script>
   
</head>


<form  name="frmRegistration" onsubmit="return validation();" method="post" action="registrationServlet">
   <!-- Main Container Fluid -->
    <div class="container-fluid menu-hidden">
    
      <!-- Content -->
        <div id="content" style="margin-left : 0px; !important">
            <div class="innerLR">
               
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%">
                        
                            <div class="widget-body innerAll" style="height:371%">
                                          <div class="header">
    	<div class="logo"><img style="border:none;" src="images/topspot-logo.png"/></div>
    </div>
                                <!-- Chart with lines and fill with no points -->
                          <div class="register_wrapp">
        	<div class="reg_title"><h1>Register</h1></div>
            <div class="reg_fileds_left">
            	<table cellpadding="4" cellspacing="0" width="100%">
                	<tr> <td>Name</td> <td><input type="text" name='name' id='name' class="text_field"/></td></tr>
                    <tr> <td>Email</td> <td><input type="text" name='emailId' id='emailId' class="text_field"/></td></tr>
                    <tr> <td>City</td> <td><input type="text" name='city' id='city' class="text_field"/></td></tr>
                   <tr> <td>Address</td> <td><textarea class="text_area" id='address' name='address'></textarea></td></tr>
                    <tr> <td>Country</td> <td><select  class="select_field" id="country" name="country"><option value="0">--select--</option><option value='dubai'>Dubai</option><option value='India'>India</option></select></td></tr>
                    <tr> <td>User Type</td> <td><select  class="select_field" id="userType" name="userType"><option value="0">--select--</option><option value='agent'>Agent</option><option value='investor'>Investor</option><option value='broker'>Broker</option><option value='admin'>Admin</option></select></td></tr>
                </table>
            </div>
            <div class="reg_fileds_right">
            	<table cellpadding="4" cellspacing="0" width="100%">
                	<tr> <td>Preferred Name</td> <td><input type="text" name='preferredName' id='preferredName' class="text_field"/></td></tr>
                    <tr> <td>Phone</td> <td><input type="text" name='phone' id='phone' class="text_field"/></td></tr>
                    <tr> <td>Area</td> <td><input type="text"   name='area' id='area' class="text_field"/></td></tr>
                    <tr> <td>pref. Comunication</td> <td><input type="text" name='preferredComm' id='preferredComm' class="text_field"/></td></tr>
                    <tr> <td>Login Name</td> <td><input type="text" name='loginName' id='loginName' class="text_field"/></td></tr>
                    <tr> <td>About Me</td> <td><textarea class="text_area" id='aboutMe' name='aboutMe'></textarea></td></tr>
                </table>
            </div>
            <div class="buttons"> <input type="submit" value="Sign In" class="btn" /> &nbsp; <input type="button" value="Cancel" class="btn_cl" /></div>
        </div>
                          </div>
                          <div style="clear:both;"></div>
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