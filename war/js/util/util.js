function invokeService(apiName, method, params, onSuccess, onFailure) {
	jQuery.ajax({
		url : apiName,
		type : method,
		data : params,
		success : onSuccess,
		error : onFailure
	});
}
function trim(x) {
	return x.replace(/^\s+|\s+$/gm, '');
}
function contains(arr, v) {
	for (var i = 0; i < arr.length; i++) {
		if (arr[i] === v)
			return true;
	}
	return false;
};

function unique(arrData) {
	var arr = [];
	for (var i = 0; i < arrData.length; i++) {
		if (!contains(arr, arrData[i])) {
			arr.push(arrData[i]);
		}
	}
	return arr;
}
function sortNumber(a,b) {
    return a - b;
}
function sortArray(numArray) {
	return numArray.sort(sortNumber);
}

function autoPopulateList(textBoxId,functionName,arrayToSearch,idToAppend) {
	
	var textBoxvalue = $("#"+textBoxId).val();
	console.log("textBoxvalue - "+textBoxvalue);
	var totalLengthOfArray = arrayToSearch.length;
	console.log("totalLengthOfArray - "+totalLengthOfArray);
	console.log("arrayToSearch - "+arrayToSearch);
	var ulInnerHtml ='';
	$('#'+idToAppend).html("");
	
		
	for (var i = 0; i < totalLengthOfArray; i++) {
		console.log("indexOf "+ arrayToSearch[i].toLowerCase().indexOf(textBoxvalue.toLowerCase()));
		if (arrayToSearch[i].toLowerCase().indexOf(textBoxvalue.toLowerCase()) == 0) {
			ulInnerHtml = ulInnerHtml + "<li><a href='#' onclick='"+functionName+"(\"" + arrayToSearch[i] + "\");'>"+arrayToSearch[i]+"</a></li>";
		}
    }
	console.log("ulInnerHtml - "+ulInnerHtml);
	  
     if(ulInnerHtml.length > 0){
     	$("#"+idToAppend).append(ulInnerHtml);
     }
}