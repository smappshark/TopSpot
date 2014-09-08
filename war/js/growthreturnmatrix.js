jQuery(document).ready(function() {
	jQuery("#grtDataContainer").hide();
//	jQuery(".loader").show();
	function createAndReturnElementOption (value, text) {
		var option = document.createElement("option");
		option.setAttribute("value", value);
		option.innerHTML = text;
		return option;
	}
	
	
	
	/*jQuery.get('ActionServlet', {
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
			  var ulInnerHtml = '';
			  for (var key in responseJson) {
				  
	            	ulInnerHtml = ulInnerHtml + "<li><a href='#' onclick='selectedBuildings(\"" + responseJson[key] + "\");'>"+responseJson[key]+"</a></li>";
	            	
	            }
	            if(ulInnerHtml.length > 0){
	            	$('#dynamicBuildingLi').append(ulInnerHtml);
	            }
		}
	});*/
	
	jQuery('select#ddBuildings').change(function(event) {
		jQuery("#grtDataContainer").hide();
		//jQuery(".loader").show();
		var $building = jQuery("select#ddBuildings").val();
		jQuery.get('ActionServlet', {
			serviceName : "getGrowthReturnMatrixReport",
			buildingName : $building
		}, function(responseJson) {
			jQuery("#grtDataContainer").show();
			//jQuery(".loader").hide();
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