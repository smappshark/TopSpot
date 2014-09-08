jQuery(document).ready(function() {
	
	
	jQuery("#dataContainer").hide();
	jQuery(".loader").show();
	function createAndReturnElementOption (value, text) {
		var option = document.createElement("option");
		option.setAttribute("value", value);
		option.innerHTML = text;
		return option;
	}
	
	
	
	jQuery.get('ActionServlet', {
		serviceName : "getArea"
	}, function(responseJson) {
		//jQuery(".loader").hide();
		if (responseJson && responseJson.constructor === Object) {
			  var ulInnerHtml1 = '';
			  for (var key in responseJson) {
		//		  buildingArray.push(responseJson[key]);
				 	ulInnerHtml1 = ulInnerHtml1 + "<li><a href='#' onclick='selectedArea(\"" + responseJson[key] + "\");'>"+responseJson[key]+"</a></li>";
	            }
			
			  if(ulInnerHtml1.length > 0){
	            	$('#dynamicAreaLi').append(ulInnerHtml1);
	            }
		}
	});
	
	  jQuery('#showReport').click(function(event) {
	   //     jQuery(".loader").show();
	     // jQuery("#dataContainer").hide();
	        var $building1 = jQuery("#hid_Building1").val();
	        var $building2 = jQuery("#hid_Building2").val();
	        var $building3 = jQuery("#hid_Building3").val();
	        var $building4 = jQuery("#hid_Building4").val();
	        var $building5 = jQuery("#hid_Building5").val();
	        var $datepicker1 = jQuery("#datepicker").val();
	        var $datepicker2 = jQuery("#datepicker1").val();
	        
	        if ($building1 != "-1" || $building1 != "-1" || $building1 != "-1" || $building1 != "-1" || $building1 != "-1") {
	            jQuery.get('ActionServlet', {
	                serviceName: "getAllChartInfo",
	                buildingOne: $building1,
	                buildingTwo: $building2,
	                buildingThree: $building3,
	                buildingFour: $building4,
	                buildingFive: $building5,
	                datePickerOne :$datepicker1,
	                datePickerTwo :$datepicker2
	            }, function(responseJson) {
	            	console.log("responseJson -"+responseJson);
	               // jQuery("#dataContainer").show();
	                //jQuery(".loader").hide();
	                if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
	                	console.log("responseJson = "+responseJson);
	                }
	            });
	        }
	    });
	
});