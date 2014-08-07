<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TopSpot</title>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type='text/javascript' src='js/menu.js'></script>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="js/ddaccordion.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<style>
.loader {
    width: 20%;
    padding: 100px 200px 0 200px;
}
</style>
</head>
<body>

    <form action="histogram.jsp">
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
                <div class="logo">
                    <img src="images/topspot-logo.png" />
                </div>
            </div>
            <div class="container">
                <div class="searchbg">
                    <table width="100%">
                        <tr>
                            <td>Bedrooms</td>
                        </tr>
                        <tr>
                            <td><select id="ddBedrooms"></select></td>
                        </tr>
                    </table>
                </div>
                <div class="leftBlock">
                    <ul>
                        <li><a href="BuildingPieChart.jsp">Pie Charts by count</a></li>
                        <li><a href="BuildingByValuePieChart.jsp">Pie Charts by
                                value</a></li>
                        <li><a href="PopularBuildingsBarChart.jsp">Bar Charts</a></li>
                        <li><a href="LineChart.jsp">Line Charts</a></li>
                        <li><a href="BuildingScatterChart.jsp">Scatter Charts</a></li>
                    </ul>
                </div>
                <div class="rightBlock">
                    <div class="loader">
                        <img src="img/loader.gif">
                    </div>
                    <div class="wrapper" id="dataContainer">

                    </div>
                </div>
            </div>
        </div>
        <div class="footer-wrap">
            <div class="footer">
                <p style="color: #e51737; padding: 5px;">For Sale, For Rent, For
                    Investment, For Advise</p>
                <p style="color: #052f6e;">Call Top Spot Tel: +971 4 430 6228 /
                    Fax: +971 4 430 6229 info@topspot.ae / Visit us at Regal Tower,
                    Business Bay, Dubai, United Arab Emirates</p>
            </div>
        </div>
    </form>

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
    <script type='text/javascript' src='js/histogram.js'></script>
</body>

</html>