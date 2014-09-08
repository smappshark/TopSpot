  function checkForm() {
		var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		document.getElementById("hid_datepicker").value = datepicker;
		document.getElementById("hid_datepicker1").value = datepicker1;			
		$('form').submit();
	}

  function selectedArea(selectedArea){
		$('#sel_area').val(selectedArea.trim());
		$('#hid_area').val(selectedArea.trim());
		fetchHistogramData();
  }
  
  function selectedBuilding(selectedBuilding){
		$('#histogrambuildings').val(selectedBuilding.trim());
		$('#hid_building').val(selectedBuilding.trim());
		fetchHistogramData();
}
  
  function selectedBedrooms(selectedBedroom){
		$('#bedroom').val(selectedBedroom.trim());
		$('#hid_bedroom').val(selectedBedroom.trim());
		fetchHistogramData();
}


  function autoCompleteList(textBoxId) {
		console.log("textBoxId - "+textBoxId);
		var buildingName = $('#building'+textBoxId).val();
		var buildingNameLength = buildingName.length;
		var totalLengthOfBuildingArray = buildingArray.length;
		var dynamciMethodName ='';
		var ulInnerHtml1 ='';
		$('#dynamicBuildingLi'+textBoxId).html("");
		
		if(textBoxId == 1)
			dynamciMethodName = "selectedBuildingOne";
		if(textBoxId == 2)
			dynamciMethodName = "selectedBuildingTwo";
		if(textBoxId == 3)
			dynamciMethodName = "selectedBuildingThree";
		if(textBoxId == 4)
			dynamciMethodName = "selectedBuildingFour";
		if(textBoxId == 5)
			dynamciMethodName = "selectedBuildingFive";
		
		console.log("dynamciMethodName - "+dynamciMethodName);
			
		for (var i = 0; i < totalLengthOfBuildingArray  && buildingNameLength > 1; i++) {
			if (buildingArray[i].toLowerCase().indexOf(buildingName.toLowerCase()) == 0) {
          	ulInnerHtml1 = ulInnerHtml1 + "<li><a href='#' onclick='"+dynamciMethodName+"(\"" + buildingArray[i] + "\");'>"+buildingArray[i]+"</a></li>";
			}
        }
		console.log("ulInnerHtml1 - "+ulInnerHtml1);
		  
         if(ulInnerHtml1.length > 0){
         	$('#dynamicBuildingLi'+textBoxId).append(ulInnerHtml1);
         }
	}
	
  function selectedBuildingOne(selectedBuidling){
  
  	$('#building1').val(selectedBuidling.trim());
  	//$('#buildingOne').text(selectedBuidling.trim());
  	$('#hid_Building1').val(selectedBuidling.trim());
  }
  
  function selectedBuildingTwo(selectedBuidling){
  	$('#building2').val(selectedBuidling.trim());
  	$('#hid_Building2').val(selectedBuidling.trim());
  }

  function selectedBuildingThree(selectedBuidling){
  	$('#building3').val(selectedBuidling.trim());
  	$('#hid_Building3').val(selectedBuidling.trim());
  }

  function selectedBuildingFour(selectedBuidling){
  	$('#building4').val(selectedBuidling.trim());
  	$('#hid_Building4').val(selectedBuidling.trim());
  }
  
  function selectedBuildingFive(selectedBuidling){
  	$('#building5').val(selectedBuidling.trim());
  	$('#hid_Building5').val(selectedBuidling.trim());
  }
 
  function fetchHistogramData(){
	  var isFlag = false;
	  var isBedroomFlag = false;
	  var selectedBedroom = jQuery("#bedroom").val();
	  var selectedBuilding = jQuery("#histogrambuildings").val();
	  var selectedArea = jQuery("#sel_area").val();
	  
	  if(selectedArea != "null" && selectedArea != ""){
		$('#sel_area').val(selectedArea.trim());
		isFlag = true;
	  }
	  if(selectedBuilding != "null" && selectedBuilding != ""){
		$('#histogrambuildings').val(selectedBuilding.trim());
		isFlag = true;
	  }
	  if(selectedBedroom != "null" && selectedBedroom != ""){
		$('#bedroom').val(selectedBedroom.trim());
		isBedroomFlag = true;
	  }
	  
	  if(isFlag ==  true && isBedroomFlag == true ){
      //jQuery("#bedroom").val(selectedBedroom);
      var $bedrooms = selectedBedroom;
      if ($bedrooms != "-1") {
          jQuery.get('ActionServlet', {
              serviceName: "getBedroomHistogram",
              bedrooms: selectedBedroom,
              selectedArea: selectedArea,
              selectedBuilding: selectedBuilding
          }, function(responseJson) {
             // jQuery("#dataContainer").show();
              //jQuery(".loader").hide();
             
              if (responseJson && responseJson.constructor === Array && responseJson.length > 0) {
                  var intervals = 20;
                  var minPrice = responseJson[0].Price_AED;
                  var maxPrice = responseJson[responseJson.length - 1].Price_AED;
                  var range = parseInt((maxPrice - minPrice) / intervals, 10);
                  var priceRange = [0, 0],
                      dataArray = [],
                      googleDataArray = [],
                      obj = {};
                  for (var i = 0; i <= responseJson.length; i++) {
                      if (priceRange[1] === 0) {
                          priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                      }
                      if (!obj.Range && !obj.Count) {
                          obj = {
                              Count: 0,
                              Range: ""
                          };
                      }
                      if (responseJson[i] && responseJson[i].Price_AED > priceRange[0] && responseJson[i].Price_AED <= priceRange[1]) {
                          obj.Count = obj.Count + responseJson[i].Count;
                          obj.Range = priceRange.join(",");
                      } else {
                          if (obj.Range && obj.Range != "") {
                              dataArray.push(obj);
                          }
                          obj = {
                              Count: 0,
                              Range: ""
                          };
                          if (responseJson[i]) {
                              priceRange[0] = priceRange[1];
                              priceRange[1] = parseFloat(responseJson[i].Price_AED) + range;
                              i--;
                          }
                      }
                  }
                  googleDataArray.push(["Range", "Count", { role: 'annotation' }]);
                  for (var j = 0; j < dataArray.length; j++) {
                      var tmpArray = [];
                      tmpArray.push(dataArray[j].Range);
                      tmpArray.push(dataArray[j].Count);
                      tmpArray.push(dataArray[j].Count);
                      googleDataArray.push(tmpArray);
                  }
                  drawHistogram(googleDataArray);
              }
          });
      }
	 }else if(isFlag ==  false && isBedroomFlag == true ){
		 alert("Please select area or building");
		 return false;
	 }else{
		 alert("Please select bedroom");
		 return false;
	 }
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
  
  function selectedBuildings(selectedBuilding){
		jQuery("#grtDataContainer").hide();
		//jQuery(".loader").show();
		jQuery("#buildings").val(selectedBuilding);
		var $building = selectedBuilding;
		jQuery.get('ActionServlet', {
			serviceName : "getGrowthReturnMatrixReport",
			buildingName : $building
		}, function(responseJson) {
			
			jQuery("#grtDataContainer").show();
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
  }