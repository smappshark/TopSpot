<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 String message = request.getParameter("message");
 %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Topspot</title>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<!--#BAEDFF-->

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
 <form method="post" action="registrationServlet" onsubmit="return validate()"> <div class="container">
<div class="nav-wrap">
	<div class="nav">
    	<ul>
        	<li><a href="#">Charts</a></li>
            <li><a href="buildMap.jsp">Maps</a></li>
            <li><a href="#">Histogram</a></li>
            <li><a href="#">Scatter Charts</a></li>
            <li><a href="#">Mash Charts</a></li>
            <li><a href="signin.jsp">SignIn</a></li>
        </ul>
    </div>
</div>
<div class="main">
	<div class="header">
    	<div class="logo"><img src="images/topspot-logo.png"/></div>
    </div>
  
        <div class="login_wrapp">
        	<div class="signin_title"><h1>Sign In</h1></div>
            <div class="regi_block">Don't have topspot account?  <a href="register.jsp">Register Now!</a></div>
            <div class="text_fields"><table cellpadding="4" cellspacing="0" width="100%">
            		<tr><td>Name</td> <td><input type="text" name='userId' id='userId' class="text_field"/></td></tr> 
                    <tr><td>Password</td> <td><input type="password" name='password' id='password' class="text_field"/></td></tr>
                    <tr><td>User Type</td> <td>
                    <select  class="select_field" id="userType" name="userType"><option value="0">--select--</option><option value='agent'>Agent</option><option value='investor'>Investor</option><option value='broker'>Broker</option><option value='admin'>Admin</option></select>
                    <input type="hidden" value="userLogin" id="fromPage" name="fromPage"/></td>
                    </tr> 
            	</table>
            </div>
        <%
		if(message == null){
		%>
		<%}else{%>
		<div class="err_msg"><div class="err_msg1"><%= message%></div></div>
		<%}%>
            <div class="buttons"> <input type="submit" value="Sign In" class="btn" /> &nbsp; <input type="button" value="Cancel" class="btn_cl" /></div>
        </div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>
</form>
</body>
</html>
