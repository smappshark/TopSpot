<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 String message = request.getParameter("message");
 %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Login</title>
<script>
function validate(){
 var userId = document.getElementById("userId").value;
 var Password = document.getElementById("password").value;
 var type = document.getElementById("userType").value;
    if(userId == ""){
		alert("Please enter UserId.");
		return false;
	}

	if(Password == ""){
		alert("Please enter Password.");
		return false;
	}
	
	if(type == "0"){
		alert("Please select user type.");
		return false;
	}
}

 function clearData(){
	 document.getElementById("userId").value="";
	 document.getElementById("password").value="";
 }
 </script>
</head>
<body>
	<form method="post" action="registrationServlet" onsubmit="return validate()">
		<div>User Login</div>
		<div>&nbsp;</div>
		<%
		if(message == null){
		%>
		<%}else{%>
		<div><%= message%></div>
		<%}%>
		<div>&nbsp;</div>
		<table border='0' cellspacing='4' cellpadding='6' width='45%' align='left' style='border: 1px solid #DDDDDD; border-collapse: separate; border-radius: 4px 4px 4px 4px;'>
		<tr><td width='35%'>User Id</td><td width='65%'><input type='text' name='userId' id='userId'  style='size: 255px; width: 235px;'/></td></tr>
		<tr><td width='35%'>Password</td><td width='65%'><input type='password' name='password' id='password' style='size: 255px; width: 235px;' /></td></tr>
		<tr><td width='35%'>User Type</td><td width='65%'><select id="userType" name="userType"><option value="0">--select--</option><option value='agent'>Agent</option><option value='investor'>Investor</option><option value='broker'>Broker</option><option value='admin'>Admin</option></select></td></tr>
		<tr><td  width='35%'>&nbsp;</td><td width='35%'><input type='submit' value='Submit'/>&nbsp;&nbsp;<input type='button' value='Cancel' onclick="clearData();"/></td></tr>
		</table>
		<input type="hidden" value="userLogin" id="fromPage" name="fromPage"/>
	</form>
</body>
</html>