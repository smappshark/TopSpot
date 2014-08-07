<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Heat Map</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css" />
<script src="js/jquery-latest.min.js"></script>
<script type='text/javascript' src='js/jquery.autocomplete.js'></script>
<link rel="stylesheet" type="text/css"
	href="css/jquery.autocomplete.css" />

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
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>

</head>
<body>

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
						<td><label>Select Type</label> <select id="type">
								<option value="0" selected="selected">Select Type</option>
								<option value="sale">Sale</option>
								<option value="rent">Rent</option>
						</select> <label>Select Area</label> <select id="area">
								<option selected="selected">Select Area</option>
						</select></td>

						<td><input type="text" value="" id="search"
							placeholder="Enter Area name" class="find-box"
							onkeypress="loadSearchData();" />
							<button>Find</button></td>

					</tr>
				</table>
				<div>&nbsp;</div>
			</div>
			<div id="panel"></div>
			<!--  <div class="rightBlock" id="map_canvas" style="width: 700px;height: 400px;margin-right:100px;"></div> -->
			<div class="rightBlock" id="map_canvas"
				style="width: 700px; height: 400px; margin-right: 100px;"></div>


		</div>
	</div>
	<!--main end-->
	<div class="footer-wrap">
		<div class="footer">
			<p style="color: #e51737; padding: 5px;">For Sale, For Rent, For
				Investment, For Advise</p>
			<p style="color: #052f6e;">Call Top Spot Tel: +971 4 430 6228 /
				Fax: +971 4 430 6229 info@topspot.ae / Visit us at Regal Tower,
				Business Bay, Dubai, United Arab Emirates</p>
		</div>
	</div>
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
                        	obj.location = new google.maps.LatLng(responseJson[i].Latitude, responseJson[i].Longitude)
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
</body>
</html>