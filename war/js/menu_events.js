function signout(){
    	
    	jQuery.get('ActionServlet', {
    		serviceName : "invalidateUserSession"
    	}, function(responseJson) {
    		//jQuery(".loader").hide();
    		
    		if (responseJson && responseJson.constructor === Array) {
    			console.log("responseJson -"+responseJson);
    			//session validation
    		}
    	});
    	
}

function loadHistogramChart(){
	
	$('#bedroom').val('');
	$('#histogrambuildings').val('');
	$('#sel_area').val('');
	$('#leftBlock').css('width','55%');
	
	jQuery.get('ActionServlet', {
		serviceName : "getDistinctBuildingNames"
	}, function(responseJson) {
		if (responseJson && responseJson.constructor === Object) {
			buildingArray = new Array();
			  var ulInnerHtml1 = '';
			
			  for (var key in responseJson) {
				  buildingArray.push(responseJson[key]);
				 	ulInnerHtml1 = ulInnerHtml1 + "<li><a href='#' onclick='selectedBuilding(\"" + responseJson[key] + "\");'>"+responseJson[key]+"</a></li>";
	            }
			
			  if(ulInnerHtml1.length > 0){
	            	$('#dynamicHistogramBuildingLi').append(ulInnerHtml1);
	            }
		}
	});
	setTimeout(function(){
		jQuery.get('ActionServlet', {
			serviceName : "getArea"
		}, function(responseJson) {
			//jQuery(".loader").hide();
			if (responseJson && responseJson.constructor === Object) {
				  var ulInnerHtml1 = '';
				  for (var key in responseJson) {
		             areaArray.push(responseJson[key]);
					 	ulInnerHtml1 = ulInnerHtml1 + "<li><a href='#'  onclick='selectedArea(\"" + responseJson[key] + "\");'>"+responseJson[key]+"</a></li>";
		            }
				
				  if(ulInnerHtml1.length > 0){
		            	$('#dynamicAreaLi').append(ulInnerHtml1);
		            }
			}
		});
	//loading bedrooms
	  jQuery.get('ActionServlet', {
	        serviceName: "getBedrooms"
	    }, function(responseJson) {
	        if (responseJson && responseJson.constructor === Array) {
	            var ulInnerHtml = '';
	            for (var i = 0; i < responseJson.length; i++) {
	            	bedroomsTypeArray.push(responseJson[i].Bedrooms);
	            	ulInnerHtml = ulInnerHtml + "<li><a href='#' onclick='selectedBedrooms(\"" + responseJson[i].Bedrooms + "\");'>"+responseJson[i].Bedrooms+"</a></li>";
	            }
	            if(responseJson.length > 0){
	            	$('#dynamicBedroomLi').append(ulInnerHtml);
	            }
	            $('#histogramNav').css('display','block');
	    		$('#dataContainer').css('display','block');
	    		
	    		$('#spanNearbyBuildingNameDiv').css('display','none');
	    		$('#divLinechart').css('display','none');
	    		$('#divFactSheet').css('display','none');
	    		$('#saleAndrentTrendNav').css('display','none');
	    		$('#map-canvas').css('display','none');
	    		$('#SalesAndTrendDiv').css('display','none');
	    		
	    		
	    		$('#SalesAndTrendDiv').css('display','none');
	    		$('#grtDataContainer').css('display','none');
	    		$('#growthReturnMatrixNav').css('display','none');
	    		$('#dashboradNav').css('display','none');
	    		$('#linechart').css('display','none');
	    		$('#rightBlock').css('display','none');
	    		$('#barchart').css('display','none');
	    		$('#piechart').css('display','none');
	    		$('#projectInfromationDiv').css('display','none');
	        }

	    });
	}, 1000);
}

