<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/user.js"></script>
<title>Topspot</title>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<!--#BAEDFF-->
</head>

<body>
<form name="frmRegistration" onsubmit="return validation();" method="post" action="registrationServlet">
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
        <div class="register_wrapp">
        	<div class="reg_title"><h1>Register</h1></div>
            <div class="reg_fileds_left">
            	<table cellpadding="4" cellspacing="0" width="100%">
                	<tr> <td>Name</td> <td><input type="text" name='name' id='name' class="text_field"/></td></tr>
                    <tr> <td>Email</td> <td><input type="text" name='emailId' id='emailId' class="text_field"/></td></tr>
                    <tr> <td>City</td> <td><input type="text" name='city' id='city' class="text_field"/></td></tr>
                   <tr> <td>Address</td> <td><textarea class="text_area" id='address' name='address'></textarea></td></tr>
                    <tr> <td>Country</td> <td><select  class="select_field" id="country" name="country"><option value="0">--select--</option><option value='dubai'>Dubai</option><option value='India'>India</option></select></td></tr>
                    <tr> <td>User Type</td> <td><select  class="select_field" id="userType" name="userType"><option value="0">--select--</option><option value='agent'>Agent</option><option value='investor'>Investor</option><option value='broker'>Broker</option><option value='admin'>Admin</option></select></td></tr>
                </table>
            </div>
            <div class="reg_fileds_right">
            	<table cellpadding="4" cellspacing="0" width="100%">
                	<tr> <td>Preferred Name</td> <td><input type="text" name='preferredName' id='preferredName' class="text_field"/></td></tr>
                    <tr> <td>Phone</td> <td><input type="text" name='phone' id='phone' class="text_field"/></td></tr>
                    <tr> <td>Area</td> <td><input type="text"   name='area' id='area' class="text_field"/></td></tr>
                    <tr> <td>pref. Comunication</td> <td><input type="text" name='preferredComm' id='preferredComm' class="text_field"/></td></tr>
                    <tr> <td>Login Name</td> <td><input type="text" name='loginName' id='loginName' class="text_field"/></td></tr>
                    <tr> <td>About Me</td> <td><textarea class="text_area" id='aboutMe' name='aboutMe'></textarea></td></tr>
                </table>
            </div>
            <div class="buttons"> <input type="submit" value="Sign In" class="btn" /> &nbsp; <input type="button" value="Cancel" class="btn_cl" /></div>
        </div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div></form>
</body>
</html>
