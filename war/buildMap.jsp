<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html><head>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<script type="text/javascript" src="js/maps1.js" ></script>
<script type="text/javascript" src="js/maps2.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/jquery-latest.min.js"></script>
<script type='text/javascript' src='js/jquery.autocomplete.js'></script>
<link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />

<script>
var buildingArray = new Array();
$(document).ready(function() {
    $.get('ActionServlet',{serviceName:"getBuildingNames"},function(responseJson) {   
 	                            
        $.each(responseJson, function(key, value) {               
        	buildingArray.push(value);
         });
        
     });
});

function loadSearchData(){
	
	 $("#search").autocomplete(buildingArray, {
			width: 320,
//			max: 4,
			highlight: false,
			multiple: true,
			multipleSeparator: " ",
			scroll: true,
			scrollHeight: 300
		});
}

</script>

<script>

    // get Area names
    $(document).ready(function() {
           $.get('ActionServlet',{serviceName:"getArea"},function(responseJson) {   
        	   var $select = $('#area');
        	   responseJson = JSON.parse(responseJson);
               $select.find('option').remove();
               $('<option>').val("0").text("Select Area").appendTo($select); 
               $.each(responseJson, function(key, value) {               
                   $('<option>').val(key).text(value).appendTo($select);      
                    });
            });
    });
    
 
    //get Sub area names	
   	 $(document).ready(function() {
   		        $('#area').change(function(event) {  
   		        var $area=$("select#area").val();
   		           $.get('ActionServlet',{serviceName:"getSubArea",areaName:$area},function(responseJson) {   
   		        	   var $select = $('#subArea');                           
   		               $select.find('option').remove();
   		            $('<option>').val("0").text("Select Sub-Area").appendTo($select); 
   		               $.each(responseJson, function(key, value) {               
   		                   $('<option>').val(key).text(value).appendTo($select);      
   		                    });
   		            });
   		        });
     });     
   	 
   	//get Building names 
   	$(document).ready(function() {
	        $('#subArea').change(function(event) {  
	        var $subarea=$("select#subArea").val();
	           $.get('ActionServlet',{serviceName:"getBuilding",subareaName:$subarea},function(responseJson) {   
	        	   var $select = $('#building');                           
	               $select.find('option').remove();  
	               $('<option>').val("0").text("Select Building").appendTo($select); 
	               $.each(responseJson, function(key, value) {               
	                   $('<option>').val(key).text(value).appendTo($select);      
	                    });
	            });
	        });
    }); 
   	
    	//get building details
   	$(document).ready(function() {
        $('#building').change(function(event) { 
        	
        var $area=$("select#area").val();
        var $subarea=$("select#subArea").val();
        var $building=$("select#building").val();
           $.get('ActionServlet',{serviceName:"getBuildingDetails",areaname: $area,subareaName:$subarea,buildingName:$building},function(responseJson) { 
        	   if(responseJson!=null){
        		   initialize(responseJson); 
        	   }
       
            });
        });
    }); 
 
  function findBuilding(){
	  
	  var $buildingName = $("#search").val();
	  $.get('ActionServlet',{serviceName:"getBuildingDetailsByName",buildingName: $buildingName},function(responseJson) {   
		  if(responseJson!=null){
   		   initialize(responseJson); 
   	      }
       });
  } 	

    
</script>

</head>
<body>
<!-- 
<div style="margin-left:200px;">
<input type="text" id="search" placeholder="Enter building name" style="width:321px;height:30px;" onkeypress="loadSearchData();"/>
<input type="button" value="Find" onclick="findBuilding();"></div>


Area : <select id="area"><option selected="selected">Select Area</option></select>

Sub-Area : <select id="subArea"><option selected="selected">Select Sub-Area</option></select>

Building : <select id="building"><option selected="selected">Select Building</option></select>

 <div id="map_canvas" style="width: 700px; margin-left:100px; height: 400px"></div> -->
 
 
 <div class="main">
	<div class="header">
    	<div class="logo"><img src="images/topspot-logo.png"/></div>
    </div>
    <div class="container">
    	<div class="searchbg">
        	<table width="100%">
                <tr>
                	<td>
                    	<select id="area">
                    	<option selected="selected">Select Area</option>
						</select>
                    </td> 
                    <td>
                    	<select id="subArea">
                        	<option selected="selected">Select Sub-Area</option>
						</select>
                    </td>
                    <td>
                    	<select id="building">
                        	<option selected="selected">Select Building</option>
						</select>
                    </td>
                    <td>
                        <input type="text"   id="search" placeholder="Enter building name" class="find-box"  onkeypress="loadSearchData();"/>
                        <button onclick="findBuilding();">Find</button>
                    </td>
                    
                </tr>
            </table>
            <div>&nbsp;</div>
        </div>
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
        <div class="rightBlock" id="map_canvas" style="width: 700px;height: 400px;margin-right:100px;"></div>
 
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>



</body>
<script>
function initialize(responseJson) {
	var developer=null;var architect=null;var architect=null;
	var city=responseJson.city;
	var area=responseJson.area;
	
	if(responseJson.developer=="undefined" || responseJson.developer == undefined){
		developer="";
	}else{
		developer=responseJson.developer;
	}
	
	if(responseJson.architect == "undefined" || responseJson.architect == undefined){
		architect="";
	}else{
		architect=responseJson.architect;
	}
	
	var height = responseJson.height;
	var floors= responseJson.floors;

	 var map = new GMap2(document.getElementById("map_canvas")); 
	map.setCenter(new GLatLng(responseJson.latitude, responseJson.longitude), 15); 
	 var map = new GMap2(document.getElementById("map_canvas"));  
	 map.setMapType(G_SATELLITE_MAP);

	var map = new GMap2(document.getElementById("map_canvas"));
	map.setCenter(new GLatLng(responseJson.latitude, responseJson.longitude), 15);
	//var _text = document.createTextNode('Dubai,Executive Bay' + '\n' + 'DAMAC STAR PROPERTIES (L L C)'+ '\n'+ 'ENGINEERING CONSORTI' +'\n'+ 'floors: 19,Height :84'+'\n'+'...');
	var _text = document.createTextNode(city+","+area + '\n'+ developer + '\n'+ architect +'\n'+ 'Height:'+height+","+'Floors :'+floors + '\n'+'...');

	var _pre = document.createElement("pre");
	_pre.appendChild(_text); 
	map.openInfoWindow(map.getCenter(),_pre);
	}

</script>
</html>