<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%
 String loginName = request.getParameter("loginName");
 String sessionId = request.getParameter("userSession");
 %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Topspot</title>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<!--#BAEDFF-->

<script>
function validate(){
 var password = document.getElementById("password").value;
 var confirmPassword = document.getElementById("cnfPassword").value;

	 if(password == confirmPassword){ return true;
	 }else{
	    var conentDiv = document.getElementById("errMsg");
		conentDiv.innerHTML = "Both new password and confirm password should be same.";
		clearData();
		return false;	
	}
}

 function clearData(){
	 document.getElementById("password").value="";
	 document.getElementById("cnfPassword").value="";
 }
</script>
</head>

<body><form method="post" action="registrationServlet"  onsubmit="return validate()">
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
    <div class="container">
        <div class="changepass_wrapp">
        	<div class="change_title"><h1>Change Password</h1></div>
            <div class="text_fields_change"><table cellpadding="4" cellspacing="0" width="100%">
            		<tr><td>Login Name</td> <td><input type="text" class="text_field"  name='name' id='name' value=<%=loginName%>></td></tr> 
                    <tr><td>New Password</td> <td><input type="password" class="text_field"  name='password' id='password'/></td></tr>
                    <tr><td>Confirm Password</td> <td><input type="password" class="text_field" name='cnfPassword' id='cnfPassword'/></td></tr> 
            	</table>
            </div>
            <div class="err_msg"><div id="errMsg"></div></div>
            <div class="buttons"> <input type="submit" value="Sign In" class="btn" /> &nbsp; <input type="button" value="Cancel" class="btn_cl" onclick="clearData();"/></div>
        </div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
     <input type="hidden" value="changePassword" id="fromPage" name="fromPage"/>
     <input type="hidden" value=<%=sessionId%> id="sessionId" name="sessionId"/>
</div></form>
</body>
</html>
