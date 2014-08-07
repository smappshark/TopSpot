function validation(){
	var firstName = document.getElementById("name").value;
	if(firstName == ""){
		alert("Please enter Name.");
		return false;
	}
	var lastName = document.getElementById("preferredName").value;
	if(lastName == ""){
		alert("Please enter preferred Name.");
		return false;
	}
	var emailId = document.getElementById("emailId").value;
	if(emailId == ""){
		alert("Please enter Email Id.");
		return false;
	}
	if(!isValidEmail(emailId)){
		alert("Please enter valid Email Id.");
		return false;
	}
	var phone = document.getElementById("phone").value;
	if(phone == ""){
		alert("Please enter phone.");
		return false;
	}
	if(!isValidMobileNumber(document.getElementById("phone"))){
		alert("Please enter valid phone number.");
		return false;
	}
	var city = document.getElementById("city").value;
	if(city == ""){
		alert("Please enter city.");
		return false;
	}

	var area = document.getElementById("area").value;
	if(area == ""){
		alert("Please enter area.");
		return false;
	}
	
	var address = document.getElementById("address").value;
	if(address == ""){
		alert("Please enter address.");
		return false;
	}
	
	var preferredComm = document.getElementById("preferredComm").value;
	if(preferredComm == ""){
		alert("Please enter preferredComm.");
		return false;
	}
	
	var country= document.getElementById("country").value;
	if(country == ""){
		alert("Please enter country.");
		return false;
	}
	
	var loginName = document.getElementById("loginName").value;
	if(loginName == ""){
		alert("Please enter Login Name.");
		return false;
	}
	
	var userType = document.getElementById("userType").value;
	if(userType == "0"){
		alert("Please select User Type.");
		return false;
	}
	
	var aboutMe = document.getElementById("aboutMe").value;
	if(aboutMe == ""){
		alert("Please enter About Me.");
		return false;
	}
		
}

function isValidEmail(email) { 
    var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return regex.test(email);
}

function isValidMobileNumber(number) {  
  var phoneno = /^\d{10}$/;  
  if((number.value.match(phoneno))) return true;  
  else   return false;  
}  







