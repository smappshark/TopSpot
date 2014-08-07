<html>
<head>
<title>Building Map Location</title>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<script type="text/javascript" src="js/maps1.js" ></script>
<script type="text/javascript" src="js/maps2.js"></script>
</head>
<body  onload="initialize();">
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
    	<div class="logo"><img src="images/topspot-logo.png"/></div>
    </div>
    <div class="container"><div>&nbsp;</div><div>&nbsp;</div>
     <div id="map_canvas" style="width: 700px; margin-left:100px; height: 400px"></div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>
<div id="map_canvas" style="width: 700px; height: 400px"></div>
</body>
<script>
var map = new GMap2(document.getElementById("map_canvas"));
map.setCenter(new GLatLng(25.178485, 55.266275), 15);
map.setUIToDefault();

function initialize() {
 var map = new GMap2(document.getElementById("map_canvas")); 
map.setCenter(new GLatLng(25.178485, 55.266275), 15); 
 var map = new GMap2(document.getElementById("map_canvas"));  
 map.setMapType(G_SATELLITE_MAP);

var map = new GMap2(document.getElementById("map_canvas"));
map.setCenter(new GLatLng(25.178485, 55.266275), 15);
var _text = document.createTextNode('Dubai,Executive Bay' + '\n' + 'DAMAC STAR PROPERTIES (L L C)'+ '\n'+ 'ENGINEERING CONSORTI' +'\n'+ 'floors: 19,Height :84'+'\n'+'...');

var _pre = document.createElement("pre");
_pre.appendChild(_text); 
map.openInfoWindow(map.getCenter(),_pre);
}
</script>
</html>
