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
<link rel="stylesheet"
    href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="js/ddaccordion.js"></script>
<style>
.toptobottom {
    width: 0;
    word-wrap: break-word;
    text-align: center;
}
.floatLeft{
    float: Left;
}
.mar_left_50 {
    margin-left: 50px;
}
.width_71_p {
    width: 71%; 
}
.pad_5 {
    padding: 5px;
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
    margin-top: 274px;
}
.loader {
    width: 20%;
    padding: 100px 200px 0 200px;
}
#tblLongTerm, #tblShortTerm, #tbl_rt_LongTerm, #tbl_rt_ShortTerm {
    font-size:9px;
}
</style>
</head>
<body>

    <form action="growthreturnmatrix.jsp">
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
                            <td>Buildings</td>
                        </tr>
                        <tr>
                            <td><select id="ddBuildings"></select></td>
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
                        <div>
                            <div class="floatLeft">
                                <label>Long Term</label>
                            </div>
                            <br />
                            <br />
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

                        <div>
                            <div class="shortterm">
                                <label>Short Term</label>
                            </div>
                            <br />
                            <br />
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
        })
    </script>
    <script type='text/javascript' src='js/growthreturnmatrix.js'></script>
</body>

</html>