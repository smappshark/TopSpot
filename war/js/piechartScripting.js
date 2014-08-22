    function selectedArea(areaName){
    	$('#area').text("");
    	$('#area').text(areaName);
    	$('#hid_Area').val(areaName);
    }
    
    function selectedBuildingType(buildingType){
    	$('#sel_Building_Type').text("");
    	$('#sel_Building_Type').text(buildingType);
    	$('#hid_Building_Type').val(buildingType);
    }

    function selectedBuildingStatus(buildingStatus){
    	$('#sel_Building_Status').text("");
    	$('#sel_Building_Status').text(buildingStatus);
    	$('#hid_Building_Status').val(buildingStatus);
    }
    
    function selectedStructuralMaterial(buildingMaterial){
    	$('#sel_Structural_Material').text("");
    	$('#sel_Structural_Material').text(buildingMaterial);
    	$('#hid_Structural_Material').val(buildingMaterial);
    }
    
function selectedArchitecturalStyle(architecturalStyle){
	$('#sel_Architectural_Style').text("");
	$('#sel_Architectural_Style').text(architecturalStyle);
	$('#hid_Architectural_Style').val(architecturalStyle);
    }
