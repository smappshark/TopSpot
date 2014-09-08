package com.topspot.sessionvalidation;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserSessionValidation  {

	public static boolean validateUserSession(HttpServletRequest request,
			HttpServletResponse response) {
		
		Boolean isUserLoogedIn = false;
		HttpSession isSessionExist = request.getSession(false);
		/*System.out.println("session id" + isSessionExist.getId());*/
		
		String erroMessage = null;
		
		if(isSessionExist != null){
			isUserLoogedIn = (isSessionExist.getAttribute("isUserLoogedIn") == null) ? false : true;
			return false;
		}
		if (isUserLoogedIn) {
			try {
			//	response.sendRedirect("/index.jsp");
				return true;
			} catch (Exception e) {
				// to do logging needs to be done
				return false;
			}
		} else {
				erroMessage = "session inactive";
			request.setAttribute("erroMessage", erroMessage);
			return false;
		}
	}
	
	public static boolean inValidateUserSession(HttpServletRequest request,
			HttpServletResponse response) {
		
		HttpSession isSessionExist = request.getSession(false);
		System.out.println("session id" + isSessionExist.getId());
		isSessionExist.setAttribute("isUserLoogedIn",false);
		isSessionExist.invalidate();
		String erroMessage = "user logged out";
		request.setAttribute("erroMessage", erroMessage);
		return false;
		
	}

	
}
