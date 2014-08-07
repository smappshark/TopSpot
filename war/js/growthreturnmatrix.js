jQuery(document).ready(function() {
	jQuery("#dataContainer").hide();
	jQuery(".loader").show();
	function createAndReturnElementOption (value, text) {
		var option = document.createElement("option");
		option.setAttribute("value", value);
		option.innerHTML = text;
		return option;
	}
	
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
	
	jQuery.get('ActionServlet', {
		serviceName : "getBuildingNames"
	}, function(responseJson) {
		jQuery(".loader").hide();
		if (responseJson && responseJson.constructor === Object) {
			var select = document.getElementById("ddBuildings");
			if (Object.keys(responseJson).length > 0) {
				select.appendChild(createAndReturnElementOption(0, "Select Building"));
				for (var key in responseJson) {
					select.appendChild(createAndReturnElementOption(key, responseJson[key]));
				}
			}
		}
	});
	
	jQuery('select#ddBuildings').change(function(event) {
		jQuery("#dataContainer").hide();
		jQuery(".loader").show();
		var $building = jQuery("select#ddBuildings").val();
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
	});
	
});