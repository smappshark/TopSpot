
 
 jQuery(document).ready(function() {
		
		
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
		
		
	});