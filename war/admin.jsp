<%@page import="com.topspot.register.beans.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topspot</title>
<link rel="stylesheet" href="css/styleadmin.css" type="text/css"/>
<!--#BAEDFF-->

<script>
	function getUsersList() {
		var fromPage = "adminGetUsers";
		document.location.href = 'registrationServlet?fromPage=' + fromPage;
	}
	
	
	function editUser(id){
	
		var UName="",UMailId="",UType="",UStatus="",UCreated="";
		UName=document.getElementById(id+"_name").value;
		UMailId=document.getElementById(id+"_email").value;
		
		UType=document.getElementById(id+"_type").value;
		UStatus=document.getElementById(id+"_status").value;
		UCreated=document.getElementById(id+"_created").value;
		
		document.getElementById("getusersmenu").style.display='none';
		var conentDiv = document.getElementById("content");
		conentDiv.innerHTML = "";
		var htmlContent = " <div class='container'><div class='register_wrapp'><div class='reg_title'><h1>Edit User Status</h1></div> <div class='reg_fileds_left'><table border='0' cellspacing='0' cellpadding='0' width='90%'>";
		htmlContent += "<tr><td>&nbsp;</td></tr>";
		htmlContent += "<tr><td>";
		htmlContent += "<form method='post' action='registrationServlet'><table border='0' cellspacing='4' cellpadding='6' width='100%'  style='border: 1px solid #DDDDDD; border-collapse: separate; border-radius: 4px 4px 4px 4px;margin-left:160px'>";

		htmlContent += "<tr><td width='35%'>Id</td>";
		htmlContent += "<td width='65%'><input type='text' name='user_id' id='user_id' style='size: 255px; width: 235px;' value='"+id+"' readonly='readonly'/></td></tr>";
		
		htmlContent += "<tr><td width='35%'>Name</td>";
		htmlContent += "<td width='65%'><input type='text' name='name' id='name' style='size: 255px; width: 235px;' value ='"+UName+"' readonly='readonly'/></td></tr>";

		htmlContent += "<tr><td  width='35%'>Email Id</td>";
		htmlContent += "<td width='65%'><input type='text' name='emailId' id='emailId' style='size: 255px; width: 235px;' value ='"+UMailId+"' readonly='readonly'/></td></tr>";

		htmlContent += "<tr><td  width='35%'>Role</td>";
		htmlContent += "<td width='65%'><input type='text' name='role' id='role' style='size: 255px; width: 235px;' value ='"+UType+"' readonly='readonly'/></td></tr>";
		
		htmlContent += "<tr><td  width='35%'>Status</td>";
		if(UStatus=="pending")
		htmlContent += "<td width='65%'><select id='status' name = 'status'><option value='pending' selected>Pending</option><option value='active'>Active</option></select></td></tr>";
		else  htmlContent += "<td width='65%'><select><option value='pending'>Pending</option><option value='active' selected>Active</option></select></td></tr>";
		
		htmlContent += "<tr><td  width='35%'>Created on</td>";
		htmlContent += "<td width='65%'><input type='text' name='created' id='created' style='size: 255px; width: 235px;' value ='"+UCreated+"' readonly='readonly'/></td></tr>";
		
		htmlContent += "<tr><td  width='35%'>&nbsp;</td>";
		htmlContent += "<td width='35%'><input type='hidden' value='editUserStatus' id='fromPage' name='fromPage'/> <div class='buttons'><input type='submit' value='Submit' class='btn'/></div></td></tr>";
		
		htmlContent += "</table></form>";
		htmlContent += "</td></tr></table></div></div></div></div>";
		conentDiv.innerHTML = htmlContent;
	
	}
	
		function populateUserList(){
			var conentDiv = document.getElementById("content");
			conentDiv.innerHTML = "";
			var htmlContent = "<h1>New Users List</h1><table cellpadding='3' cellspacing='1' width='100%' class='adminTbl'>";
			htmlContent += "<tr> <th>ID</th> <th>User Name</th> <th>Email ID</th> <th>Role</th> <th>Status</th> <th>Created</th> </tr>";
			
			<%
			if (request.getAttribute("usersList") != null) {

					ArrayList str = new ArrayList();
					str = (ArrayList) request.getAttribute("usersList");
					
					for (int i = 0; i < str.size(); i++) {
						UserBean ub = new UserBean();
						ub = (UserBean) str.get(i);
		   %>
		   
					htmlContent +="<tr>";
					htmlContent +="<td width='6%' style='padding: 4px 5px;'><a href='javascript:;' onclick='editUser(<%=ub.getId()%>);'><%=ub.getId()%></a></td>";
					htmlContent +="<td width='20%'><%=ub.getUsername()%><input type='hidden' id='<%=ub.getId()%>_name' value='<%=ub.getUsername()%>'/></td>";
					htmlContent +="<td width='20%'><%=ub.getEmailId()%><input type='hidden' id='<%=ub.getId()%>_email' value='<%=ub.getEmailId()%>'/></td>";
					htmlContent +="<td width='20%'><%=ub.getUserType()%><input type='hidden' id='<%=ub.getId()%>_type' value='<%=ub.getUserType()%>'/></td>";
					htmlContent +="<td width='10%'><%=ub.getStatus()%><input type='hidden' id='<%=ub.getId()%>_status' value='<%=ub.getStatus()%>'/></td>";
					htmlContent +="<td width='20%'><%=ub.getCreated() %><input type='hidden' id='<%=ub.getId()%>_created' value='<%=ub.getCreated()%>'/></td>";
					htmlContent +="</tr>";
			<%
			}
					
			}else{
			%>		
				htmlContent += "<tr><td class='lblSmall' colspan='5'>No new registered users found.</td><td>&nbsp;</td></tr>";
			<%}%>
			
			htmlContent += "</table>";
			htmlContent += "</td></tr>";
			htmlContent += "</table>";
			conentDiv.innerHTML = htmlContent;
		}
		
	
</script>
</head>

<body>
<div class="nav-wrap">
	<div class="nav">
    	<ul>
        	<li><a href="#">Charts</a></li>
            <li><a href="buildMap.jsp">Maps</a></li>
            <li><a href="#">Histogram</a></li>
            <li><a href="#">Scatter Charts</a></li>
            <li><a href="#">Mash Charts</a></li>
        </ul>
    </div>
</div>
<div class="main">
	<div class="header">
    	<div class="logo"><img src="images/topspot-logo.png"/></div>
    </div>
    <div class="container">
        <div class="admin_wrapp">
        	<div class="getusersmenu" id="getusersmenu"><a href="#" onclick="getUsersList();"><img src="images/getusers.png"/></a></div>
            <div id='content'></div>
        </div>
    </div>
</div> <!--main end-->
<div class="footer-wrap">
	<div class="footer">
    	<p style="color:#e51737; padding:5px;">For Sale,  For Rent,  For Investment,  For Advise  </p>
        <p style="color:#052f6e;">Call Top Spot   Tel: +971 4 430 6228 / Fax: +971 4 430 6229   info@topspot.ae  /  Visit us at Regal Tower,  Business Bay,  Dubai,  United Arab Emirates</p>
    </div>
</div>
</body>
<script>

	<%
	if (request.getAttribute("usersList") != null) {
	%>
	   populateUserList();
	<%}%>

	
</script>
</html>
