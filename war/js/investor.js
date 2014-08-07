jQuery(document).ready(function() {

	function clearDropDown(id) {
		var $select = jQuery(id);
		$select.find('option').remove();
		return $select;
	}
	
	function getFactSheetData() {
		jQuery('.investor_tbl').remove();
		jQuery('.invest_pic').remove();
		var $subarea = jQuery("select#subArea").val();
		var $building = jQuery("select#building").val();
		var $status = jQuery("select#buildStatus").val();
		var $material = jQuery("select#structuralMaterial").val();
		var $style = jQuery("select#architecturalStyle").val();
		if ($subarea != "0" || $building != "0" || $status != "0" || $material != "0" || $style != "0") {
		jQuery.get('ActionServlet', {
			serviceName : "getFactSheetData",
			subareaName : $subarea,
			buildingName : $building,
			buildingStatus : $status,
			buildingMaterial : $material,
			buildingStyle : $style
		}, function(responseJson) {
			responseJson = JSON.parse(responseJson);
			// Binding ResponseJSON to Fact sheet - Start
			var htmlString = "";
			for (var i = 0; i < responseJson.length; i++) {
				var table = "<table class='investor_tbl' cellspacing='0' width='70%' cellpadding='3'>";
				table += "<tr><td><b>City:<b></td><td>" + responseJson[i].city + "</td><td><b>Floors</b></td><td>" + responseJson[i].floors + "</td></tr>";
				table += "<tr><td><b>Area:</b></td><td>" + responseJson[i].area + "</td><td><b>Height(M)</b></td><td>" + responseJson[i].height + "</td></tr>";
				table += "<tr><td><b>Building:</b></td><td>" + responseJson[i].building + "</td><td><b>Completion Date</b></td><td>" + responseJson[i].completion + "</td></tr>";
				table += "<tr><td><b>Type:</b></td><td>" + responseJson[i].buildingType + "</td><td><b>Developer</b></td><td>" + responseJson[i].developer + "</td></tr>";
				table += "<tr><td valign='top'><b>Comments:</b></td><td colspan='3'><textarea class='comment_invest'></textarea></td></tr>";
				table += "<tr><td align='right' colspan='4'><input type='button' value='Submit' class='submit' /></td></tr>";
				table += "</table>";
				
				var div = "<div class='invest_pic'><img src='" + responseJson[i].imageUrl + "' /></div>";
				htmlString += table + div;
			}
			jQuery("#rightBlockDiv").append(htmlString);
			// Binding ResponseJSON to Fact sheet- End
		});
		}
	}
	// get All Sub area names - Start
	clearDropDown('select#subArea');
	clearDropDown('select#building');
	clearDropDown('select#buildStatus');
	clearDropDown('select#structuralMaterial');
	clearDropDown('select#architecturalStyle');
	jQuery.get('ActionServlet', {
		serviceName : "getAllSubAreas"
	}, function(responseJson) {
		responseJson = JSON.parse(responseJson);
		// Binding ResponseJSON to subArea dropdown - Start
		var $select = clearDropDown('select#subArea');
		jQuery('<option>').val("0").text("Select Sub-Area").appendTo($select);
		jQuery.each(responseJson, function(key, value) {
			jQuery('<option>').val(key).text(value).appendTo($select);
		});
		// Binding ResponseJSON to subArea dropdown - End
	});
	// get All Sub area names - End

	// get Building Types by Sub Area Name - Start
	jQuery('select#subArea').change(function(event) {
		clearDropDown('select#building');
		clearDropDown('select#buildStatus');
		clearDropDown('select#structuralMaterial');
		clearDropDown('select#architecturalStyle');
		var $subarea = jQuery("select#subArea").val();
		if ($subarea != "0") {
		jQuery.get('ActionServlet', {
			serviceName : "getBuilding",
			subareaName : $subarea
		}, function(responseJson) {
			responseJson = JSON.parse(responseJson);
			// Binding ResponseJSON to building dropdown - Start
			var $select = clearDropDown('select#building');
			jQuery('<option>').val("0").text("Select Building").appendTo($select);
			jQuery.each(responseJson, function(key, value) {
				jQuery('<option>').val(key).text(value).appendTo($select);
			});
			// Binding ResponseJSON to building dropdown - End
		});
		}
	});
	// get Building Types by Sub Area Name - End
	
	// get buildStatus by Sub Area Name and Building- Start
	jQuery('select#building').change(function(event) {
		clearDropDown('select#buildStatus');
		clearDropDown('select#structuralMaterial');
		clearDropDown('select#architecturalStyle');
		var $subarea = jQuery("select#subArea").val();
		var $building = jQuery("select#building").val();
		if ($subarea != "0" && $building != "0") {
		jQuery.get('ActionServlet', {
			serviceName : "getBuildingStatusByAreaAndBuilding",
			subareaName : $subarea,
			buildingName : $building
		}, function(responseJson) {
			responseJson = JSON.parse(responseJson);
			// Binding ResponseJSON to buildStatus dropdown - Start
			var $select = clearDropDown('select#buildStatus');
			jQuery('<option>').val("0").text("Select Build Status").appendTo($select);
			jQuery.each(responseJson, function(key, value) {
				jQuery('<option>').val(key).text(value).appendTo($select);
			});
			// Binding ResponseJSON to buildStatus dropdown - End
		});
		}
	});
	// get buildStatus by Sub Area Name and Building - End
	
	// get buildMaterilas by Sub Area Name, Building Status and Building- Start
	jQuery('select#buildStatus').change(function(event) {
		clearDropDown('select#structuralMaterial');
		clearDropDown('select#architecturalStyle');
		var $subarea = jQuery("select#subArea").val();
		var $building = jQuery("select#building").val();
		var $status = jQuery("select#buildStatus").val();
		if ($subarea != "0" && $building != "0" && $status != "0") {
		jQuery.get('ActionServlet', {
			serviceName : "getBuildingMaterials",
			subareaName : $subarea,
			buildingName : $building,
			buildingStatus : $status
		}, function(responseJson) {
			responseJson = JSON.parse(responseJson);
			// Binding ResponseJSON to buildStatus dropdown - Start
			var $select = clearDropDown('select#structuralMaterial');
			jQuery('<option>').val("0").text("Select Structural Material").appendTo($select);
			jQuery.each(responseJson, function(key, value) {
				jQuery('<option>').val(key).text(value).appendTo($select);
			});
			// Binding ResponseJSON to buildStatus dropdown - End
		});
		}
	});
	// get buildMaterilas by Sub Area Name, Building Status and Building - End
	
	// get Architectural_Style by Sub Area Name, Building Status, Material and Building- Start
	jQuery('select#structuralMaterial').change(function(event) {
		clearDropDown('select#architecturalStyle');
		var $subarea = jQuery("select#subArea").val();
		var $building = jQuery("select#building").val();
		var $status = jQuery("select#buildStatus").val();
		var $material = jQuery("select#structuralMaterial").val();
		if ($subarea != "0" && $building != "0" && $status != "0" && $material != "0") {
		jQuery.get('ActionServlet', {
			serviceName : "getArchitecturalStyle",
			subareaName : $subarea,
			buildingName : $building,
			buildingStatus : $status,
			buildingMaterial : $material
		}, function(responseJson) {
			responseJson = JSON.parse(responseJson);
			// Binding ResponseJSON to architecturalStyle dropdown - Start
			var $select = clearDropDown('select#architecturalStyle');
			jQuery('<option>').val("0").text("Select Architectural Style").appendTo($select);
			jQuery.each(responseJson, function(key, value) {
				jQuery('<option>').val(key).text(value).appendTo($select);
			});
			// Binding ResponseJSON to architecturalStyle dropdown - End
		});
		}
	});
	// get Architectural_Style by Sub Area Name, Building Status, Material and Building - End
	
	// get Fact sheets by Sub Area Name, Building Status, Material, style and Building- Start
	jQuery('select#architecturalStyle').change(function(event) {
		getFactSheetData();
	});
	// get Fact sheets by Sub Area Name, Building Status, Material, style and Building- End
});
