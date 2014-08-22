<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!
public static void userSessionValidation( HttpServletRequest request, HttpServletResponse response) {
	HttpSession isSessionExist = request.getSession(false);
	Boolean isUserLoogedIn =  (Boolean)isSessionExist.getAttribute("isUserLoogedIn");
	
	String erroMessage = null;
	if(isUserLoogedIn && isSessionExist!= null){
		try{
		response.sendRedirect("/index.jsp");
		}catch(Exception e){
			//to do logging needs to be done
		}
	}else{
		erroMessage ="session inactive";
		request.setAttribute("message", erroMessage);
		try{
		response.sendRedirect("/signin.jsp");
		}catch(Exception e){
		
			//to do logging needs to be done
	
		}
	}
}
%>
</body>
</html>