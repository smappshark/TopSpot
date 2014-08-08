<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Topspot - Invester</title>

<script type='text/javascript' src='js/jquery-1.2.3.min.js'></script>
<script type='text/javascript' src='js/menu.js'></script>
<link rel="stylesheet" href="css/style.css" type="text/css" />
<script> 

// Save Comments - Start
	function js_buildingDetails_click(dis) {
		var table = $( dis ).parent().parent().parent();
		var data = {};
		data.city = table[0].children[0].children[1].childNodes[0].data;
		data.area = table[0].children[1].children[1].childNodes[0].data;
		data.building = table[0].children[2].children[1].childNodes[0].data;
		data.developer = table[0].children[3].children[3].childNodes[0].data;
		data.comments = table[0].children[4].children[1].childNodes[0].value;
		data.propertyId = table[0].children[6].children[0].childNodes[0].data;
		data.serviceName = "setInvestorComments";
		console.log(data);
		jQuery(".loader").show();
		jQuery.get('ActionServlet', data, function(responseJson) {
			alert("Saved successfully");
			jQuery(".loader").hide();
			table[0].children[4].children[1].childNodes[0].value = "";
			// Binding ResponseJSON to architecturalStyle dropdown - End
		});
	}
// Save Comments - End

</script>
<!--#BAEDFF-->
</head>

<body>
	<div class="nav-wrap">
		<div class="nav">
			<ul id="nav">
				<li><a href="#">Charts</a>
					<ul>
						<li><a href="#">Pie Charts</a></li>
						<li><a href="#">Bar Charts</a></li>
						<li><a href="#">Line Charts</a></li>
						<li><a href="#">Scatter Charts</a></li>
						<li><a href="#">Sub Ara Charts</a></li>
					</ul></li>
				<li><a href="buildMap.jsp">Maps</a></li>
				<li><a href="#">Histogram</a></li>
				<li><a href="#">Scatter Charts</a></li>
				<li><a href="#">Mash Charts</a></li>
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
						<td>Sub Area</td>
						<td>Building Type</td>
						<td>Build Status</td>
						<td>Structural Material</td>
						<td>Architectural Style</td>
					</tr>
					<tr>
						<td><select id="subArea">

						</select></td>
						<td><select id="building">

						</select></td>
						<td><select id="buildStatus">
						</select></td>
						<td><select id="structuralMaterial">
						</select></td>
						<td><select id="architecturalStyle">
						</select></td>
					</tr>
				</table>
			</div>
			<div class="leftBlock">
				<ul>
					<li><a href="#">Pie Charts</a></li>
					<li><a href="#">Bar Charts</a></li>
					<li><a href="#">Line Charts</a></li>
					<li><a href="#">Scatter Charts</a></li>
					<li><a href="#">Sub Ara Charts</a></li>
				</ul>
			</div>
			<div class="rightBlock" id="rightBlockDiv">
				<div class="loader">
                    <img src="img/loader.gif">
                </div>
                <div class="js_trigger">
					<h1>Fact Sheet</h1>
					<h2>
						<ul>
							<li>Info in static Table + Pics</li>
						</ul>
					</h2>
				</div>
<!-- 
				<table class="investor_tbl" cellspacing="0" width="70%"
					cellpadding="3">
					<tr>
						<td><b>City:</b></td>
						<td>Dubai</td>
						<td><b>Floors</b></td>
						<td>29</td>
					</tr>
					<tr>
						<td><b>Area:</b></td>
						<td>Business Bay</td>
						<td><b>Height(M)</b></td>
						<td>135</td>
					</tr>
					<tr>
						<td><b>Building:</b></td>
						<td>Bayswater</td>
						<td><b>Completion Date</b></td>
						<td>2009</td>
					</tr>
					<tr>
						<td><b>Type:</b></td>
						<td>Heigh Rise</td>
						<td><b>Developer</b></td>
						<td>Omniyat</td>
					</tr>
					<tr>
						<td valign="top"><b>Comments:</b></td>
						<td colspan="3"><textarea class="comment_invest"></textarea></td>
					</tr>
					<tr>
						<td align="right" colspan="4"><input type="button"
							value="Submit" class="submit" /></td>
					</tr>
				</table>
				<div class="invest_pic">
					<img src="images/building.png" />
				</div>


				<table class="investor_tbl" cellspacing="0" width="70%"
					cellpadding="3">
					<tr>
						<td><b>City:<b></td>
						<td>Dubai</td>
						<td><b>Floors</b></td>
						<td>29</td>
					</tr>
					<tr>
						<td><b>Area:</b></td>
						<td>Business Bay</td>
						<td><b>Height(M)</b></td>
						<td>135</td>
					</tr>
					<tr>
						<td><b>Building:</b></td>
						<td>Bayswater</td>
						<td><b>Completion Date</b></td>
						<td>2009</td>
					</tr>
					<tr>
						<td><b>Type:</b></td>
						<td>Heigh Rise</td>
						<td><b>Developer</b></td>
						<td>Omniyat</td>
					</tr>
					<tr>
						<td valign="top"><b>Comments:</b></td>
						<td colspan="3"><textarea class="comment_invest"></textarea></td>
					</tr>
					<tr>
						<td align="right" colspan="4"><input type="button"
							value="Submit" class="submit" /></td>
					</tr>
				</table>
				<div class="invest_pic">
					<img src="images/building.png" />
				</div>
-->
			</div>
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

	<script type='text/javascript' src='js/investor.js'></script>
</body>
</html>