function loadGRTChart(){
	$('#leftBlock').css('width','70%');
	jQuery.get('ActionServlet', {
		serviceName : "getDistinctBuildingNames"
	}, function(responseJson) {
		jQuery(".loader").hide();
		if (responseJson && responseJson.constructor === Object) {
			
			  var ulInnerHtml = '';
			  for (var key in responseJson) {
				  
	            	ulInnerHtml = ulInnerHtml + "<li><a href='#' onclick='selectedBuildings(\"" + responseJson[key] + "\");'>"+responseJson[key]+"</a></li>";
	            	
	            }
	            if(ulInnerHtml.length > 0){
	            	$('#dynamicBuildingLi').append(ulInnerHtml);
	            }
	            setTimeout(function(){
		            $('#growthReturnMatrixNav').css('display','block');
		    		$('#grtDataContainer').css('display','block');
		    		$('#SalesAndTrendDiv').css('display','none');
		    		
		    		$('#spanNearbyBuildingNameDiv').css('display','none');
		    		$('#divLinechart').css('display','none');
		    		$('#divFactSheet').css('display','none');
		    		$('#saleAndrentTrendNav').css('display','none');
		    		$('#map-canvas').css('display','none');
		    		$('#SalesAndTrendDiv').css('display','none');
		    		
		            $('#histogramNav').css('display','none');
		    		$('#dataContainer').css('display','none');
		    		$('#dashboradNav').css('display','none');
		    		$('#linechart').css('display','none');
		    		$('#rightBlock').css('display','none');
		    		$('#barchart').css('display','none');
		    		$('#piechart').css('display','none');
		    		$('#projectInfromationDiv').css('display','none');
	            }, 500);
		}
	});
}

function loadSalesAndTrendData(){
	$('#leftBlock').css('width','55%');
	//loading bedrooms
	  jQuery.get('ActionServlet', {
	        serviceName: "getAllAreasSubAreasBuildings"
	    }, function(d) {
	    	 if (d && d.constructor === Array && d.length > 0) {
                 
                 for (var i = 0; i < d.length; i++) {
                     for (var key in d[i]) {
                         if (key !== "Building_Type") {
                             dataForFilters.push(trim(d[i][key]));
                         } else {
                             dataForFilterType.push(trim(d[i][key]));
                         }
                     }
                 }
                 dataForFilters = unique(dataForFilters);
                 dataForFilterType = unique(dataForFilterType);
                 var ulInnerHtml = '',
                     typeInnerHtml = '';
                 for (var j = 0; j < dataForFilters.length; j++) {
                     ulInnerHtml = ulInnerHtml + "<li class='width_175'><a href='#' onclick='bindToTextboxBuilding(\"" + dataForFilters[j] + "\")'>" + dataForFilters[j] + "</a></li>";
                 }
                 for (var jk = 0; jk < dataForFilterType.length; jk++) {
                     typeInnerHtml = typeInnerHtml + "<li><a href='#' onclick='selectedBuildingType(\"" + dataForFilterType[jk] + "\");'>" + dataForFilterType[jk] + "</a></li>";
                 }
                 if (ulInnerHtml.length > 0) {
                     $('#dynamicSRBuildingLi').append(ulInnerHtml);
                 }
                 if (typeInnerHtml.length > 0) {
                     $('#dynamicSRBuildingTypeLi').append(typeInnerHtml);
                 }
             } else {
                 alert("Message: " + "Invalid Data");
             }
	    });

}

function loadDashboard(){
	$('#leftBlock').css('width','55%');
	$('#spanNearbyBuildingNameDiv').css('display','none');
	$('#divLinechart').css('display','none');
	$('#divFactSheet').css('display','none');
	$('#saleAndrentTrendNav').css('display','none');
	$('#map-canvas').css('display','none');
	$('#SalesAndTrendDiv').css('display','none');
	
	    $('#growthReturnMatrixNav').css('display','none');
		$('#grtDataContainer').css('display','none');
        $('#histogramNav').css('display','none');
		$('#dataContainer').css('display','none');
		$('#SalesAndTrendDiv').css('display','none');
		$('#dashboradNav').css('display','block');
		$('#linechart').css('display','block');
		$('#rightBlock').css('display','block');
		$('#barchart').css('display','block');
		$('#piechart').css('display','block');
		$('#projectInfromationDiv').css('display','block');
	
}

function loadSalesAndRentMap(){
	$('#leftBlock').css('width','55%');
	loadSalesAndTrendData();
	
		$('#spanNearbyBuildingNameDiv').css('display','block');
		$('#divLinechart').css('display','block');
		$('#divFactSheet').css('display','block');
		$('#saleAndrentTrendNav').css('display','block');
		$('#map-canvas').css('display','block');
		$('#SalesAndTrendDiv').css('display','block');
		
		
		$('#chartDiv').css('display','none');
		$('#growthReturnMatrixNav').css('display','none');
		$('#grtDataContainer').css('display','none');
        $('#histogramNav').css('display','none');
		$('#dataContainer').css('display','none');
		$('#dashboradNav').css('display','none');
		$('#linechart').css('display','none');
		$('#rightBlock').css('display','none');
		$('#barchart').css('display','none');
		$('#piechart').css('display','none');
		$('#projectInfromationDiv').css('display','none');
	
}